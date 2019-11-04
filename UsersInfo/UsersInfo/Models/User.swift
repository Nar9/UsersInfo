//
//  User.swift
//  UsersInfo
//
//  Created by Narine Balasanyan on 11/2/19.
//  Copyright © 2019 Fifth. All rights reserved.
//

import Foundation

struct User {
    
    var id: Int16 = -1
    var firstName = ""
    var lastName = ""
    var email = ""
    var avatarUrl = ""
    
    init(withData data: [String : Any]) {
        self.id = data["id"] as? Int16 ?? -1
        self.firstName = data["first_name"] as? String ?? ""
        self.lastName = data["last_name"] as? String ?? ""
        self.email = data["email"] as? String ?? ""
        self.avatarUrl = data["avatar"] as? String ?? ""
    }
    
    init(withSavedData data: SavedUser) {
        self.id = data.id
        self.firstName = data.firstName ?? ""
        self.lastName = data.lastName ?? ""
        self.email = data.email ?? ""
        self.avatarUrl = data.avatarUrl ?? ""
    }
}
