//
//  CommonLayout.swift
//  Runar
//
//  Created by Maksim Harbatsevich on 5/15/21.
//

import UIKit

public class RunarLayout {
    public static let backgroundImage: UIImageView = createBackground(with: Assets.Background.main)
    public static let backgroundShadow: UIImageView = createBackground(with: Assets.Background.backgroundShadowSetting)
    
    private static func createBackground(with asset: ImageAsset) -> UIImageView {
        let background = UIImageView()
        background.translatesAutoresizingMaskIntoConstraints = false
        background.image = asset.image
        background.contentMode = .scaleAspectFill
        return background
    }
    
    public static func initBackground(for view: UIView) {
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
