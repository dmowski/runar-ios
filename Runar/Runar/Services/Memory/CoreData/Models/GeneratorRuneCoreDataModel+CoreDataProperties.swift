//
//  GeneratorRuneCoreDataModel+CoreDataProperties.swift
//  
//
//  Created by Alexey Poletaev on 27.11.2022.
//
//

import Foundation
import CoreData


extension GeneratorRuneCoreDataModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GeneratorRuneCoreDataModel> {
        return NSFetchRequest<GeneratorRuneCoreDataModel>(entityName: "GeneratorRuneCoreDataModel")
    }

    @NSManaged public var title: String?
    @NSManaged public var id: String?
    @NSManaged public var runeDescription: String?
    @NSManaged public var runeImage: GeneratorRuneImageCoreDataModel?

}
