//
//  HomePresenter.swift
//  AwayUp
//
//  Created by Valentin Limagne on 10/09/2020.
//  Copyright © 2020 Valentin Limagne. All rights reserved.
//

import UIKit

class HomePresenter: ViewToPresenterHomeProtocol {
    
    var interactor: GetUserInteractor?
    
    var view: PresenterToViewHomeProtocol?
    var router: PresenterToRouterHomeProtocol?
    
    var userToken: UserToken?
    
    init(userToken: UserToken) {
        let interactor: GetUserInteractor = GetUserInteractor()
        self.interactor = interactor
        self.userToken = userToken
    }
    
    func getData() {
        self.view?.changeLoading(pLoad: true)
        
        guard let safeToken = self.userToken?.token else {
            return
        }
        
        if NetworkManager.isConnected() {
            interactor?.run(token: safeToken, onSuccess: { (data) in
                UserDefaultsHelper.set(user: data)
                self.view?.showData(userData: data)
                self.view?.changeLoading(pLoad: false)
            }, onFailure: { (error) in
                self.view?.changeLoading(pLoad: false)
            })
        } else {
            if let user = UserDefaultsHelper.getUser() {
                
                self.view?.showData(userData: user)
                self.view?.changeLoading(pLoad: false)
            }
        }
    }
    
    func dataToString(intDate: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(intDate))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let strDate = dateFormatter.string(from: date)
        
        return strDate
    }
    
    func logout(navigationController: UINavigationController) {
        router?.pushToLogin(navigationController: navigationController)
    }
}
