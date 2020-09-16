//
//  HomeContract.swift
//  AwayUp
//
//  Created by Valentin Limagne on 10/09/2020.
//  Copyright © 2020 Valentin Limagne. All rights reserved.
//

import UIKit

protocol ViewToPresenterHomeProtocol: class {
    var view: PresenterToViewHomeProtocol? {get set}
    var router: PresenterToRouterHomeProtocol? {get set}
    
    func getData()
    func dataToString(intDate: Int) -> String
    func logout(navigationController: UINavigationController)
}

protocol PresenterToViewHomeProtocol: class {
    func changeLoading(pLoad: Bool)
    func showData(userData: User)
}

protocol PresenterToRouterHomeProtocol: class {
    static func create(userToken: UserToken) -> HomeViewController
    func pushToLogin(navigationController: UINavigationController)
}
