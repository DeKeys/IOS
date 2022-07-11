//
//  CachePassword+CoreDataProperties.swift
//  
//
//  Created by Олег Рыбалко on 11.07.2022.
//
//

import Foundation
import CoreData


extension CachePassword {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachePassword> {
        return NSFetchRequest<CachePassword>(entityName: "CachePassword")
    }

    @NSManaged public var ipfsHash: String?
    @NSManaged public var pinIndex: Int16

}
