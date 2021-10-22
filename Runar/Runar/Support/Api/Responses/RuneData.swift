//
//  RunesData.swift
//  Runar
//
//  Created by Maksim Harbatsevich on 10/20/21.
//

import Foundation

public struct RuneData: Codable {
    
    // MARK: - Props
    var id: Int
    var en: RuneInfo
    var ru: RuneInfo
    var imageUrl: String
}

public struct RuneInfo: Codable {
    var title: String
    var description: String
}

// MARK: - Types
extension RuneData {
    enum CodingKeys: String, CodingKey {
        case id
        case en
        case ru
        case imageUrl = "imgUrl"
    }
    
    func getInfo() -> RuneInfo {
        switch String.lang {
        case "en":
            return en
        case "ru":
            return ru
        default:
            fatalError("Rune Info has incorrect laguage")
        }
    }
}

extension RuneInfo {
    enum CodingKeys: String, CodingKey {
        case title
        case description
    }
}
