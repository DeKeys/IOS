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
        newPassword.pinned = false
        
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
    
    /// Function for deleting password from core data
    ///
    /// - Parameter ipfsHash: ipfsHash of password to be deleten
    /// - Throws: NSManagedObjectContext.(save or fetch) error
    func deletePassword(ipfsHash: String) throws {
        let request = CachePassword.fetchRequest()
        request.predicate = NSPredicate(format: "ipfsHash = %@", ipfsHash)
        request.fetchLimit = 1
        
        let result = try context.fetch(request)
        if let password = result.first {
            context.delete(password)
            try context.save()
        } 
    }
    
    /// Function for changing pin index of password
    ///
    /// - Parameter ipfsHash: ipfsHash of password
    /// - Parameter pinned: status of password pin
    func setPinned(ipfsHash: String, pinned: Bool) {
        let request = CachePassword.fetchRequest()
        request.predicate = NSPredicate(format: "ipfsHash = %@", ipfsHash)
        request.fetchLimit = 1
        if let password = (try? context.fetch(request))?.first {
            password.pinned = pinned
            try? context.save()
        }
    }
}
