//
//  LibraryNodeViewController.swift
//  Runar
//
//  Created by Maksim Harbatsevich on 5/24/21.
//

import UIKit

extension String {
    static let back = L10n.Navbar.Title.back
}

public class LibraryNodeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var node: LibraryNode = LibraryNode()
    private var nodeView: UITableView = UITableView()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        RunarLayout.initBackground(for: view)
        
        configureNodeView()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        configureNavigationBar()
    }
    
    func set(_ node: LibraryNode){
        self.node = node
    }
    
    private func configureNodeView() -> Void {
        nodeView.dataSource = self
        nodeView.delegate = self
        
        nodeView.register(node: node)
        nodeView.add(to: view)
    }
    
    func configureNavigationBar() {
        title = node.title
        self.navigationController?.navigationBar.configure()
    }
          
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) -> Void {
        let child = node.children[indexPath.row]
        
        switch child.type {
        case .root, .menu, .rune:
            self.navigationController?.pushViewController(LibraryNodeViewController.create(withNode: child), animated: false)
            break
        default:
            print(child.title ?? "No Data")
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return node.children.count
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch node.children[indexPath.row].type {
        case .root, .rune:
            return 108
        case .menu:
            return 66
        default:
            return UITableView.automaticDimension
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.getCell(node: node, index: indexPath)
    }
}

public extension LibraryNodeViewController {
    static func create(withNode node: LibraryNode) -> LibraryNodeViewController {
        let controller = LibraryNodeViewController()
        controller.set(node)
        return controller
    }
}

private extension UITableView {
    func register(node: LibraryNode) -> Void {
        for child in node.children {
            self.register(LibraryNodeCell.self, forCellReuseIdentifier: child.id)
        }
    }
    
    func add(to view: UIView) -> Void {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        self.separatorInset = UIEdgeInsets(top: 0, left: 17, bottom: 0, right: 0)
        self.tableFooterView = UIView()
        
        view.addSubview(self)
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func getCell(node: LibraryNode, index indexPath: IndexPath) -> LibraryNodeCell {
        let child = node.children[indexPath.row]
        let cell = self.dequeueReusableCell(withIdentifier: child.id, for: indexPath) as! LibraryNodeCell
        
        cell.bind(node: child)
        
        return cell
    }
}

private extension UINavigationBar {
    func configure() -> Void {
        self.isTranslucent = false
        self.prefersLargeTitles = false
        self.tintColor = .libraryTitleColor
        self.backgroundColor = .navBarBackground
        self.barTintColor = .navBarBackground
        self.titleTextAttributes = [NSAttributedString.Key.font: FontFamily.SFProDisplay.regular.font(size: 17),
                                         NSAttributedString.Key.foregroundColor: UIColor.white]
        
        self.backItem?.backButtonTitle = .back
    }
}
