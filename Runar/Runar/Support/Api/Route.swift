//
//  Routs.swift
//  Runar
//
//  Created by Maksim Harbatsevich on 5/7/21.
//

import Foundation

// MARK: - Localizations
extension String {
    static let lang = L10n.Language.name
}

// MARK: - Routes
enum Route {
    static let createUser = "\(Environment.apiUrl)/create-user"
    static let getLibraryHash = "\(Environment.apiUrl)/library-hash/\(String.lang)"
    static let getLibrary = "\(Environment.apiUrl)/library/\(String.lang)"
    static let getRunes = "\(Environment.generatorApiUrl)/runes"
    static let getWallpapersStyles = "\(Environment.generatorApiUrl)/wallpapersStyles"
    static let getWallpapers = "\(Environment.generatorApiUrl)/wallpapers"
    static let getEmptyWallpapers = "\(Environment.generatorApiUrl)/empty-wallpapers"
}
