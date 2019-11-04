//
//  SavedUser+CoreDataProperties.swift
//  UsersInfo
//
//  Created by Narine Balasanyan on 11/3/19.
//  Copyright © 2019 Fifth. All rights reserved.
//
//

import Foundation
import CoreData

extension SavedUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedUser> {
        return NSFetchRequest<SavedUser>(entityName: "SavedUser")
    }

    @NSManaged public var avatarUrl: String?
    @NSManaged public var email: String?
    @NSManaged public var firstName: String?
    @NSManaged public var id: Int16
    @NSManaged public var lastName: String?
    @NSManaged public var usersList: SavedUsersList?

}
