//
//  AppDelegate.swift
//  Runar
//
//  Created by Юлия Лопатина on 16.12.20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // TODO: No Internet
        //NetworkMonitor.shared.startMonitoring()
        
        if isFirstLaunch() {
            signIn()
        }
        
        //NetworkMonitor
        //        if NetworkMonitor.shared.isConnected {

        DispatchQueue.main.async {
            let libraryNodeVC = self.getLibraryNodeVC()
            self.loadLibraryData()
            if let libraryVC = libraryNodeVC, !libraryVC.activityIndicatorView.isHidden {
                libraryVC.update()
            }
        }
        loadGeneratorData()

        //        } else {
        //            print("No internet")
        //        }

        MusicViewController.shared.initBackgroundMusic()
        if !UserDefaults.standard.bool(forKey: "is_off_music") {
            MusicViewController.shared.playBackgroundMusic()
        } else {
            MusicViewController.shared.stopBackgroundMusic()
        }

        return true
    }
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

extension AppDelegate {
    
    // check for is first launch - only true on first invocation after app install, false on all further invocations
    // Note: Store this value in AppDelegate if you have multiple places where you are checking for this flag
    func isFirstLaunch() -> Bool {
        let isFirstLaunch = !LocalStorage.contains(key: .firstLaunch)
                
        if (isFirstLaunch) {
            LocalStorage.push(true, forKey: .firstLaunch)
        }
        
        return isFirstLaunch
    }
       
    func signIn() {
        let id = String.random(withLength: 32)
        let created = NSDate().timeIntervalSince1970
        let systemVersion = "IOS " + UIDevice.current.systemVersion
        RunarApi.createUser(with: id, date: created, os: systemVersion)
        print(id, created, systemVersion)
    }
   
    // MARK: - Load library
    func loadLibraryData() -> Void {
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
    
    func loadGeneratorData() -> Void {
        // Get data on background queue
        DispatchQueue.global(qos: .background).async {
            
            self.loadRues()

            // Update SelectionRuneVC on main queue
            DispatchQueue.main.async {
                let selectionRuneVC = self.getSelectionRuneVC()
                selectionRuneVC?.update()
            }

            self.loadWallpapers()
        }
    }
    
    func loadRues(){
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
    
    func loadWallpapers(){
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

    // Get LibraryNodeViewController
    func getLibraryNodeVC() -> LibraryNodeViewController? {
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
    func getSelectionRuneVC() -> SelectionRuneVC? {
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        let tabBarVC = sceneDelegate?.window?.rootViewController as? MainTabBarController
        let navigationVC = tabBarVC?.viewControllers?.first {
            guard let navVC = $0 as? UINavigationController else { return false }
            return navVC.viewControllers.first is GeneratorVC
        } as? UINavigationController

        let selectionRuneVC: SelectionRuneVC? = navigationVC?.viewControllers.first { $0 is SelectionRuneVC } as? SelectionRuneVC

        return selectionRuneVC
    }
}
