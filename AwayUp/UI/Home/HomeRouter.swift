//
//  HomeRouter.swift
//  AwayUp
//
//  Created by Valentin Limagne on 10/09/2020.
//  Copyright © 2020 Valentin Limagne. All rights reserved.
//

import UIKit

class HomeRouter: PresenterToRouterHomeProtocol {
    static func create(userToken: UserToken) -> HomeViewController {
        let view = mainstoryboard.instantiateViewController(withIdentifier: "HomeView") as! HomeViewController
        
        let presenter: ViewToPresenterHomeProtocol = HomePresenter(userToken: userToken)
        
        view.presenter = presenter
        presenter.view = view
        
        return view
    }
    
    static var mainstoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    func pushToLogin(navigationController: UINavigationController) {
        
        let loginRouter = LoginRouter.create()
        navigationController.pushViewController(loginRouter, animated: true)
    }
}
