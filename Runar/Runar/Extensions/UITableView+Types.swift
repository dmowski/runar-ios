//
//  UITableView+Types.swift
//  Runar
//
//  Created by Andrei on 11.02.2023.
//

import UIKit

extension UITableView {
    static let cellTypes: [LibraryNodeType: AnyClass?] = [
        .root: LibraryRootCell.self,
        .rune: LibraryRuneCell.self,
        .poem: LibraryPoemCell.self,
        .text: LibraryTextCell.self,
        .menu: LibraryMenuCell.self
    ]
    
    func register(node: LibraryNode) -> Void {
        node.children.forEach { child in
            guard let type: AnyClass? = UITableView.cellTypes[child.type] else {
                fatalError("cell type '\(child.type.rawValue)' is not implemented")
            }
            register(type, forCellReuseIdentifier: child.id)
        }
    }
    
    func add(to view: UIView) -> Void {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        tableFooterView = UIView()
        
        view.addSubview(self)
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor),
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func getCell(node: LibraryNode, index indexPath: IndexPath) -> UITableViewCell {
        let child = node.children[indexPath.row]
        let cell = self.dequeueReusableCell(withIdentifier: child.id, for: indexPath)
        
        (cell as? LibraryCellProtocol)?.bind(node: child)
        
        return cell
    }
}
