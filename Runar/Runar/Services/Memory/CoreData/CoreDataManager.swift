//
//  CoreDataManager.swift
//  Runar
//
//  Created by Alexey Poletaev on 23.09.2022.
//

import Foundation
import CoreData
import UIKit

final class CoreDataManager {

    // MARK: - Properties
    static let shared = CoreDataManager()
    private let nameCoreData = "CoreData"
    var generatorIsLoaded: Bool = false
    var libraryIsLoaded: Bool = false
    private var context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: nameCoreData)
        container.loadPersistentStores { _, error in
            if let error = error {
                debugPrint("Unresolved error \(error)")
            }
        }
        return container
    }()
    private var parentContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }

    // MARK: - Override funcs
    private init() {
        context.parent = parentContext
    }

    // MARK: - Methods
    // Fetch data from core data
    private func loadData<T>(type: T.Type) -> [T] {
        var data = [T]()

        do {
            let entityName = String(describing: T.self)
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            let result = try context.fetch(fetchRequest)
            if let objects = result as? [T] {
                data = objects
            }
        } catch {
            print(error.localizedDescription)
        }

        return data
    }

    // Saving changes to core data
    private func saveContext() {
        if !context.hasChanges {
            return
        }
        do {
            try context.save()
            parentContext.performAndWait {
                do {
                    try parentContext.save()
                } catch {
                    let nserror = error as NSError
                    print("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        } catch {
            let nserror = error as NSError
            print("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}

// MARK: - Library
extension CoreDataManager {
    private func createLibraryNode(from object: LibraryData) {
        let node = LibraryCoreData(context: context)
        node.id = object.id
        node.imageUrl = object.imageUrl
        node.linkTitle = object.linkTitle
        node.linkUrl = object.linkUrl
        node.title = object.title
        node.tags = object.tags
        node.content = object.content
        node.order = Int64(object.sortOrder)
        node.type = object.type
    }

    func createLibrary(fromData data: Data) {
        guard let libraryData = try? JSONDecoder().decode([LibraryData].self, from: data) else {
            fatalError("No Data")
        }

        // Create core data objects from LibraryData
        for object in libraryData {
            createLibraryNode(from: object)
        }

        // Get an array of created core date objects of type LibraryCoreData
        let allNodes = fetchAllLibraryNodes()

        // Running on LibraryData array
        // Take elements only with non-empty child arrays (childIds)
        for structObject in libraryData where !structObject.childIds.isEmpty {

            // Running through childIds of String type
            // Find the child element in the array of core data objects (allNodes)
            // with the corresponding id (structObjects.id)
            structObject.childIds.forEach { strChild in
                let childNode = allNodes.first { $0.id == strChild }
                let parentNode = allNodes.first { $0.id == structObject.id }

                guard let childNode = childNode else { return }
                // Assign Child to NSSet parent
                // And parent to child
                parentNode?.addToChildren(childNode)
                childNode.parent = parentNode
            }
        }
        saveContext()
    }

    // Fetch all Library nodes
    func fetchAllLibraryNodes() -> [LibraryCoreData] {
        var nodes: [LibraryCoreData] = []
        context.performAndWait {
            nodes = loadData(type: LibraryCoreData.self)
        }
        return nodes
    }

    // Fetch all root Library nodes
    func fetchRootLibraryNodes() -> [LibraryCoreData] {
        return fetchAllLibraryNodes()
            .filter { $0.type == LibraryNodeType.root.rawValue }
            .sorted { $0.order < $1.order }
    }

    // Delete all Library nodes
    func deleteAllLibraryNodes() {
        context.performAndWait {
            let nodes = loadData(type: LibraryCoreData.self)
            for node in nodes {
                context.delete(node)
            }
            saveContext()
        }
    }
}

// MARK: - Generator
extension CoreDataManager {
    private func createGeneratorNode(from object: RuneData) {
            let node = GeneratorCoreData(context: context)
            let runeImage = GeneratorRuneImage(context: context)
            node.id = String(object.id)
            node.title = object.getInfo().title
            node.descriptionRune = object.getInfo().description
            let pngImageData = UIImage.create(fromUrl: object.imageUrl)?.pngData()
            runeImage.image = pngImageData
            runeImage.height = 70
            runeImage.width = 56
            node.runeImage = runeImage
            saveContext()
    }

    func createGenerator(fromData data: Data) {
        guard let runesData = try? JSONDecoder().decode([RuneData]?.self, from: data) else { fatalError("No Data") }

        // Create core data objects from LibraryData
        for rune in runesData {
            createGeneratorNode(from: rune)
        }
    }

    // Delete all Generator nodes
    func deleteAllGeneratorNodes() {
        context.performAndWait {
            let nodes = loadData(type: GeneratorCoreData.self)
            for node in nodes {
                context.delete(node)
            }
            saveContext()
        }
    }

    // Fetch all Generator nodes
    func fetchAllGeneratorNodes() -> [GeneratorCoreData] {
        var nodes: [GeneratorCoreData] = []
        context.performAndWait {
            nodes = loadData(type: GeneratorCoreData.self)
        }
        return nodes
    }
}
