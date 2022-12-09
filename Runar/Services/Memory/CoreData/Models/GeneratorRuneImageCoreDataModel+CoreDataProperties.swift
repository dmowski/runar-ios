//
//  GeneratorRuneImageCoreDataModel+CoreDataProperties.swift
//  
//
//  Created by Alexey Poletaev on 27.11.2022.
//
//

import Foundation
import CoreData


extension GeneratorRuneImageCoreDataModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GeneratorRuneImageCoreDataModel> {
        return NSFetchRequest<GeneratorRuneImageCoreDataModel>(entityName: "GeneratorRuneImageCoreDataModel")
    }

    @NSManaged public var width: Float
    @NSManaged public var height: Float
    @NSManaged public var image: Data?
    @NSManaged public var parent: GeneratorRuneCoreDataModel?

}
