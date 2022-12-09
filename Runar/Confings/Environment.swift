//
//  Environment.swift
//  Runar
//
//  Created by Maksim Harbatsevich on 5/11/21.
//

import Foundation

public enum Environment{
    // MARK: - Keys
    enum Keys {
        enum Plist {
            static let apiUrl = "API_URL"
            static let generatorApiUrl = "GENERATOR_API_URL"
        }
    }
    
    // MARK: - Plist
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file is not found")
        }
        return dict
    }()
    
    // MARK: - Plist values
    static let apiUrl: String = {
        guard let url = Environment.infoDictionary[Keys.Plist.apiUrl] as? String else {
            fatalError("Api Url is not set in plist fot this environment")
        }
        return url
    }()
    
    static let generatorApiUrl: String = {
        guard let url = Environment.infoDictionary[Keys.Plist.generatorApiUrl] as? String else {
            fatalError("Generator Api Url is not set in plist fot this environment")
        }
        return url
    }()
}
