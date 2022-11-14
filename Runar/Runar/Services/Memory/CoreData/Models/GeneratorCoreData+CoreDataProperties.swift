//
//  GeneratorCoreData+CoreDataProperties.swift
//  
//
//  Created by Alexey Poletaev on 26.09.2022.
//
//

import Foundation
import CoreData


extension GeneratorCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GeneratorCoreData> {
        return NSFetchRequest<GeneratorCoreData>(entityName: "GeneratorCoreData")
    }

    @NSManaged public var descriptionRune: String
    @NSManaged public var id: String
    @NSManaged public var title: String
    @NSManaged public var runeImage: GeneratorRuneImage?

}
