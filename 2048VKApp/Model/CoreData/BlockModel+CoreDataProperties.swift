//
//  BlockModel+CoreDataProperties.swift
//  2048VKApp
//
//  Created by Alisher Saideshov on 08.04.2024.
//
//

import Foundation
import CoreData


extension BlockModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BlockModel> {
        return NSFetchRequest<BlockModel>(entityName: "BlockModel")
    }

    @NSManaged public var blockValue: Int32
    @NSManaged public var positionX: Int16
    @NSManaged public var positionY: Int16

}

extension BlockModel : Identifiable {

}
