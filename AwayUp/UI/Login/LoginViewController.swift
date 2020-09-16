//
//  LoginViewController.swift
//  AwayUp
//
//  Created by Valentin Limagne on 10/09/2020.
//  Copyright © 2020 Valentin Limagne. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var presentor: ViewToPresenterLoginProtocol?
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var eyeImageView: UIImageView!
    @IBOutlet weak var remindMeSwitch: UISwitch!
    @IBOutlet weak var mActivity: UIActivityIndicatorView!
    @IBOutlet weak var loginTopLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var mainTopLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var errorLabel: UILabel!
    
    fileprivate var isShowPassword: Bool = false
    fileprivate var fieldsAreBrinedgUp: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (self.presentor == nil) {
            let presenter: ViewToPresenterLoginProtocol = LoginPresenter()
            let router: PresenterToRouterLoginProtocol = LoginRouter()
            
            self.presentor = presenter
            presenter.view = self
            presenter.router = router
        }
        
        if let userData = UserDefaultsHelper.getLoginInfo() {
            self.usernameTextField.text = userData["email"]
            self.passwordTextField.text = userData["password"]
            self.remindMeSwitch.setOn(true, animated: false)
            
            let timeLastLogin = userData["timeLogin"]
            
            if let token = UserDefaultsHelper.getToken() {
                let nowTime = Double(Date().timeIntervalSince1970)
                let oldTime = Double(timeLastLogin!) ?? 0
                
                if (nowTime < oldTime + Double(token.expiresIn)) {
                    presentor?.startLogin(username: userData["email"]!, password: userData["password"]!)
                }
            }
        }
        
        initUi()
        
        self.hideKeyboardWhenTappedArroud()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func initUi() {
        NotificationCenter.default.addObserver(self, selector: #selector(startBringUpFieldsAnimation), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(startBringDownFieldsAnimation), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let showPassordTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showPassword))
        eyeImageView.isUserInteractionEnabled = true
        eyeImageView.addGestureRecognizer(showPassordTapGestureRecognizer)
    }
    
    @IBAction func loginButton(_ sender: Any) {
        guard let username = usernameTextField.text, !username.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            print("Une erreur c'est produite")
            return
        }
        
        if (remindMeSwitch.isOn) {
            UserDefaultsHelper.set(loginInfo: ["email":username, "password":password, "timeLogin": "\(Date().timeIntervalSince1970)"])
        }
        
        presentor?.startLogin(username: username, password: password)
    }
    
    @objc fileprivate func startBringUpFieldsAnimation() {
        guard !fieldsAreBrinedgUp else {
            return
        }
        
        fieldsAreBrinedgUp = true
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0.5,
            options: UIView.AnimationOptions.curveEaseInOut,
            animations: {
                self.loginTopLayoutConstraint.isActive = true
                self.mainTopLayoutConstraint.constant = 32
                self.view.layoutIfNeeded()
        })
    }
    
    @objc fileprivate func startBringDownFieldsAnimation() {
        guard fieldsAreBrinedgUp else {
            return
        }
        
        fieldsAreBrinedgUp = false
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0.5,
            options: UIView.AnimationOptions.curveEaseInOut,
            animations: {
                self.loginTopLayoutConstraint.isActive = false
                self.mainTopLayoutConstraint.constant = 64
                self.view.layoutIfNeeded()
        })
    }
    
    @objc fileprivate func showPassword() {
        passwordTextField.isSecureTextEntry.toggle()
        
        if isShowPassword {
            eyeImageView.image = UIImage(named: "eyeClose")
            eyeImageView.tintColor = .lightGray
        } else {
            eyeImageView.image = UIImage(named: "eyeOpen")
            eyeImageView.tintColor = .lightGray
        }
        
        isShowPassword = !isShowPassword
    }
}

extension LoginViewController: PresenterToViewLoginProtocol {
    func showHomeVC(userToken: UserToken) {
        if let navigation = self.navigationController {
            presentor?.showHome(navigationController: navigation, userToken: userToken)
        }
    }
    
    func changeLoading(pLoad: Bool) {
        if pLoad {
            self.view.isUserInteractionEnabled = false
            self.mActivity.startAnimating()
        } else {
            self.view.isUserInteractionEnabled = true
            self.mActivity.stopAnimating()
        }
    }
    
    func showError(pError: String) {
        self.errorLabel.isHidden = false
        self.errorLabel.text = pError
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.errorLabel.isHidden = true
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTextField {
            textField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            textField.resignFirstResponder()
        }
        
        return true
    }
}
