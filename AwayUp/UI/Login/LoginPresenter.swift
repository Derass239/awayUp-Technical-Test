//
//  LoginPresenter.swift
//  AwayUp
//
//  Created by Valentin Limagne on 10/09/2020.
//  Copyright © 2020 Valentin Limagne. All rights reserved.
//

import UIKit

class LoginPresenter: ViewToPresenterLoginProtocol {
    
    var interactor: GetUserInteractor?
    
    var view: PresenterToViewLoginProtocol?
    var router: PresenterToRouterLoginProtocol?
    
    init() {
        let interactor: GetUserInteractor = GetUserInteractor()
        self.interactor = interactor
    }
    
    func startLogin(username: String, password: String) {
        self.view?.changeLoading(pLoad: true)
        
        if NetworkManager.isConnected() {
            interactor?.postLogin(email: username, password: password, onSuccess: { (data) in
                
                UserDefaultsHelper.set(UserToken: data)
                
                self.view?.showHomeVC(userToken: data)
                self.view?.changeLoading(pLoad: false)
            }, onFailure: { (error) in
                self.view?.showError(pError: "Adresse email ou mot de passe incorrect !")
                self.view?.changeLoading(pLoad: false)
            })
        } else {
            if let userCredential = UserDefaultsHelper.getLoginInfo() {
                if userCredential["email"] == username && userCredential["password"] == password {
                    let token = UserDefaultsHelper.getToken()
                    self.view?.showHomeVC(userToken: token!)
                    self.view?.changeLoading(pLoad: false)
                }
            }
        }
    }
    
    func showHome(navigationController: UINavigationController, userToken: UserToken) {
        router?.pushToHome(navigationController: navigationController, userToken: userToken)
    }
}
