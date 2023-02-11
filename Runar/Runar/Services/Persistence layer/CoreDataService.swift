//
//  CoreDataService.swift
//  Runar
//
//  Created by Andrei on 11.02.2023.
//

import UIKit
import CoreData

protocol PesistenceService {
    var runes: [RuneModel] { get }
    
    func addUpdateRune(
        _ rune: RuneModel,
        completionHandler: @escaping ((Result<Void, Error>) -> Void)
    )
}

final class CoreDataService: PesistenceService {
    private let context: NSManagedObjectContext? = {
        let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer?.viewContext
        context?.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return context
    }()
    private let factory = RuneFactory()
    private let fetchRequest = CoreDataRuneModel.fetchRequest

    var runes: [RuneModel] {
        guard let context = context else { return [] }
        var runes: [RuneModel] = []
        do {
            runes = try context.fetch(fetchRequest).compactMap { factory.makeCodableRune(from: $0) }
        } catch {
            print(error.localizedDescription)
        }
        return runes
    }

    func addUpdateRune(
        _ rune: RuneModel,
        completionHandler: @escaping ((Result<Void, Error>) -> Void)
    ) {
        guard let context = context else { return }
        
        let _ = factory.makeCoreDataRune(from: rune, context: context)
        saveContext(context, completionHandler: completionHandler)
    }

    private func saveContext(
        _ context: NSManagedObjectContext,
        completionHandler: @escaping ((Result<Void, Error>) -> Void)
    ) {
        guard context.hasChanges else { return }
        do {
            try context.save()
            completionHandler(.success(()))
        } catch {
            completionHandler(.failure(error))
        }
    }
}
