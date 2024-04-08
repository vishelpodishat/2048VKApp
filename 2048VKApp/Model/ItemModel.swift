//
//  ItemModel.swift
//  2048VKApp
//
//  Created by Alisher Saideshov on 05.04.2024.
//

import UIKit

final class Block {
    let position: Position
    var value: Int?

    weak var upBlock: Block?
    weak var rightBlock: Block?
    weak var bottomBlock: Block?
    weak var leftBlock: Block?

    init(position: Position, value: Int? = nil) {
        self.position = position
        self.value = value
    }
}


struct Position: Equatable {
    static func == (lhs: Position, rhs: Position) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }

    var x, y: Int

    init(_ x: Int, _ y: Int) {
        (self.x, self.y) = (x, y)
    }

    func ToString() -> String {
        return "(\(x), \(y))"
    }
}
