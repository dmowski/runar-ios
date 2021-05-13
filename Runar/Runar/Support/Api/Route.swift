//
//  Routs.swift
//  Runar
//
//  Created by Maksim Harbatsevich on 5/7/21.
//

import Foundation

extension String {
    static let lang = L10n.Language.name
}

enum Route {
    static let createUser = "\(Environment.apiUrl)/create-user"
    static let getLibraryHash = "\(Environment.apiUrl)/library-hash/\(String.lang)"
    static let getLibrary = "\(Environment.apiUrl)/library/\(String.lang)"
}
