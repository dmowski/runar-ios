//
//  CoreDataManager.swift
//  Runar
//
//  Created by Alexey Poletaev on 27.11.2022.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager: NSObject {

    static let shared = CoreDataManager()

    private override init() {}

    // MARK: - Core Data stack
    lazy var persistentContainerForLibrary: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "LibraryCoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    lazy var persistentContainerForGenerator: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GeneratorCoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContextForLibrary() {
        let context = persistentContainerForLibrary.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func saveContextForGenerator () {
        let context = persistentContainerForGenerator.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

extension CoreDataManager {
    /// This method prints the folder URL with the stored SQL database created by CoreData
    func applicationDocumentsDirectory() {
        if let url = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).last {
            print("Core Data saved path: \(url.absoluteString)Application Support/")
        }
    }
}

// MARK: - Library
extension CoreDataManager {
    /// Get library data from Core Data
    func fetchLibraryDataFromCoreData() -> [LibraryCoreDataModel]? {
        do {
            let context = persistentContainerForLibrary.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: LibraryCoreDataModel.self))
            do {
                let objects = try context.fetch(fetchRequest) as? [LibraryCoreDataModel]
                return objects
            } catch let error {
                print("Error fetch library data : \(error)")
            }
        }
        return []
    }

    /// Create child LibraryNode models
    private func fetchLibraryNodeFromCoreData(dataNode: LibraryCoreDataModel) -> LibraryNode {
        let node = LibraryNode(item: dataNode)
        guard dataNode.children?.count != 0 else { return node }

        dataNode.childrenArray.forEach { node.add(child: fetchLibraryNodeFromCoreData(dataNode: $0)) }

        return node
    }

    /// Get the library data from Core Data and put it in the LibraryNode data model for further work with UI
    func fetchLibraryFromCoreData() -> LibraryNode {
        let libraryTree = LibraryNode()
        guard let libraryNodesCoreData = fetchLibraryDataFromCoreData() else { return libraryTree }

        for item in libraryNodesCoreData
            .filter({ $0.type == .root })
            .sorted(by: { $0.order < $1.order }) {
            libraryTree.add(child: fetchLibraryNodeFromCoreData(dataNode: item))
        }

        return libraryTree
    }

    /// Save child LibraryCoreDataModel models
    private func saveLibraryNode(parent: LibraryCoreDataModel, dataNode: LibraryNode) {
        let context = persistentContainerForLibrary.viewContext
        let node = LibraryCoreDataModel(context: context)

        node.idNode = dataNode.id
        node.imageUrl = dataNode.imageUrl
        node.linkTitle = dataNode.linkTitle
        node.linkUrl = dataNode.linkUrl
        node.title = dataNode.title
        node.tags = dataNode.tags
        node.content = dataNode.content
        node.order = Int64(dataNode.order ?? 0)
        node.type = dataNode.type
        node.parent = parent

        guard !dataNode.children.isEmpty else { return }
        dataNode.children.forEach { saveLibraryNode(parent: node, dataNode: $0) }
    }

    /// Saving the downloaded library data in Core Data
    func saveLibraryInCoreDataWith(_ dataNode: LibraryNode) {
        let context = persistentContainerForLibrary.viewContext
        guard let node = NSEntityDescription.insertNewObject(forEntityName: "LibraryCoreDataModel", into: context) as? LibraryCoreDataModel else { return }
        dataNode.children.forEach { saveLibraryNode(parent: node, dataNode: $0) }

        saveContextForLibrary()
    }

    /// Clear data from Core Data library
    func clearLibraryData() {
        do {
            let context = persistentContainerForLibrary.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: LibraryCoreDataModel.self))
            do {
                let objects = try context.fetch(fetchRequest) as? [NSManagedObject]
                objects?.forEach { context.delete($0) }
                saveContextForLibrary()
            } catch let error {
                print("ERRO DELETING : \(error)")
            }
        }
    }
}

// MARK: - Generator
extension CoreDataManager {
    private func createGeneratorRuneEntityFrom(_ node: GenerationRuneModel) {
        let context = persistentContainerForGenerator.viewContext

        guard let generatorEntity = NSEntityDescription.insertNewObject(forEntityName: "GeneratorRuneCoreDataModel",
                                                                        into: context) as? GeneratorRuneCoreDataModel,
              let generatorRuneImageEntity = NSEntityDescription.insertNewObject(forEntityName: "GeneratorRuneImageCoreDataModel",
                                                                                 into: context) as? GeneratorRuneImageCoreDataModel
        else { return }

        generatorEntity.id = node.id
        generatorEntity.title = node.title
        generatorEntity.runeDescription = node.description
        generatorRuneImageEntity.image = node.image.image.pngData()
        generatorRuneImageEntity.height = Float(node.image.height ?? 0.0)
        generatorRuneImageEntity.width = Float(node.image.width ?? 0.0)
        generatorRuneImageEntity.parent = generatorEntity
    }

    func saveGeneratorInCoreDataWith(_ nodes: [GenerationRuneModel]) {
        nodes.forEach { self.createGeneratorRuneEntityFrom($0) }

        do {
            try persistentContainerForGenerator.viewContext.save()
        } catch let error {
            print(error)
        }
    }

    func clearGeneratorData() {
        do {
            let context = persistentContainerForGenerator.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: GeneratorRuneCoreDataModel.self))
            do {
                let objects  = try context.fetch(fetchRequest) as? [NSManagedObject]
                objects?.forEach { context.delete($0) }
                saveContextForGenerator()
            } catch let error {
                print("ERROR DELETING : \(error)")
            }
        }
    }
}
