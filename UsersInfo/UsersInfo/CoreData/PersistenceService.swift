//
//  PersistenceService.swift
//  UsersInfo
//
//  Created by Narine Balasanyan on 11/2/19.
//  Copyright © 2019 Fifth. All rights reserved.
//

import UIKit
import CoreData

class PersistenceService: NSObject {
    
    static let shared = PersistenceService()
    
    var context: NSManagedObjectContext { return persistentContainer.viewContext }
    var savedUsersList = [SavedUsersList]()
    var savedUsersData = [SavedUser]()
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "UsersInfo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext(withData data: UsersList) {
        let usersList = SavedUsersList(context: context)
        usersList.page = data.page
        usersList.perPage = data.perPage
        usersList.totalUsers = data.totalUsers
        usersList.totalPages = data.totalPages
        
        for user in data.userData {
            let userData = SavedUser(context: context)
            userData.id = user.id
            userData.firstName = user.firstName
            userData.lastName = user.lastName
            userData.email = user.email
            userData.avatarUrl = user.avatarUrl
            usersList.addToUsersData(userData)
        }
        save()
    }
    
    func save() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Fetch data
    
    func fetchUsersList(completion: @escaping (_ usersList: [UsersList]?) -> Void) {
        let request: NSFetchRequest<SavedUsersList> = SavedUsersList.fetchRequest()
        
        do {
            let objects = try context.fetch(request)
            savedUsersList = objects
            var usersList = [UsersList]()
            for object in objects {
                var data = UsersList(withSavedData: object)
                data.userData = fetchUsersData() ?? []
                usersList.append(data)
            }
            completion(usersList)
        } catch {
            completion(nil)
        }
    }
    
    func fetchUsersData() -> [User]? {
        let request: NSFetchRequest<SavedUser> = SavedUser.fetchRequest()
        
        do {
            let object = try context.fetch(request)
            savedUsersData = object
            let usersData = object.map { User(withSavedData: $0) }
            return usersData
        } catch {
            return nil
        }
    }
    
    // MARK: - Delete data
    
    func deleteData() {
        for object in savedUsersList {
            context.delete(object)
        }
        for data in savedUsersData {
            context.delete(data)
        }
        save()
    }
}
