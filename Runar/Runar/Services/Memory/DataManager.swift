//
//  DataManager.swift
//  Runar
//
//  Created by Alexey Poletaev on 14.11.2022.
//

import UIKit

final class DataManager {

    static let shared = DataManager()
    var libraryIsLoaded: Bool = false

    // Download data when launching the application
    func fetchData() {
        // Get library data on background queue
        DispatchQueue.global(qos: .userInteractive).async {
            self.createLibraryFromCoreData()
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

        // Clear Library Core Data
        CoreDataManager.shared.clearLibraryData()

        // Create and save Library Core Data
        CoreDataManager.shared.saveLibraryInCoreDataWith(MemoryStorage.Library)
    }

    // Method of forming a library model from Core Data if it contains data
    private func createLibraryFromCoreData() {
        guard let savedData = CoreDataManager.shared.fetchLibraryDataFromCoreData(),
              !savedData.isEmpty else { return }
        MemoryStorage.Library = CoreDataManager.shared.fetchLibraryFromCoreData()
        libraryIsLoaded = true
    }

    // MARK: - Load generator
    private func loadGeneratorData() {
        // Download data from server
        guard let runesData = RunarApi.getRunesData() else { fatalError("Runes is empty") }

        // Enter data into the GenerationRunes memory storage
        MemoryStorage.GenerationRunes = GenerationRuneModel.create(fromData: runesData)

        // Clear Generator Core Data
        CoreDataManager.shared.clearGeneratorData()

        // Create and save Generator Core Data
        CoreDataManager.shared.saveGeneratorInCoreDataWith(MemoryStorage.GenerationRunes)
    }
}
