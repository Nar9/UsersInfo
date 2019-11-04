//
//  ApiManager.swift
//  UsersInfo
//
//  Created by Narine Balasanyan on 11/2/19.
//  Copyright © 2019 Fifth. All rights reserved.
//

import Foundation
import Alamofire

class ApiManager: NSObject {
    
    static let shared = ApiManager()
    
    public func getUsersList(page: Int16, completion: @escaping (_ isSuccess: Bool, _ usersList: UsersList?, _ errorMessage: String?) -> Void) {
        Alamofire.request(ApiRouter.getUsersList(page: Int(page))).response { response in
            guard let data = response.data else {
                completion(false, nil, ErrorMessages.defaultErrorTitle)
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                if let jsonData = json {
                    let usersList = UsersList(withData: jsonData)
                    completion(true, usersList, nil)
                } else {
                    completion(false, nil, ErrorMessages.defaultErrorTitle)
                }
            } catch {
                completion(false, nil, ErrorMessages.defaultErrorTitle)
            }
        }
    }
}
