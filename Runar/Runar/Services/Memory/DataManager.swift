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
    var generatorIsLoaded: Bool = false

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
            return navVC.viewControllers.first is SelectionRuneVC
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
        guard let runesData = RunarApi.getRunesData() else { fatalError("Runes is empty") }

        // Enter data into the GenerationRunes memory storage
        MemoryStorage.GenerationRunes = GenerationRuneModel.create(fromData: runesData)
        generatorIsLoaded = true
    }
}
