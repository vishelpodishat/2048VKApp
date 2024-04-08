//
//  HighScoreModel+CoreDataProperties.swift
//  2048VKApp
//
//  Created by Alisher Saideshov on 08.04.2024.
//
//

import Foundation
import CoreData


extension HighScoreModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HighScoreModel> {
        return NSFetchRequest<HighScoreModel>(entityName: "HighScoreModel")
    }

    @NSManaged public var value: Int64

}

extension HighScoreModel : Identifiable {

}
