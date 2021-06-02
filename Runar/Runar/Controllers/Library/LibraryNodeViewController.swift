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

public protocol LibraryCellProtocol {
    func bind(node: LibraryNode) -> Void
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
        case .root:
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
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return node.type == .core ? CGFloat.leastNormalMagnitude : 52
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let section = UIView()
        
        section.backgroundColor = .clear
        
        guard node.type != .core else {
            return section
        }
        
        let label = UILabel.create(for: node)
                       
        section.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.widthAnchor.constraint(equalTo: section.widthAnchor),
            label.leftAnchor.constraint(equalTo: section.leftAnchor, constant: 16),
            label.rightAnchor.constraint(equalTo: section.rightAnchor, constant: -16),
            label.centerYAnchor.constraint(equalTo: section.centerYAnchor)
        ])
        
        return section
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
            switch child.type {
            case .rune:
                self.register(LibraryRuneCell.self, forCellReuseIdentifier: child.id)
                break
            default:
                self.register(LibraryNodeCell.self, forCellReuseIdentifier: child.id)
            }
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
    
    func getCell(node: LibraryNode, index indexPath: IndexPath) -> UITableViewCell {
        let child = node.children[indexPath.row]
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
        self.titleTextAttributes = [NSAttributedString.Key.font: FontFamily.SFProDisplay.regular.font(size: 17),
                                         NSAttributedString.Key.foregroundColor: UIColor.white]
        
        self.backItem?.backButtonTitle = .back
    }
}

private extension UILabel {
    static func create(for node: LibraryNode) -> UILabel {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 118, height: 20))
        
        label.textColor = UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 0.65)
        label.font = UIFont(name: "SFProText-Regular", size: 15)
        label.lineBreakMode = .byTruncatingTail
                
        let titles: [String] = node.getParentTitles()
        
        if (titles.count == 0){
            label.text = "> \(node.title!)"
        } else {
            let header: String = titles.joined(separator: " > ")
            
            let formatedHeader = NSMutableAttributedString(string: "> \(header) > \(titles.count == 1 ? node.title! : "...")")
            formatedHeader.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 0.659, green: 0.651, blue: 0.639, alpha: 0.38),
                                        range: NSRange(location: 0, length: header.count + 2))
            label.attributedText = formatedHeader
        }
        
        return label
    }
}

private extension LibraryNode {
    func getParentTitles() -> [String] {
        var titles: [String] = []
        
        self.parent!.fillTitles(&titles)
        
        return titles
    }
    
    func fillTitles(_ titles: inout [String]) -> Void{
        guard self.type != .core else {
            return
        }
        
        self.parent!.fillTitles(&titles)
        
        titles.append(self.title!)
    }
}
