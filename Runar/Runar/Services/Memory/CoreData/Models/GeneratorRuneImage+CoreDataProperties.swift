//
//  GeneratorRuneImage+CoreDataProperties.swift
//  
//
//  Created by Alexey Poletaev on 26.09.2022.
//
//

import Foundation
import CoreData


extension GeneratorRuneImage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GeneratorRuneImage> {
        return NSFetchRequest<GeneratorRuneImage>(entityName: "GeneratorRuneImage")
    }

    @NSManaged public var height: Float
    @NSManaged public var image: Data?
    @NSManaged public var width: Float
    @NSManaged public var parent: GeneratorCoreData?

}
