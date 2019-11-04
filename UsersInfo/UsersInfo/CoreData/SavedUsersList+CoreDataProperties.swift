//
//  SavedUsersList+CoreDataProperties.swift
//  UsersInfo
//
//  Created by Narine Balasanyan on 11/3/19.
//  Copyright © 2019 Fifth. All rights reserved.
//
//

import Foundation
import CoreData

extension SavedUsersList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedUsersList> {
        return NSFetchRequest<SavedUsersList>(entityName: "SavedUsersList")
    }

    @NSManaged public var page: Int16
    @NSManaged public var perPage: Int16
    @NSManaged public var totalPages: Int16
    @NSManaged public var totalUsers: Int16
    @NSManaged public var usersData: [SavedUser]

}

// MARK: Generated accessors for usersData
extension SavedUsersList {

    @objc(addUsersDataObject:)
    @NSManaged public func addToUsersData(_ value: SavedUser)

    @objc(removeUsersDataObject:)
    @NSManaged public func removeFromUsersData(_ value: SavedUser)

}
