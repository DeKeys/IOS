//
//  CoreDataLayer.swift
//  PasswordsApp
//
//  Created by Олег Рыбалко on 09.07.2022.
//

import Foundation
import CoreData
import UIKit

struct CoreDataWorker {
    var context: NSManagedObjectContext {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Cannot find AppDelegate.")
        }
        return appDelegate.persistentContainer.viewContext
    }
    
    /// Function for adding password to the core data
    ///
    /// - Parameter password: password entity
    /// - Throws: NSManagedObjectContext.save error
    func addPassword(ipfsHash: String) throws {
        let newPassword = CachePassword(context: context)
        newPassword.ipfsHash = ipfsHash
        newPassword.pinIndex = -1
        
        context.insert(newPassword)
        try context.save()
    }
    
    /// Function for retrieving passwords from core data
    ///
    /// - Throws: NSManagedObjectContext.fetch error
    /// - Returns: array of passwords from core data
    func fetchPasswords() throws -> [CachePassword] {
        return try context.fetch(CachePassword.fetchRequest())
    }
}
