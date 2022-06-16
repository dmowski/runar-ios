//
//  LibraryNodeViewController.swift
//  Runar
//
//  Created by Maksim Harbatsevich on 5/24/21.
//

import UIKit

// MARK: Localizations
extension String {
    static let back = L10n.Navbar.Title.back
}

// MARK: - Protocols
public protocol LibraryCellProtocol {
    func bind(node: LibraryNode) -> Void
}

public class LibraryNodeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Mutable props
    var node: LibraryNode = LibraryNode()
    private var nodeView: UITableView = UITableView()
    
    // MARK: - Override funcs
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
        nodeView.separatorColor = UIColor(red: 0.329, green: 0.329, blue: 0.329, alpha: 1)
        nodeView.separatorStyle = .singleLine
        
        nodeView.register(node: node)
        nodeView.add(to: view)
    }
    
    func configureNavigationBar() {
        title = node.title
        self.navigationController?.navigationBar.configure()
    }
              
    // MARK: - Delegate funcs
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) -> Void {
        guard indexPath.row > 0 else {
            return
        }
        
        let child = node.children[indexPath.row - 1]
        
        switch child.type {
        case .root, .menu:
            self.navigationController?.pushViewController(LibraryNodeViewController.create(withNode: child), animated: false)
            break
        default:
            print(child.title ?? "No Data")
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return node.children.count + 1
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 0) {
            return node.type == .core ? CGFloat.leastNormalMagnitude : 42
        }
        
        switch node.children[indexPath.row - 1].type {
        case .root:
            return 112
        case .menu:
            if !DeviceType.iPhoneSE && !DeviceType.isIPhone678 {
                return 112
            } else {
                return 90
            }
        default:
            return UITableView.automaticDimension
        }
    }
        
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.getCell(node: node, index: indexPath)
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

// MARK: - Extensions
public extension LibraryNodeViewController {
    static func create(withNode node: LibraryNode) -> LibraryNodeViewController {
        let controller = LibraryNodeViewController()
        controller.set(node)
        return controller
    }
}

private extension UITableView {
    static let cellTypes: [LibraryNodeType: AnyClass?] = [
        .root: LibraryRootCell.self,
        .rune: LibraryRuneCell.self,
        .poem: LibraryPoemCell.self,
        .text: LibraryTextCell.self,
        .menu: LibraryMenuCell.self
    ]
    
    func register(node: LibraryNode) -> Void {
        self.register(LibraryPathCell.self, forCellReuseIdentifier: node.id)
        
        for child in node.children {
            guard let type: AnyClass? = UITableView.cellTypes[child.type] else {
                fatalError("cell type '\(child.type.rawValue)' is not implemented")
            }
            
            self.register(type, forCellReuseIdentifier: child.id)
        }
    }
    
    func add(to view: UIView) -> Void {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        self.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        self.tableFooterView = UIView()
        
        view.addSubview(self)

        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func getCell(node: LibraryNode, index indexPath: IndexPath) -> UITableViewCell {
        let child = indexPath.row == 0 ? node : node.children[indexPath.row - 1]
        let cell = self.dequeueReusableCell(withIdentifier: child.id, for: indexPath)
        
        (cell as! LibraryCellProtocol).bind(node: child)
        
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
        self.titleTextAttributes = [NSAttributedString.Key.font: FontFamily.SFProDisplay.medium.font(size: 17),
                                         NSAttributedString.Key.foregroundColor: UIColor.white]
        
        self.backItem?.backButtonTitle = .back
    }
}
