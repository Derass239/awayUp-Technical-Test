//
//  UserDefaultsHelper.swift
//  AwayUp
//
//  Created by Valentin Limagne on 16/09/2020.
//  Copyright © 2020 Valentin Limagne. All rights reserved.
//

import Foundation

enum UserDefaultsKey: String {
    case user       = "user"
    case userToken  = "userToken"
    case loginInfo  = "loginInfo"
}

class UserDefaultsHelper {
      
    //MARK: - LoginInfo
    static func getLoginInfo() -> [String: String]? {
        let preferences = UserDefaults.standard
        let loginInfoKey = UserDefaultsKey.loginInfo.rawValue
        
        if preferences.object(forKey: loginInfoKey) == nil {
            return nil
        } else {
            return preferences.object(forKey: loginInfoKey) as? [String : String]
        }
    }
    
    static func set(loginInfo: [String: String]) {
        let preferences = UserDefaults.standard
        let loginInfoKey = UserDefaultsKey.loginInfo.rawValue
        
        preferences.set(loginInfo, forKey: loginInfoKey)
        
        let didSave = preferences.synchronize()
        
        if !didSave {
            print("UserDefaultsHelper Error : impossible to save data !")
        }
    }
    
    //MARK: - Token
    static func getToken() -> UserToken? {
        let preferences = UserDefaults.standard
        let userTokenKey = UserDefaultsKey.userToken.rawValue
        
        var userTokenData: UserToken!
        if let data = preferences.value(forKey: userTokenKey) as? Data {
            userTokenData = try? PropertyListDecoder().decode(UserToken.self, from: data)
            return userTokenData
        } else {
            return userTokenData
        }
    }
    
    static func set(UserToken: UserToken) {
        let preferences = UserDefaults.standard
        let userLoginKey = UserDefaultsKey.userToken.rawValue
        
        preferences.set(try? PropertyListEncoder().encode(UserToken), forKey: userLoginKey)
        
        let didSave = preferences.synchronize()
        
        if !didSave {
            print("UserDefaultsHelper Error : impossible to save data !")
        }
    }
    
    //MARK: - User
    static func getUser() -> User? {
        let preferences = UserDefaults.standard
        let userKey = UserDefaultsKey.user.rawValue
        
        var userData: User!
        if let data = preferences.value(forKey: userKey) as? Data {
            userData = try? PropertyListDecoder().decode(User.self, from: data)
            return userData
        } else {
            return userData
        }
    }
    
    static func set(user: User) {
        let preferences = UserDefaults.standard
        let userKey = UserDefaultsKey.user.rawValue
        
        preferences.set(try? PropertyListEncoder().encode(user), forKey: userKey)
        
        let didSave = preferences.synchronize()
        
        if !didSave {
            print("UserDefaultsHelper Error : impossible to save data !")
        }
    }
}
