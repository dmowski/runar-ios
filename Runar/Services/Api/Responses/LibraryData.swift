//
//  LibraryNode.swift
//  Runar
//
//  Created by Maksim Harbatsevich on 5/10/21.
//

import Foundation

struct LibraryData: Codable {
    
    // MARK: - Props
    var childIds: [String]
    var id: String
    var imageUrl: String?
    var linkTitle: String?
    var linkUrl: String?
    var title: String?
    var tags: [String]?
    var content: String?
    var sortOrder: Int
    var type: String
}

// MARK: - Types
extension LibraryData {
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        
        case childIds
        case imageUrl
        case linkTitle
        case linkUrl
        case title
        case tags
        case content
        case sortOrder
        case type
    }
}
