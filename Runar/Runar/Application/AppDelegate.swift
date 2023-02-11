//
//  AppDelegate.swift
//  Runar
//
//  Created by Юлия Лопатина on 16.12.20.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var persistentContainer: NSPersistentContainer?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        createPersistenceContainer { [weak self] container in
            self?.persistentContainer = container
        }
        
        if isFirstLaunch() {
            signIn()
        }
        
        DataManager.shared.fetchData()

        MusicViewController.shared.initBackgroundMusic()
        
        if !UserDefaults.standard.bool(forKey: "is_off_music") {
            MusicViewController.shared.playBackgroundMusic()
        } else {
            MusicViewController.shared.stopBackgroundMusic()
        }
        return true
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
}

// MARK: - CoreData Stack
extension AppDelegate {
    func saveContext () {
        guard
            let context = persistentContainer?.viewContext,
            context.hasChanges
        else { return }
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }

    private func createPersistenceContainer(completionHandler: @escaping (NSPersistentContainer) -> Void) {
        let container = NSPersistentContainer(name: "Runar")
        container.loadPersistentStores { _, error in
            guard error == nil else { fatalError("Failed to load store: \(String(describing: error))") }
            DispatchQueue.main.async {
                completionHandler(container)
            }
        }
    }
}
