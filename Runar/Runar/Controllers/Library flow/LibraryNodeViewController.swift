//
//  LibraryNodeViewController.swift
//  Runar
//
//  Created by Maksim Harbatsevich on 5/24/21.
//

import UIKit

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
protocol LibraryCellProtocol {
    func bind(node: LibraryNode) -> Void
}

class LibraryNodeViewController: UIViewController {
    // MARK: - Properties
    private var nodeView: UITableView = UITableView()
    var node: LibraryNode = LibraryNode()
    let activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        view.color = .white
        view.isHidden = true
        return view
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateUI(_:)), name: NSNotification.Name(rawValue: "updateLibraryTableViewAfterPurchase"), object: nil)
        
        RunarLayout.initBackground(for: view)
        
        guard DataManager.shared.libraryIsLoaded else { return setupActivityIndicator() }
        configureNodeView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureNavigationBar()
    }
    
    // MARK: - Methods
    static func create(withNode node: LibraryNode) -> LibraryNodeViewController {
        let controller = LibraryNodeViewController()
        controller.navigationItem.backBarButtonItem = UIBarButtonItem(
            title: L10n.Navbar.Title.back, style: .plain, target: nil, action: nil)
        controller.set(node)
        return controller
    }
    
    func set(_ node: LibraryNode) {
        self.node = node
    }
    
    func configureNavigationBar() {
        title = node.title
        navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.configureTitle()
    }
    
    // Refresh the screen after downloading data
    func update() {
        activityIndicatorView.isHidden = true
        activityIndicatorView.stopAnimating()
        set(MemoryStorage.Library)
        configureNodeView()
    }
    
    private func configureNodeView() -> Void {
        nodeView.dataSource = self
        nodeView.delegate = self
        nodeView.separatorColor = UIColor(red: 0.329, green: 0.329, blue: 0.329, alpha: 1)
        nodeView.separatorStyle = .singleLine
        nodeView.indicatorStyle = .white
        nodeView.register(node: node)
        nodeView.add(to: view)
    }
    
    private func setupActivityIndicator() {
        self.view.addSubviews(activityIndicatorView)
        activityIndicatorView.startAnimating()
        activityIndicatorView.isHidden = false
        activityIndicatorView.center = self.view.center
    }
    
    @objc private func updateUI(_ notification: NSNotification) {
        self.nodeView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension LibraryNodeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return node.children.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.getCell(node: node, index: indexPath)
    }
}

// MARK: - UITableViewDelegate
extension LibraryNodeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) -> Void {
        let child = node.children[indexPath.row]
        
        switch child.type {
        case .root, .menu:
            self.navigationController?.pushViewController(LibraryNodeViewController.create(withNode: child), animated: true)
            break
        default:
            print(child.title ?? "No Data")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let child = node.children[indexPath.row]
        
        switch child.type {
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
}
