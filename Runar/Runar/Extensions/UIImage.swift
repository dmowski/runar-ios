//
//  UIImage.swift
//  Runar
//
//  Created by George Stupakov on 16/06/2022.
//

import UIKit

public extension UIImage {
    static func create(fromUrl url: String) -> UIImage? {
        let imageData: Data = RunarApi.getData(byUrl: url)!
        
        return UIImage(data: imageData)
    }
    
    func withAlpha(_ a: CGFloat) -> UIImage {
        return UIGraphicsImageRenderer(size: size, format: imageRendererFormat).image { (_) in
            draw(in: CGRect(origin: .zero, size: size), blendMode: .normal, alpha: a)
        }
    }
}
