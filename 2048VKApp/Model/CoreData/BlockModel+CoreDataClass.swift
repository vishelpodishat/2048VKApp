//
//  BlockModel+CoreDataClass.swift
//  2048VKApp
//
//  Created by Alisher Saideshov on 08.04.2024.
//
//

import Foundation
import CoreData

@objc(BlockModel)
public class BlockModel: NSManagedObject {
    var upTile: Block?
    var rightTile: Block?
    var bottomTile: Block?
    var leftTile: Block?
}
