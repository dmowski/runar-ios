//
//  WallpappersStylesData.swift
//  Runar
//
//  Created by Maksim Harbatsevich on 10/25/21.
//

import Foundation

// MARK: - Types
public struct WallpapperStyleData: Codable {
    var name: String
    var imageUrl: String
}

// MARK: - Types
extension WallpapperStyleData {
    enum CodingKeys: String, CodingKey {
        case name
        case imageUrl = "imgUrl"
    }
    
    static func create(from data: Data) -> [WallpapperStyleData] {
        guard let wallpappersStylesData = try? JSONDecoder().decode([WallpapperStyleData].self, from: data) else {
            fatalError("WallpappersStylesData is not decoded")
        }
        
        return wallpappersStylesData
    }
}
