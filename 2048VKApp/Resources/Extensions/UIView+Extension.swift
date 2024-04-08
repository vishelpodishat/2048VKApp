//
//  UIView+Extension.swift
//  2048VKApp
//
//  Created by Alisher Saideshov on 04.04.2024.
//

import UIKit

extension UIView {
    /// Description - Отключаю ТАМИК для обьектов во вью
    func addView(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
    }
}
