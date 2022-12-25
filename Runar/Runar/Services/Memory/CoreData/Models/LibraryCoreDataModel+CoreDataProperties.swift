//
//  LibraryCoreDataModel+CoreDataProperties.swift
//  
//
//  Created by Alexey Poletaev on 11.12.2022.
//
//

import Foundation
import CoreData


extension LibraryCoreDataModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LibraryCoreDataModel> {
        return NSFetchRequest<LibraryCoreDataModel>(entityName: "LibraryCoreDataModel")
    }

    @NSManaged public var content: String?
    @NSManaged public var idNode: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var linkTitle: String?
    @NSManaged public var linkUrl: String?
    @NSManaged public var order: Int64
    @NSManaged public var tags: [String]?
    @NSManaged public var title: String?
    @NSManaged public var typeNode: String?
    @NSManaged public var children: NSSet?
    @NSManaged public var parent: LibraryCoreDataModel?

}

extension LibraryCoreDataModel {
    var id: String {
        return idNode ?? ""
    }

    var type: LibraryNodeType {
        get {
            guard let typeNode = typeNode,
                  let type = LibraryNodeType(rawValue: typeNode) else { return .undefined }
            return type
        }
        set {
            typeNode = newValue.rawValue
        }
    }

    var childrenArray: [LibraryCoreDataModel] {
        get {
            let childrenSet = children as? Set<LibraryCoreDataModel> ?? []
            return childrenSet.sorted { $0.order < $1.order }
        }

        set {
            children = NSSet(array: newValue)
        }
    }
}

// MARK: Generated accessors for children
extension LibraryCoreDataModel {

    @objc(addChildrenObject:)
    @NSManaged public func addToChildren(_ value: LibraryCoreDataModel)

    @objc(removeChildrenObject:)
    @NSManaged public func removeFromChildren(_ value: LibraryCoreDataModel)

    @objc(addChildren:)
    @NSManaged public func addToChildren(_ values: NSSet)

    @objc(removeChildren:)
    @NSManaged public func removeFromChildren(_ values: NSSet)

}
