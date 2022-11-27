//
//  DataManager.swift
//  Runar
//
//  Created by Alexey Poletaev on 14.11.2022.
//

import UIKit
import CoreData

final class DataManager {
    static let shared = DataManager()

    var generatorIsLoaded: Bool = false
    var libraryIsLoaded: Bool = false

    // Download data when launching the application
    func fetchData() {
        // Get library data on background queue
        DispatchQueue.global(qos: .userInteractive).async {
            self.loadLibraryData()

            // Update SelectionRuneVC on main queue
            DispatchQueue.main.async {
                let libraryNodeVC = self.getLibraryNodeVC()
                libraryNodeVC?.update()
            }
        }

        // Get generator data on background queue
        DispatchQueue.global(qos: .userInteractive).async {
            self.loadGeneratorData()

            // Update SelectionRuneVC on main queue
            DispatchQueue.main.async {
                let selectionRuneVC = self.getSelectionRuneVC()
                selectionRuneVC?.update()
            }
        }
    }

    // Get LibraryNodeViewController
    private func getLibraryNodeVC() -> LibraryNodeViewController? {
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        let tabBarVC = sceneDelegate?.window?.rootViewController as? MainTabBarController
        let navigationVC = tabBarVC?.viewControllers?.first {
            guard let navVC = $0 as? UINavigationController else { return false }
            return navVC.viewControllers.first is LibraryNodeViewController
        } as? UINavigationController

        let libraryNodeVC: LibraryNodeViewController? = navigationVC?.viewControllers.first { $0 is LibraryNodeViewController} as? LibraryNodeViewController

        return libraryNodeVC
    }

    // Get SelectionRuneVC
    private func getSelectionRuneVC() -> SelectionRuneVC? {
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        let tabBarVC = sceneDelegate?.window?.rootViewController as? MainTabBarController
        let navigationVC = tabBarVC?.viewControllers?.first {
            guard let navVC = $0 as? UINavigationController else { return false }
            return navVC.viewControllers.first is GeneratorVC
        } as? UINavigationController

        let selectionRuneVC: SelectionRuneVC? = navigationVC?.viewControllers.first { $0 is SelectionRuneVC } as? SelectionRuneVC

        return selectionRuneVC
    }

    // MARK: - Load library
    private func loadLibraryData() {
        // Download data from server
        guard let libraryData = RunarApi.getLibratyData() else { fatalError("Library is empty") }

        // Enter data into the Library memory storage
        MemoryStorage.Library = LibraryNode.create(fromData: libraryData)
        libraryIsLoaded = true
    }

    // MARK: - Load generator
    private func loadGeneratorData() {
        // Download data from server
        print("\n Generator data downloading \n")
        guard let runesData = RunarApi.getRunesData() else { fatalError("Runes is empty") }
        print("\n Generator data is downloaded \n")

        // Enter data into the GenerationRunes memory storage
        MemoryStorage.GenerationRunes = GenerationRuneModel.create(fromData: runesData)
        print("Memory storage count: ", MemoryStorage.GenerationRunes.count)
        generatorIsLoaded = true

        clearData()
        print("\n Generator data clear from Core Data \n")

        print("\n Generator data saving in Core Data \n")
        saveInCoreDataWith(MemoryStorage.GenerationRunes)
        print("\n Generator data is saved in Core Data \n")
    }

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

    private func saveInCoreDataWith(_ nodes: [GenerationRuneModel]) {
//        _ = nodes.map{ self.createGeneratorRuneEntityFrom($0) }
        nodes.forEach { self.createGeneratorRuneEntityFrom($0) }

        do {
            try CoreDataManager.shared.persistentContainer.viewContext.save()
        } catch let error {
            print(error)
        }
    }

    private func clearData() {
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
