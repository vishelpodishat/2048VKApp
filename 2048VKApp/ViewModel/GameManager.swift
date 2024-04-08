//
//  GameManager.swift
//  2048VKApp
//
//  Created by Alisher Saideshov on 08.04.2024.
//

import UIKit

class GameManager {
    var blocks = [Block]() {
        didSet {
            refreshNeighborTiles()
        }
    }
    var dimension: Int
    private var winBlockValue: Int
    private var operationQueue = [Movement]()

    var score: Int = 0 {
        didSet {
            delegate?.scoreDidChanged(to: score)
        }
    }

    var delegate: GameManagerDelegate?
    var sourceDelegate: GameSourceDelegate?

    private var updating = false

    var isGameEnded: Bool {
        return isUserWon || isUserLost
    }

    var isUserLost: Bool = false {
        didSet {
            if isUserLost {
                delegate?.userDidLost()
            }
        }
    }
    var isUserWon: Bool = false {
        didSet{
            if isUserWon {
                delegate?.userDidWon()
            }
        }
    }

    private var newTileValue: Int {
        let rnd = arc4random() % 10
        return rnd < 2 ? 4 : 2
    }

    init(dimension: Int, winValue: Int) {
        self.dimension = dimension
        self.winBlockValue = winValue
    }

    private func reset() {
        score = 0
        isUserWon = false
        isUserLost = false
        blocks.removeAll(keepingCapacity: true)
        for row in 0..<dimension {
            for column in 0..<dimension {
                blocks.append(Block(position: Position( row, column)))
            }
        }
        refreshNeighborTiles()
    }

    func restart() {
        reset()
        start()
    }

    func start(with blocks: [Block], score: Int) {
        guard blocks.filter({$0.value != nil}).count != 0 else {
            start()
            return
        }
        self.score = score
        self.blocks = blocks
        for block in blocks.filter({$0.value != nil}) {
            delegate?.didCreatedBlock(block)
        }
        sourceDelegate?.boardValuesChanged(to: self.blocks)
    }

    func start() {
        reset()
        delegate?.didCreatedBlock(randomBlock)
        delegate?.didCreatedBlock(randomBlock)
        sourceDelegate?.boardValuesChanged(to: self.blocks)
    }

    private var randomBlock: Block? {
        if let position = randomPosition(), let block = blocks.filter({$0.position == position}).first {
            block.value = newTileValue
            return block
        }
        return nil
    }

    private func isGameOver() -> Bool {
        if blocks.filter({$0.value == nil}).count != 0 {
            return false
        }
        for block in blocks {
            let v = block.value!
            let neighbours = [
                block.upBlock,
                block.leftBlock,
                block.rightBlock,
                block.bottomBlock
            ].filter {
                $0?.value == v
            }
            if neighbours.count != 0 {
                return false
            }
        }
        return true
    }

    private func randomPosition() -> Position? {
        let emptyBlocks = blocks.filter({$0.value == nil})
        return emptyBlocks[Int(arc4random_uniform(UInt32(emptyBlocks.count)))].position
    }

    private func refreshNeighborTiles() {
        for block in blocks {
            let up = Position(block.position.x, block.position.y - 1)
            block.upBlock = blocks.filter({$0.position == up}).first

            let bottom = Position(block.position.x, block.position.y + 1)
            block.bottomBlock = blocks.filter({$0.position == bottom}).first

            let left = Position(block.position.x - 1, block.position.y)
            block.leftBlock = blocks.filter({$0.position == left}).first

            let right = Position(block.position.x + 1, block.position.y)
            block.rightBlock = blocks.filter({$0.position == right}).first
        }

    }


    func shift(to direction: Movement) {
        if updating {
            operationQueue.append(direction)
            return
        }
        updating = true
        var waitForSignalToContinue = false

        var performedShift = false
        for rowOrColumn in 0..<dimension {
            var blocksToCheck = blocks.filter {
                return ((direction == .right || direction == .left) ? $0.position.x : $0.position.y) == rowOrColumn
            }
            if direction == .right || direction == .down {
                blocksToCheck = blocksToCheck.reversed()
            }


            var blockIndex = 0
            while blockIndex < blocksToCheck.count {
                let currentBlock = blocksToCheck[blockIndex]
                let filter: ((_ tile: Block) -> Bool) = { block in
                    var position: Bool {
                        switch direction {
                        case .up: return block.position.x > currentBlock.position.x
                        case .right: return block.position.y < currentBlock.position.y
                        case .down: return block.position.x < currentBlock.position.x
                        case .left: return block.position.y > currentBlock.position.y
                        }
                    }
                    return position && block.value != nil
                }

                if let otherBlock = blocksToCheck.filter(filter).first {
                    if otherBlock.value == currentBlock.value {
                        waitForSignalToContinue = true
                        moveOnSameBlock(from: otherBlock, to: currentBlock)
                        score += currentBlock.value!
                        if currentBlock.value! == winBlockValue {
                            delegate?.userDidWon()
                            return
                        }
                        performedShift = true
                    } else if currentBlock.value == nil {
                        waitForSignalToContinue = true
                        moveOnEmptyBlock(from: otherBlock, to: currentBlock)
                        blockIndex -= 1
                        performedShift = true
                    }
                }
                blockIndex += 1
            }
        }

        if performedShift {
            delegate?.didCreatedBlock(randomBlock)
            sourceDelegate?.boardValuesChanged(to: self.blocks)
        } else {
            delegate?.nothingChangedShift(to: direction)
        }
        isUserLost = isGameOver()

        if !waitForSignalToContinue {
            updating = false
            guard let direction = operationQueue.first else {
                return
            }
            self.shift(to: direction)
            operationQueue = Array(operationQueue.dropFirst())
        }
    }



    private func moveOnSameBlock(from sourceBlock: Block, to destinationBlock: Block) {
        destinationBlock.value! *= 2
        sourceBlock.value = nil
        delegate?.didMoveBlock(from: sourceBlock, to: destinationBlock, completion: {
            self.updating = false
        })
    }

    private func moveOnEmptyBlock(from sourceBlock: Block, to destinationBlock: Block) {
        destinationBlock.value = sourceBlock.value
        sourceBlock.value = nil
        delegate?.didMoveBlock(from: sourceBlock, to: destinationBlock.position, completion: {
            self.updating = false
        })
    }

}

