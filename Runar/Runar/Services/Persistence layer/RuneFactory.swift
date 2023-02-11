//
//  RunarFactory.swift
//  Runar
//
//  Created by Andrei on 11.02.2023.
//

import Foundation
import CoreData

/// Incapsulate CoreDataModel transforming
final class RuneFactory {
    func makeCodableRune(from coreDataRuneModel: CoreDataRuneModel) -> RuneModel {
        RuneModel(
            _id: coreDataRuneModel.id,
            childIds: coreDataRuneModel.childIds,
            imageUrl: coreDataRuneModel.imageUrl,
            content: coreDataRuneModel.content,
            title: coreDataRuneModel.title,
            audioUrl: coreDataRuneModel.audioUrl,
            audioDuration: coreDataRuneModel.audioDuration,
            linkUrl: coreDataRuneModel.linkUrl,
            linkTitle: coreDataRuneModel.linkTitle,
            tags: coreDataRuneModel.tags,
            sortOrder: Int(coreDataRuneModel.sortOrder),
            type: coreDataRuneModel.type,
            __v: Int(coreDataRuneModel.version))
    }
    
    func makeCoreDataRune(
        from runeModel: RuneModel,
        context: NSManagedObjectContext
    ) -> CoreDataRuneModel {
        CoreDataRuneModel(
            context: context,
            id: runeModel._id,
            childIds: runeModel.childIds,
            imageUrl: runeModel.imageUrl,
            content: runeModel.content,
            title: runeModel.title,
            audioUrl: runeModel.audioUrl,
            audioDuration: runeModel.audioDuration,
            linkUrl: runeModel.linkUrl,
            linkTitle: runeModel.linkTitle,
            tags: runeModel.tags,
            sortOrder: Int32(runeModel.sortOrder),
            type: runeModel.type,
            version: Int16(runeModel.__v))
    }
}
