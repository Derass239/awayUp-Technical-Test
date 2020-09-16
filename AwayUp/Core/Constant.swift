//
//  Constant.swift
//  AwayUp
//
//  Created by Valentin Limagne on 16/09/2020.
//  Copyright © 2020 Valentin Limagne. All rights reserved.
//

import Foundation

struct APIPath {

    static let login    = baseURL+"auth"
    static let user     = baseURL+"user/myself"
    
    static var baseURL: String {
        let baseUrl = Bundle.main.object(forInfoDictionaryKey: "API_URL") as? String
        if baseUrl != nil && !(baseUrl?.isEmpty)! {
            return baseUrl!
        }
        
        return ""
    }
}
