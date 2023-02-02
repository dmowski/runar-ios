//
//  LibraryRootViewModel.swift
//  Runar
//
//  Created by Maksim Harbatsevich on 5/16/21.
//

import UIKit

public class LibraryViewController: LibraryNodeViewController {
    
    // MARK: - Override funcs
    public override func viewDidLoad() {
        set(MemoryStorage.Library)
                
        super.viewDidLoad()
    }
    
    override func configureNavigationBar() {
            title = .library
            navigationController?.navigationBar.configureTitle()

        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: L10n.Navbar.Title.back, style: .plain, target: nil, action: nil)
        
        navigationController?.setStatusBar(backgroundColor: .navBarBackground)
    }
}

// MARK: - Extensions
public extension UINavigationBar {
    func configureTitle() -> Void {
        self.backgroundColor = .navBarBackground
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.79
        let font: CGFloat = DeviceType.iPhoneSE ? 30 : 36
            self.titleTextAttributes = [NSAttributedString.Key.font: FontFamily.AmaticSC.bold.font(size: font),
                                        NSAttributedString.Key.foregroundColor: UIColor.libraryTitleColor,
                                        NSAttributedString.Key.paragraphStyle: paragraphStyle]
            self.isTranslucent = false
            self.barTintColor = .navBarBackground
            self.tintColor = .libraryTitleColor
    }
}

public extension UIColor {
    static let libraryTitleColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1)
}
