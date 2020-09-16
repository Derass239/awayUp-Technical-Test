//
//  GetUserInteractor.swift
//  AwayUp
//
//  Created by Valentin Limagne on 15/09/2020.
//  Copyright © 2020 Valentin Limagne. All rights reserved.
//

import Foundation

class GetUserInteractor {
    
    func run(token: String, onSuccess success: @escaping(_ User: User) -> Void, onFailure failure: @escaping (_ error: Error?) -> Void) {
        
        let lRequest = RequestManager.sharedInstance
        lRequest.getUserData(token: token) { (result) in
            switch result {
            case .success(let userData):
                success(userData)
            case .failure(let error):
                failure(error)
                return
            }
        }
        
    }
    
    func postLogin(email: String, password: String, onSuccess success: @escaping(_ UserToken: UserToken) -> Void, onFailure failure: @escaping(_ error: Error?) -> Void) {
        
        let lRequest = RequestManager.sharedInstance
        lRequest.login(username: email, password: password) { (result) in
            switch result {
            case .success(let userLogin):
                success(userLogin)
            case .failure(let error):
                failure(error)
                return
            }
        }
    }
}
