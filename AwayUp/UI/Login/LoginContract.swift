//
//  LoginContract.swift
//  AwayUp
//
//  Created by Valentin Limagne on 10/09/2020.
//  Copyright © 2020 Valentin Limagne. All rights reserved.
//

import UIKit

protocol ViewToPresenterLoginProtocol: class {
    
    var view: PresenterToViewLoginProtocol? {get set}
    var router: PresenterToRouterLoginProtocol? {get set}
    
    func startLogin(username: String, password: String)
    func showHome(navigationController: UINavigationController, userToken: UserToken)
}

protocol PresenterToViewLoginProtocol: class {
    func changeLoading(pLoad: Bool)
    func showError(pError: String)
    func showHomeVC(userToken: UserToken)
}

protocol PresenterToRouterLoginProtocol: class {
    static func create() -> LoginViewController
    func pushToHome(navigationController: UINavigationController, userToken: UserToken)
}
