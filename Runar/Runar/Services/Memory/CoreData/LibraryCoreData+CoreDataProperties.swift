//
//  LibraryCoreData+CoreDataProperties.swift
//  
//
//  Created by Alexey Poletaev on 24.09.2022.
//
//

import Foundation
import CoreData


extension LibraryCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LibraryCoreData> {
        return NSFetchRequest<LibraryCoreData>(entityName: "LibraryCoreData")
    }

    @NSManaged public var id: String
    @NSManaged public var imageUrl: String?
    @NSManaged public var linkTitle: String?
    @NSManaged public var linkUrl: String?
    @NSManaged public var title: String?
    @NSManaged public var content: String?
    @NSManaged public var order: Int64
    @NSManaged public var type: String
    @NSManaged public var tags: [String]?
    @NSManaged public var children: NSSet?
    @NSManaged public var parent: LibraryCoreData?

    func add(child: LibraryCoreData) {
        var childArray = self.children?.allObjects as? [LibraryCoreData]
        childArray?.append(child)
        self.children = NSSet(array: childArray!)
        child.parent = self
    }

}

// MARK: Generated accessors for children
extension LibraryCoreData {

    @objc(addChildrenObject:)
    @NSManaged public func addToChildren(_ value: LibraryCoreData)

    @objc(removeChildrenObject:)
    @NSManaged public func removeFromChildren(_ value: LibraryCoreData)

    @objc(addChildren:)
    @NSManaged public func addToChildren(_ values: NSSet)

    @objc(removeChildren:)
    @NSManaged public func removeFromChildren(_ values: NSSet)

}
