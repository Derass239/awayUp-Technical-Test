//
//  RequestManager.swift
//  AwayUp
//
//  Created by Valentin Limagne on 14/09/2020.
//  Copyright © 2020 Valentin Limagne. All rights reserved.
//

import Foundation
import Alamofire

class RequestManager {
    
    static let sharedInstance = RequestManager()
    private init() {}

    var sessionManager = Alamofire.Session.default
    var headers: HTTPHeaders = [
        "Content-Type": "application/json"]
    
    private func performRequest<T:Decodable>(_ url: URLConvertible,
                                             method: HTTPMethod = .get,
                                             parameters: Parameters? = nil,
                                             decoder: JSONDecoder = JSONDecoder(),
                                             completion:@escaping(AFResult<T>)-> Void) -> DataRequest {
        
        let encoding: ParameterEncoding = method == .get ? URLEncoding.default : JSONEncoding.default
        
        return AF.request(
            url,
            method: method,
        parameters: parameters,
        encoding: encoding,
        headers: headers).validate(statusCode: 200..<300)
            .responseDecodable (decoder: decoder) { (response: DataResponse<T, AFError>) in
                completion(response.result)
        }
    }
    
    func login(username: String, password: String, completion:@escaping(AFResult<UserToken>) -> Void) {
        
        _ = performRequest(APIPath.login,
                           method: .post,
                           parameters: ["email": username, "password": password],
                           completion: completion)
    }
    
    func getUserData(token: String, completion:@escaping(AFResult<User>) -> Void) {
        
        let authorizationHeader = "bearer" + " " + token
        
        headers.add(HTTPHeader(name: "Authorization", value: authorizationHeader))
        
        _ = performRequest(APIPath.user,
                           method: .get,
                           completion: completion)
    }
}
