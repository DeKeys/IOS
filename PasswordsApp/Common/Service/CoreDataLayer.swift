//
//  CoreDataLayer.swift
//  PasswordsApp
//
//  Created by Олег Рыбалко on 09.07.2022.
//

import Foundation
import CoreData
import UIKit

typealias CachedPasswords = [CachePassword]

struct CoreDataWorker {
    var context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func addPassword(password: Password) throws {
        let newPassword = CachePassword(context: context)
        newPassword.createdAt = Int32(password.createdAt)
        newPassword.password = password.password
        newPassword.ipfsHash = password.ipfsHash
        newPassword.serviceName = password.serviceName
        newPassword.login = password.login
        
        context.insert(newPassword)
        try context.save()
    }
}
