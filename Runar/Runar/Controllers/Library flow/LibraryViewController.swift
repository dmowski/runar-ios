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
        if !DeviceType.iPhoneSE && !DeviceType.isIPhone678 && !DeviceType.isIphone78Plus {
            title = .library
            navigationController?.navigationBar.configure(prefersLargeTitles: true, titleFontSize: 34)
        } else {
            navigationController?.navigationBar.configure(prefersLargeTitles: false, titleFontSize: 20)
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UILabel.create(withText: .library, fontSize: 20))
        }
        
        navigationController?.setStatusBar(backgroundColor: .navBarBackgroundColor)
    }
}

// MARK: - Extensions
public extension UINavigationBar {
    func configure(prefersLargeTitles: Bool, titleFontSize: CGFloat) -> Void {
        self.backgroundColor = .navBarBackgroundColor
        
        let attributes = [NSAttributedString.Key.font: FontFamily.SFProDisplay.medium.font(size: titleFontSize),
                          NSAttributedString.Key.foregroundColor: UIColor.titleColor]
        
        if prefersLargeTitles {
            self.largeTitleTextAttributes = attributes
            self.prefersLargeTitles = true
            self.titleTextAttributes = nil
        } else {
            self.titleTextAttributes = attributes
            self.isTranslucent = false
            self.barTintColor = .navBarBackgroundColor
            self.tintColor = .titleColor
        }
    }
}


