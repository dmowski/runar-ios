//
//  CoreDataModelResource.swift
//  Runar
//
//  Created by Andrei on 11.02.2023.
//

import Foundation
import CoreData

/// Convenient default interface for CoreDataModel
protocol Manageable: NSManagedObject {}

extension Manageable {
    static var entityName: String {
        String(describing: self)
    }
    static var fetchRequest: NSFetchRequest<Self> {
        NSFetchRequest<Self>(entityName: entityName)
    }

    static func entity(context: NSManagedObjectContext?) -> NSEntityDescription {
        guard let context = context else { return NSEntityDescription() }
        return NSEntityDescription.entity(forEntityName: entityName, in: context) ?? NSEntityDescription()
    }
}
