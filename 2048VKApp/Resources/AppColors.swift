//
//  AppColors.swift
//  2048VKApp
//
//  Created by Alisher Saideshov on 04.04.2024.
//

import UIKit

enum AppColors {
    static let primaryBlue = UIColor().hex(0x2D81E0)
    static let white = UIColor().hex(0xFFFFFF)
    static let progressStatus = UIColor().hex(0xE2EAE4)
    static let green = UIColor().hex(0xE2EAE4)
    static let black = UIColor().hex(0x000000)
    static let bubbleBlue = UIColor().hex(0xCCE4FF)
    static let grey = UIColor().hex(0xAEB7C2)
    static let red = UIColor().hex(0xE64646)
    static let gridColor = UIColor().hex(0xF5F5F5)

    enum CellColor {
        static let block2 = UIColor().hex(0xADFF2F)
        static let block4 = UIColor().hex(0x7FFF00)
        static let block8 = UIColor().hex(0x7CFC00)
        static let block16 = UIColor().hex(0x00FF00)
        static let block32 = UIColor().hex(0x9ACD32)
        static let block64 = UIColor().hex(0x3CB371)
        static let block128 = UIColor().hex(0x32CD32)
        static let block256 = UIColor().hex(0x2E8B57)
        static let block512 = UIColor().hex(0x228B22)
        static let block1024 = UIColor().hex(0x008000)
        static let block2048 = UIColor().hex(0x006400)
        static let defaultBlock = UIColor().hex(0x818C99)
    }
}
