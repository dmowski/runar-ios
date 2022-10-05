//
//  LibraryNode.swift
//  Runar
//
//  Created by Alexey Poletaev on 25.09.2022.
//

import Foundation

public class LibraryNode {
    var title: String
    var nodes: [LibraryCoreData]
    var type: LibraryNodeType
    var imageUrl: String?
    var id: String
    weak var parent: LibraryNode?

    init() {
        self.title = ""
        self.nodes = []
        self.type = .core
        self.imageUrl = nil
        self.id = "0"
    }

    init(title: String,
         nodes: [LibraryCoreData],
         type: String,
         imageUrl: String?,
         id: String) {

        self.title = title
        self.nodes = nodes
        self.type = LibraryNodeType(rawValue: type) ?? .core
        self.imageUrl = imageUrl
        self.id = id
    }
}

extension LibraryNode {
    func getParentTitles() -> [String] {
        var titles: [String] = []
        self.parent?.fillTitles(&titles)
        return titles
    }

    func fillTitles(_ titles: inout [String]) -> Void{
        guard self.type != .core else { return }
        self.parent?.fillTitles(&titles)
        titles.append(self.title)
    }
}
