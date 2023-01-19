//
//  GenerationRuneModel.swift
//  Runar
//
//  Created by Maksim Harbatsevich on 9/30/21.
//

import UIKit

struct GenerationRuneInfo {
    var uiImage: UIImage
    var height: CGFloat?
    var width: CGFloat?
}

public class GenerationRuneModel {
    let id: String
    let title: String
    let description: String
    let imageInfo: GenerationRuneInfo
    
    init(title: String, description: String, image: GenerationRuneInfo){
        self.title = title
        self.description = description
        self.imageInfo = image
        self.id = ""
    }
    
    init(id: String, title: String, description: String, image: GenerationRuneInfo){
        self.id = id
        self.title = title
        self.description = description
        self.imageInfo = image
    }
}

public extension GenerationRuneModel {
    
    static func create(title: String, description: String, image: UIImage) -> GenerationRuneModel {
        let image: GenerationRuneInfo = GenerationRuneInfo(uiImage: image, height: 70, width: 56)
        
        return GenerationRuneModel(title: title, description: description, image: image)
    }
    
    static func create(id: String, runeInfo: RuneInfo, image: UIImage) -> GenerationRuneModel {
        let image: GenerationRuneInfo = GenerationRuneInfo(uiImage: image)
        
        return GenerationRuneModel(id: id, title: runeInfo.title, description: runeInfo.description, image: image)
    }
    
    static func create(fromData data: Data) -> [GenerationRuneModel] {
        guard let runesData = try! JSONDecoder().decode([RuneData]?.self, from: data) else { fatalError("No Data") }
        var runes: [GenerationRuneModel] = []
        for rune in runesData {
            runes.append(create(id: String(rune.id), runeInfo: rune.getInfo(), image: UIImage.create(fromUrl: rune.imageUrl)!))
        }
        
        return runes
    }
}
