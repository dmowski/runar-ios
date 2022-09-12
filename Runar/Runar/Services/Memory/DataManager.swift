//
//  DataManager.swift
//  Runar
//
//  Created by Alexey Poletaev on 12.09.2022.
//

import UIKit

final class DataManager {

    // Checking the downloaded data when launching the application
    func checkLoadedData() {
        DispatchQueue.main.async {
            let libraryNodeVC = self.getLibraryNodeVC()
            self.loadLibraryData()
            if let libraryVC = libraryNodeVC, !libraryVC.activityIndicatorView.isHidden {
                libraryVC.update()
            }
        }
        loadGeneratorData()
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
        let storedLibraryHash: String? = LocalStorage.pull(forKey: .libraryHash, withLocalization: true)
        guard let actualLibraryHash = RunarApi.getLibratyHash() else {
            fatalError("Library hash is empty")
        }

        if storedLibraryHash == nil || actualLibraryHash != storedLibraryHash {
            guard let libraryData = RunarApi.getLibratyData() else {
                fatalError("Library is empty")
            }

            LocalStorage.push(libraryData, forKey: .libraryData, withLocalization: true)
            LocalStorage.push(actualLibraryHash, forKey: .libraryHash, withLocalization: true)
            MemoryStorage.Library = LibraryNode.create(fromData: libraryData)
            return
        }

        guard let data: Data = LocalStorage.pull(forKey: .libraryData, withLocalization: true) else {
            fatalError("No data to display")
        }

        MemoryStorage.Library = LibraryNode.create(fromData: data)
    }

    // MARK: - Load generator
    private func loadGeneratorData() {
        // Get data on background queue
        DispatchQueue.global().async {

            self.loadRunes()

            // Update SelectionRuneVC on main queue
            DispatchQueue.main.async {
                let selectionRuneVC = self.getSelectionRuneVC()
                selectionRuneVC?.update()
            }

            self.loadWallpapers()
        }
    }

    private func loadRunes(){
        var runesData: Data? = LocalStorage.pull(forKey: .runesData)

        if (runesData == nil){
            guard let _runesData = RunarApi.getRunesData() else {
                fatalError("Runes is empty")
            }

            LocalStorage.push(_runesData, forKey: .runesData)

            runesData = _runesData
        }

        MemoryStorage.GenerationRunes = GenerationRuneModel.create(fromData: runesData!)
    }

    private func loadWallpapers(){
        var wallpapersStylesData: Data? = LocalStorage.pull(forKey: .wallpapersStylesData)
        if (wallpapersStylesData == nil){
            guard let _wallpapersStylesData = RunarApi.getWallpapersStylesData()else {
                fatalError("Runes is empty")
            }

            LocalStorage.push(_wallpapersStylesData, forKey: .wallpapersStylesData)

            wallpapersStylesData = _wallpapersStylesData
        }

        MemoryStorage.GenerationWallpapertsStyles = WallpapperStyleData.create(from: wallpapersStylesData!)
    }
}
