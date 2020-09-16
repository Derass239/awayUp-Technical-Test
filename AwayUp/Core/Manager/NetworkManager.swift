//
//  NetworkManager.swift
//  AwayUp
//
//  Created by Valentin Limagne on 14/09/2020.
//  Copyright © 2020 Valentin Limagne. All rights reserved.
//

import Alamofire

class NetworkManager {
    class func isConnected() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

