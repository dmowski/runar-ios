//
//  Model_v2.swift
//  Runar
//
//  Created by Andrei on 11.02.2023.
//

import Foundation

// TODO: - Should be delete after testing
struct RuneModel: Codable {
    let _id: String
    let childIds: [String]
    let imageUrl: String
    let content: String
    let title: String
    let audioUrl: String?
    let audioDuration: String?
    let linkUrl: String
    let linkTitle: String
    let tags: [String]?
    let sortOrder: Int
    let type: String
    let __v: Int
}
