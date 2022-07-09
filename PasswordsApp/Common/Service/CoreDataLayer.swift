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
    
    /// Function for adding password to the core data
    ///
    /// - Parameter password: password entity
    /// - Throws: NSManagedObjectContext.save error
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
    
    /// Function for retrieving passwords from core data
    ///
    /// - Throws: NSManagedObjectContext.fetch error
    func fetchPasswords() throws -> CachedPasswords {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CachePassword")
        let passwords = try context.fetch(request) as! CachedPasswords
        return passwords
    }
    
    /// Function for retrieving one password from core data
    ///
    /// - Returns: found password or nil
    func fetchPassword(password: Password, fields: [Password.CodingKeys]?) -> CachePassword? {
        let request: NSFetchRequest<CachePassword>
        request = CachePassword.fetchRequest()
        
        var predicates = [NSPredicate]()
        
        if let fields = fields {
            for f in fields {
                switch f {
                case .login:
                    predicates.append(NSPredicate(format: "login = %@", password.login))
                case .password:
                    predicates.append(NSPredicate(format: "password = %@", password.password))
                case .serviceName:
                    predicates.append(NSPredicate(format: "serviceName = %@", password.serviceName))
                case .ipfsHash:
                    predicates.append(NSPredicate(format: "ipfsHash = %@", password.ipfsHash))
                case .createdAt:
                    predicates.append(NSPredicate(format: "createdAt = %@", password.createdAt))
                }
            }
        }
        
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        
        do {
            return try context.fetch(request).first
        } catch {
            return nil
        }
    }
}
