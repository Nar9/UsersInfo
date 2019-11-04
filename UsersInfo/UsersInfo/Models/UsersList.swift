//
//  UsersList.swift
//  UsersInfo
//
//  Created by Narine Balasanyan on 11/2/19.
//  Copyright © 2019 Fifth. All rights reserved.
//

import Foundation

struct UsersList {
    
    var page: Int16 = -1
    var perPage: Int16 = 0
    var totalUsers: Int16 = 0
    var totalPages: Int16 = 0
    var userData = [User]()
    
    init(withData data: [String : Any]) {
        self.page = data["page"] as? Int16 ?? -1
        self.perPage = data["per_page"] as? Int16 ?? 0
        self.totalUsers = data["total"] as? Int16 ?? 0
        self.totalPages = data["total_pages"] as? Int16 ?? 0
        if let userData = data["data"] as? [[String : Any]] {
            self.userData = userData.map { User(withData: $0) }
        }
    }
    
    init(withSavedData data: SavedUsersList) {
        self.page = data.page
        self.perPage = data.perPage
        self.totalUsers = data.totalUsers
        self.totalPages = data.totalPages
    }
}
