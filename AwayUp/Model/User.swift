//
//  User.swift
//  AwayUp
//
//  Created by Valentin Limagne on 14/09/2020.
//  Copyright © 2020 Valentin Limagne. All rights reserved.
//

import Foundation

struct User: Codable {
    
    static var currentUser: User?
    
    let id, role: Int
    let email: String
    let accountCreate, accountUpdate: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case role
        case email
        case accountCreate = "create"
        case accountUpdate = "update"
    }
}

struct UserToken: Codable {
    let token: String
    let expiresIn: Int
    
    enum CodingKeys: String, CodingKey {
        case token = "accessToken"
        case expiresIn = "expiresIn"
    }
}
