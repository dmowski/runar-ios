//
//  CacheManager.swift
//  Runar
//
//  Created by Maksim Harbatsevich on 5/5/21.
//

import Foundation

// This class represents as a wrapper for persistent data storage.
public class LocalStorage {
    static let store: UserDefaults = .standard
       
    static func push(_ value: Any, forKey key: LocalStorageKey, withLocalization localizable: Bool = false) {
        push(value, forKey: localizable ? key.localizeRawValue() : key.rawValue)
    }
    
    static func push(_ value: Any, forKey key: String) {
        store.set(value, forKey: key)
    }
        
    static func pull<T: Any>(forKey key: LocalStorageKey, withLocalization localizable: Bool = false) -> T? {
        return pull(forKey: localizable ? key.localizeRawValue() : key.rawValue)
    }
    
    static func pull<T: Any>(forKey key: String) -> T? {
        return store.value(forKey: key) as? T
    }
    
    static func remove(forKey key: LocalStorageKey, withLocalization localizable: Bool = false) {
        remove(forKey: localizable ? key.localizeRawValue() : key.rawValue)
    }
    
    static func remove(forKey key: String) {
        store.removeObject(forKey: key)
    }
    
    static func contains(key: LocalStorageKey, withLocalization localizable: Bool = false) -> Bool {
        return contains(key: localizable ? key.localizeRawValue() : key.rawValue)
    }
    
    static func contains(key: String) -> Bool {
        return store.object(forKey: key) != nil
    }
}

public enum LocalStorageKey: String, CaseIterable {
    case firstLaunch = "hasBeenLaunchedBeforeFlag"
    case libraryHash = "LocalStorageKey.libraryHash"
    case libraryData = "LocalStorageKey.libraryData"
    
    func localizeRawValue() -> String {
        return "\(self.rawValue)-\(String.lang)"
    }
}
