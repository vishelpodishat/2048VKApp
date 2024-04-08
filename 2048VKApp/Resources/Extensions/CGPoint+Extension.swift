//
//  CGPoint+Extension.swift
//  2048VKApp
//
//  Created by Alisher Saideshov on 08.04.2024.
//

import UIKit

extension CGPoint {
    static func +(one: CGPoint, other: CGPoint) -> CGPoint {
        return CGPoint(x: one.x + other.x, y: one.y + other.y)
    }

    static func -(one: CGPoint, other: CGPoint) -> CGPoint {
        return CGPoint(x: one.x - other.x, y: one.y - other.y)
    }
}
