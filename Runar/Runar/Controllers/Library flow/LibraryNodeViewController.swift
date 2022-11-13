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

enum LibraryNodeType: String, CaseIterable {
    case undefined = "undefined"
    case core = "core"
    case root = "root"
    case rune = "rune"
    case menu = "subMenu"
    case poem = "poem"
    case text = "plainText"
}

// MARK: - Protocols
public protocol LibraryCellProtocol {
    func bind(node: LibraryCoreData) -> Void
    func unavailableLibrary()
    func availableLibrary()
}

public class LibraryNodeViewController: UIViewController {
    // MARK: - Properties
    var node: LibraryNode = .init()
    private var nodeView: UITableView = UITableView()

    // MARK: - UI elements
    let activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        view.color = .white
        view.isHidden = true
        return view
    }()
    
    // MARK: - Override funcs
    public override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(self.updateUI(_:)), name: NSNotification.Name(rawValue: "updateLibraryTableViewAfterPurchase"), object: nil)

        RunarLayout.initBackground(for: view)

        let libraryIsLoaded: Bool = CoreDataManager.shared.libraryIsLoaded
        guard libraryIsLoaded else { return setupActivityIndicator() }
        configureNodeView()
    }


    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }

    // MARK: - Methods
    private func configureNodeView() -> Void {
        nodeView.dataSource = self
        nodeView.delegate = self
        nodeView.separatorColor = UIColor(red: 0.329, green: 0.329, blue: 0.329, alpha: 1)
        nodeView.separatorStyle = .singleLine
        nodeView.register(node: node)
        nodeView.add(to: view)
    }

    private func setupActivityIndicator() {
        self.view.addSubviews(activityIndicatorView)
        activityIndicatorView.startAnimating()
        activityIndicatorView.isHidden = false
        activityIndicatorView.center = self.view.center
    }

    private func create(withNode node: LibraryNode) -> LibraryNodeViewController {
        let controller = LibraryNodeViewController()
        controller.set(node)
        return controller
    }

    func set(_ node: LibraryNode) {
        self.node = node
    }

    func configureNavigationBar() {
        title = node.title
        self.navigationController?.navigationBar.configure()
    }

    // Refresh the screen after downloading data
    func update() {
        activityIndicatorView.isHidden = true
        activityIndicatorView.stopAnimating()
        let nodes = CoreDataManager.shared.fetchRootLibraryNodes()
        let node = LibraryNode(title: "",
                        nodes: nodes,
                        type: "core",
                        imageUrl: nil,
                        id: "0")
        set(node)
        configureNodeView()
    
    @objc private func updateUI(_ notification: NSNotification) {
        self.nodeView.reloadData()
    }
}

// MARK: - Extensions
// MARK: - TableViewDelegate and TableViewDataSource
extension LibraryNodeViewController: UITableViewDelegate, UITableViewDataSource {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return node.nodes.count
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let nodeType = LibraryNodeType(rawValue: node.nodes[indexPath.row].type)

        switch nodeType {
        case .root:
            if node.imageUrl == "" {
                return 66
            } else {
                return 112
            }
        case .menu:
            if !DeviceType.iPhoneSE && !DeviceType.isIPhone678 {
                if node.imageUrl == "" {
                    return 66
                } else {
                    if node.imageUrl == "https://s3.eu-west-2.amazonaws.com/lineform/rnnr_1632491694931_613_(starshaya).png" { return 66 }
                    if node.imageUrl == "https://s3.eu-west-2.amazonaws.com/lineform/rnnr_1632491699913_795_(mlad).png" { return 66 }
                    if node.imageUrl == "https://s3.eu-west-2.amazonaws.com/lineform/rnnr_1632491704338_218_(skazki).png" { return 66 }
                    return 112
                }
            } else {
                if node.imageUrl == "" {
                    return 66
                } else {
                    if node.imageUrl == "https://s3.eu-west-2.amazonaws.com/lineform/rnnr_1632491694931_613_(starshaya).png" { return 66 }
                    if node.imageUrl == "https://s3.eu-west-2.amazonaws.com/lineform/rnnr_1632491699913_795_(mlad).png" { return 66 }
                    if node.imageUrl == "https://s3.eu-west-2.amazonaws.com/lineform/rnnr_1632491704338_218_(skazki).png" { return 66 }
                    return 90
                }
            }
        default:
            return UITableView.automaticDimension
        }
    }
        
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.getCell(node: node, index: indexPath)
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) -> Void {
        let child = node.nodes[indexPath.row]
        let nodes = child.children?.allObjects as? [LibraryCoreData] ?? []
        let filteredNodes = nodes
            .filter { $0.type != LibraryNodeType.root.rawValue }
            .sorted { $0.order < $1.order }

        let node = LibraryNode(title: child.title ?? "",
                        nodes: filteredNodes,
                        type: child.type,
                        imageUrl: child.imageUrl,
                        id: child.id)

        guard let typeNode = LibraryNodeType(rawValue: child.type) else { return }
        switch typeNode {
        case .root, .menu:
            self.navigationController?.pushViewController(create(withNode: node), animated: false)
        default:
            print(child.title ?? "No Data")
        }
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
        for child in node.nodes {
            guard let nodeType = LibraryNodeType(rawValue: child.type) else { return }
            guard let type: AnyClass? = UITableView.cellTypes[nodeType] else {
                fatalError("cell type '\(child.type)' is not implemented")
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
        let nodes = node.nodes
        let child = nodes[indexPath.row]
        let cell = self.dequeueReusableCell(withIdentifier: child.id, for: indexPath)
        (cell as! LibraryCellProtocol).bind(node: child)

        if SubscriptionManager.freeSubscription == true {
            if indexPath.row >= 4 {
                (cell as? LibraryCellProtocol)?.unavailableLibrary()
            }
        } else {
            (cell as? LibraryCellProtocol)?.availableLibrary()
        }

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
