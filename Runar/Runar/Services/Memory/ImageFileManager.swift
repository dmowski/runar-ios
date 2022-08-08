//
//  FileManager.swift
//  Runar
//
//  Created by Kyzu on 4.08.22.
//

import Foundation
import UIKit

enum WriteErrors: String {
    case imageError = "Error write image becouse image = nil"
    case imageDataError = "Error write image becouse imageData = nil"
}

class ImageFileManager {
    
    static let shared = ImageFileManager()
    private let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]

    // MARK: - FileManager methods
    func writeImageToFile(image: UIImage?, fileName: String) {
        guard let image = image else { return print(WriteErrors.imageError.rawValue) }
        guard let imageData = image.pngData() else { return print(WriteErrors.imageDataError.rawValue) }

        let fileURL = URL(fileURLWithPath: fileName, relativeTo: directoryURL)

        do {
            try imageData.write(to: fileURL)
        } catch {
            print("Saving file resulted with error: \(error.localizedDescription)")
        }
    }

    func readImageFromFile(_ fileName: String) -> UIImage {
        let fileURL = URL(fileURLWithPath: fileName, relativeTo: directoryURL)
        var image = Assets.emptyErrorImage.image

        do {
            let savedData = try Data(contentsOf: fileURL)
            if let savedImage = UIImage(data: savedData) {
                image = savedImage
            }
        } catch {
            print("Reading file resulted with error: \(error.localizedDescription)")
        }

        return image
    }

    func getImagesWithBackground() -> [UIImage?] {
        var returnArrayOfImages: [UIImage?] = []

        do {
            let imagesNames = try FileManager.default.contentsOfDirectory(atPath: directoryURL.path)

            for imageName in imagesNames {
                if !imageName.contains("empty"),
                   !imageName.contains("Store") {
                    returnArrayOfImages.append(self.readImageFromFile(imageName))
                }
            }
        } catch {
            print(error.localizedDescription)
        }

        return returnArrayOfImages
    }

    func removeImagesFromMemory() {
        do {
            let imageNames = try FileManager.default.contentsOfDirectory(atPath: directoryURL.path)
            for imageName in imageNames {
                let imagePath = directoryURL.path + "/" + imageName
                try FileManager.default.removeItem(atPath: imagePath)
            }
        } catch {
            print("Could not clear temp folder: \(error.localizedDescription)")
        }
    }
}
