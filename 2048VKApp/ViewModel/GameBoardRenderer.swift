//
//  GameBoardRenderer.swift
//  2048VKApp
//
//  Created by Alisher Saideshov on 08.04.2024.
//

import UIKit

class GameBoardRenderer {
    var board: BoardView
    private var blockViews = [BlockView]()
    let moveSpeed = 0.1
    init(board: BoardView) {
        self.board = board
    }

    func reset() {
        for view in blockViews {
            view.removeFromSuperview()
        }
        blockViews.removeAll(keepingCapacity: false)
    }


    func failedShifting(to direction: Movement) {
        let delta: CGFloat = 30
        var deltaPoint: CGPoint {
            switch direction {
            case .up:
                return CGPoint(x: 0, y: -delta)
            case .down:
                return CGPoint(x: 0, y: delta)
            case .left:
                return CGPoint(x: -delta, y: 0)
            case .right:
                return CGPoint(x: delta, y: 0)
            }
        }
        for tile in blockViews {
            UIView.animate(withDuration: moveSpeed, animations: {
                tile.frame.origin = tile.frame.origin + deltaPoint
            }, completion: { _ in
                UIView.animate(withDuration: self.moveSpeed * 2, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 7, options: .curveEaseOut, animations: {
                    tile.frame.origin = tile.frame.origin - deltaPoint
                }, completion: nil)
            })
        }
    }

    func move(from sourceBlock: Block, to destinationBlock: Block, completion: @escaping () -> Void) {
        let sourceBlockView = blockViews.filter({$0.position == sourceBlock.position}).first!
        let destinationBlockView = blockViews.filter({$0.position == destinationBlock.position}).first!
        board.bringSubviewToFront(sourceBlockView)

        UIView.animate(withDuration: moveSpeed, delay: 0, options: .curveEaseInOut, animations: {
            sourceBlockView.center = destinationBlockView.center
            sourceBlockView.position = destinationBlock.position
            destinationBlockView.alpha = 0

            sourceBlockView.value = destinationBlock.value!
        }) { (finished) -> Void in

            guard finished else {
                return
            }

            UIView.animate(withDuration: self.moveSpeed, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 7, options: .curveEaseOut, animations: {
                sourceBlockView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            }, completion: { _ in
                sourceBlockView.transform = .identity
            })
            destinationBlockView.alpha = 0
            destinationBlockView.removeFromSuperview()
            if let index = self.blockViews.index(of: destinationBlockView) {
                self.blockViews.remove(at: index)
            }
            completion()
        }
    }

    func move(from block: Block, to position: Position, completion: @escaping () -> Void) {
        let blockView = blockViews.filter({$0.position == block.position}).first!
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: {
            blockView.frame.origin = self.board.positionRect(position: position).origin
            blockView.position = position
        }) { _ in
            completion()
        }
    }

    func add(block: Block) {
        let blockView = BlockView(value: block.value!,
                                 position: block.position,
                                 frame: board.positionRect(position: block.position))
        board.addSubview(blockView)
        board.bringSubviewToFront(blockView)

        // appearance animation
        let scale: CGFloat = 0.2
        blockView.transform = CGAffineTransform(scaleX: scale, y: scale)
        blockView.alpha = 0
        UIView.animate(withDuration: self.moveSpeed * 2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 7, options: .curveEaseOut, animations: {
            blockView.transform = CGAffineTransform(scaleX: 1, y: 1)
            blockView.alpha = 1.0
        }, completion: nil)
        self.blockViews.append(blockView)
    }

}

