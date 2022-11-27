//
//  CoreDataManager.swift
//  Runar
//
//  Created by Alexey Poletaev on 27.11.2022.
//

import Foundation
import CoreData

class CoreDataManager: NSObject {

    static let shared = CoreDataManager()

    private override init() {}

    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
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
    func applicationDocumentsDirectory() {
        // The directory the application uses to store the Core Data store file.
        if let url = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).last {
            print(url.absoluteString)
        }
    }
}

// MARK: - Generator
extension CoreDataManager {
    private func createGeneratorRuneEntityFrom(_ node: GenerationRuneModel) {
        let context = CoreDataManager.shared.persistentContainer.viewContext

        guard let generatorEntity = NSEntityDescription.insertNewObject(forEntityName: "GeneratorRuneCoreDataModel", into: context) as? GeneratorRuneCoreDataModel,
              let generatorRuneImageEntity = NSEntityDescription.insertNewObject(forEntityName: "GeneratorRuneImageCoreDataModel", into: context) as? GeneratorRuneImageCoreDataModel else { return }

        generatorEntity.id = node.id
        generatorEntity.title = node.title
        generatorEntity.runeDescription = node.description
        generatorRuneImageEntity.image = node.image.image.pngData()
        generatorRuneImageEntity.height = Float(node.image.height ?? 0.0)
        generatorRuneImageEntity.width = Float(node.image.width ?? 0.0)
        generatorEntity.runeImage = generatorRuneImageEntity
    }

    func saveInCoreDataWith(_ nodes: [GenerationRuneModel]) {
        nodes.forEach { self.createGeneratorRuneEntityFrom($0) }

        do {
            try CoreDataManager.shared.persistentContainer.viewContext.save()
        } catch let error {
            print(error)
        }
    }

    func clearGeneratorData() {
        do {
            let context = CoreDataManager.shared.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: GeneratorRuneCoreDataModel.self))
            do {
                let objects  = try context.fetch(fetchRequest) as? [NSManagedObject]
                print("Objects count: ", objects?.count as Any)
                _ = objects.map{$0.map{context.delete($0)}}
                CoreDataManager.shared.saveContext()
            } catch let error {
                print("ERROR DELETING : \(error)")
            }
        }
    }
}
