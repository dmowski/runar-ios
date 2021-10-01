//
//  CommonLayout.swift
//  Runar
//
//  Created by Maksim Harbatsevich on 5/15/21.
//

import UIKit

// MARK: - Types
public enum BackgroundType {
    case main
    case mainFile
    
    var image: ImageAsset {
        switch self {
        case .main:
            return Assets.Background.main
        case .mainFile:
            return Assets.mainFire
        }
    }
}

public class RunarLayout {
    
    // MARK: - Static funcs
    private static func createBackground(with asset: ImageAsset) -> UIImageView {
        let background = UIImageView()
        background.translatesAutoresizingMaskIntoConstraints = false
        background.image = asset.image
        background.contentMode = .scaleAspectFill
        return background
    }
    
    public static func initBackground(for view: UIView, with background: BackgroundType = .main) {
        let backgroundImage: UIImageView = createBackground(with: background.image)
        let backgroundShadow: UIImageView = createBackground(with: Assets.Background.backgroundShadowSetting)
        
        view.addSubviews(backgroundImage, backgroundShadow)
        
        addConstraints(for: backgroundImage, to: view)
        addConstraints(for: backgroundShadow, to: view)
    }
    
    private static func addConstraints(for imageView: UIImageView, to view: UIView){
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
