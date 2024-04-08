//
//  ScoreModel+CoreDataProperties.swift
//  2048VKApp
//
//  Created by Alisher Saideshov on 08.04.2024.
//
//

import Foundation
import CoreData


extension ScoreModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ScoreModel> {
        return NSFetchRequest<ScoreModel>(entityName: "ScoreModel")
    }

    @NSManaged public var value: Int64

}

extension ScoreModel : Identifiable {

}
