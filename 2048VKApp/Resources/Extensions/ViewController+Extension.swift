//
//  ViewController+Extension.swift
//  2048VKApp
//
//  Created by Alisher Saideshov on 06.04.2024.
//

import UIKit

extension GameViewController {

    func removeGestures() {
        self.view.gestureRecognizers?.removeAll()
    }

    // MARK: - Swipes
    func setupGestureRecognizer() {
        let up = UISwipeGestureRecognizer(target: self, action: #selector(upGestureSwiped))
        up.direction = .up

        let left = UISwipeGestureRecognizer(target: self, action: #selector(leftGestureSwiped))
        left.direction = .left

        let right = UISwipeGestureRecognizer(target: self, action: #selector(rightGestureSwiped))
        right.direction = .right

        let down = UISwipeGestureRecognizer(target: self, action: #selector(downGestureSwiped))
        down.direction = .down

        self.view.addGestureRecognizer(left)
        self.view.addGestureRecognizer(right)
        self.view.addGestureRecognizer(up)
        self.view.addGestureRecognizer(down)
    }

    @objc private func upGestureSwiped() {
        manager.shift(to: .up)
    }

    @objc private func leftGestureSwiped() {
        manager.shift(to: .left)
    }

    @objc private func rightGestureSwiped() {
        manager.shift(to: .right)
    }

    @objc private func downGestureSwiped() {
        manager.shift(to: .down)
    }
}
