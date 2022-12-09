//
//  LibraryTree.swift
//  Runar
//
//  Created by Maksim Harbatsevich on 5/10/21.
//

import Foundation

public class LibraryNode {

    // MARK: - Init props
    let id: String
    let imageUrl: String?
    let linkTitle: String?
    let linkUrl: String?
    let title: String?
    let tags: [String]?
    let content: String?
    let order: Int?
    let type: LibraryNodeType

    // MARK: - Mutable props
    weak var parent: LibraryNode?
    var children: [LibraryNode] = []

    // MARK: - Inits
    init(item: LibraryData) {
        self.id = item.id
        self.imageUrl = item.imageUrl
        self.linkTitle = item.linkTitle
        self.linkUrl = item.linkUrl
        self.title = item.title
        self.tags = item.tags
        self.content = item.content
        self.order = item.sortOrder
        self.type = LibraryNodeType(rawValue: item.type) ?? LibraryNodeType.undefined
    }

    init() {
        self.id = "0"
        self.imageUrl = nil
        self.linkTitle = nil
        self.linkUrl = nil
        self.title = nil
        self.tags = nil
        self.content = nil
        self.order = nil
        self.type = LibraryNodeType.core
    }

    // MARK: - Funcs
    func add(child: LibraryNode){
        self.children.append(child)
        child.parent = self
    }
}

// MARK: - Extensions
extension LibraryNode {
    static func create(fromData data: Data) -> LibraryNode {
        guard let libraryData = try? JSONDecoder().decode([LibraryData].self, from: data) else {
            fatalError("No Data")
        }

        let libraryTree = LibraryNode()

        for item in libraryData.sorted(by: {$0.sortOrder < $1.sortOrder}).filter({ (item) -> Bool in
            return item.type == LibraryNodeType.root.rawValue
        }) {
            libraryTree.add(child: createNode(libraryItem: item, libraryData: libraryData))
        }

        return libraryTree
    }

    static func createNode(libraryItem: LibraryData, libraryData: [LibraryData]) -> LibraryNode {
        let node = LibraryNode(item: libraryItem)

        if (libraryItem.childIds.isEmpty){
            return node
        }

        for item in libraryData.sorted(by: {$0.sortOrder < $1.sortOrder}).filter({ (item) -> Bool in
            return libraryItem.childIds.contains(item.id)
        }) {
            node.add(child: createNode(libraryItem: item, libraryData: libraryData))
        }

        return node
    }
}
