//
//  HomeViewController.swift
//  AwayUp
//
//  Created by Valentin Limagne on 10/09/2020.
//  Copyright © 2020 Valentin Limagne. All rights reserved.
//

import UIKit
import MessageUI

class HomeViewController: UIViewController {
    
    var presenter: ViewToPresenterHomeProtocol?
    
    @IBOutlet weak var mActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var roleImageView: UIImageView!
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var createDateLabel: UILabel!
    @IBOutlet weak var updateDataLabel: UILabel!
    @IBOutlet weak var userIdLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUi()
        
        presenter?.getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func initUi() {
        let emailTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(contactEmail))
        mailLabel.isUserInteractionEnabled = true
        mailLabel.addGestureRecognizer(emailTapGestureRecognizer)
        
        let rotateImageGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(rotateImg))
        roleImageView.isUserInteractionEnabled = true
        roleImageView.addGestureRecognizer(rotateImageGestureRecognizer)
    }
    
    @objc func rotateImg() {
        roleImageView.rotate()
    }
    
    @objc func contactEmail() {
        let recipientEmail = mailLabel.text!
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([recipientEmail])

            self.present(mail, animated: true)
        }
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        presenter?.logout(navigationController: self.navigationController!)
    }
}

extension HomeViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}

extension HomeViewController: PresenterToViewHomeProtocol {
    
    func showData(userData: User) {
        
        if userData.role == 0 {
            roleImageView.image = UIImage(named: "lion")
        } else {
            roleImageView.image = UIImage(named: "fish")
        }
        
        mailLabel.text = userData.email
        createDateLabel.text = presenter?.dataToString(intDate: userData.accountCreate)
        updateDataLabel.text = presenter?.dataToString(intDate: userData.accountUpdate)
        userIdLabel.text = "ID : \(userData.id)"
        
    }
    
    func changeLoading(pLoad: Bool) {
        if pLoad {
            self.mActivityIndicator.startAnimating()
        } else {
            self.mActivityIndicator.stopAnimating()
        }
    }
}
