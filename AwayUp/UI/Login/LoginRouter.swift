//
//  Router.swift
//  AwayUp
//
//  Created by Valentin Limagne on 10/09/2020.
//  Copyright © 2020 Valentin Limagne. All rights reserved.
//

import UIKit

class LoginRouter: PresenterToRouterLoginProtocol {
    static func create() -> LoginViewController {
        let view = mainstoryboard.instantiateViewController(withIdentifier: "LoginView") as! LoginViewController
        
        let presenter: ViewToPresenterLoginProtocol = LoginPresenter()
        let router: PresenterToRouterLoginProtocol = LoginRouter()
        
        view.presentor = presenter
        presenter.view = view
        presenter.router = router
        
        return view
    }
    
    static var mainstoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    func pushToHome(navigationController: UINavigationController, userToken: UserToken) {
        let homeRouter = HomeRouter.create(userToken: userToken)
        navigationController.pushViewController(homeRouter, animated: true)
    }
    
}
