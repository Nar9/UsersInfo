//
//  ApiRouter.swift
//  UsersInfo
//
//  Created by Narine Balasanyan on 11/2/19.
//  Copyright © 2019 Fifth. All rights reserved.
//

import Foundation
import Alamofire

enum ApiRouter: URLRequestConvertible {
    
    case getUsersList(page: Int)
    
    public func asURLRequest() throws -> URLRequest {
        let result: (url: String, method: Alamofire.HTTPMethod, parameters: [String : Any]?) = {
            switch self {
            case .getUsersList(let page):
                let url = ApiUrls.baseURL + ApiUrls.usersList + "\(page)"
                return (url, .get, nil)
            }
        }()
        
        let url = try result.url.asURL()
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = result.method.rawValue
        urlRequest.timeoutInterval = TimeInterval(50)
        
        let encoding = URLEncoding.default
        return try encoding.encode(urlRequest, with: result.parameters)
    }
}
