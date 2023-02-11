//
//  CoreDataRunar.swift
//  Runar
//
//  Created by Andrei on 11.02.2023.
//

import Foundation
import CoreData

class CoreDataRuneModel: NSManagedObject, Identifiable, Manageable {
    @NSManaged var id: String
    @NSManaged var childIds: [String]
    @NSManaged var imageUrl: String
    @NSManaged var content: String
    @NSManaged var title: String
    @NSManaged var audioUrl: String?
    @NSManaged var audioDuration: String?
    @NSManaged var linkUrl: String
    @NSManaged var linkTitle: String
    @NSManaged var tags: [String]?
    @NSManaged var sortOrder: Int32
    @NSManaged var type: String
    @NSManaged var version: Int16

    convenience init(
        context: NSManagedObjectContext,
        id: String,
        childIds: [String],
        imageUrl: String,
        content: String,
        title: String,
        audioUrl: String?,
        audioDuration: String?,
        linkUrl: String,
        linkTitle: String,
        tags: [String]?,
        sortOrder: Int32,
        type: String,
        version: Int16
    ) {
        self.init(entity: CoreDataRuneModel.entity(context: context), insertInto: context)
        self.id = id
        self.childIds = childIds
        self.imageUrl = imageUrl
        self.content = content
        self.title = title
        self.audioUrl = audioUrl
        self.audioDuration = audioDuration
        self.linkUrl = linkUrl
        self.linkTitle = linkTitle
        self.tags = tags
        self.sortOrder = sortOrder
        self.type = type
        self.version = version
    }
}
