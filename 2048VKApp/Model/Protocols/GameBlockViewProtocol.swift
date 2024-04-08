//
//  GameBlockViewProtocol.swift
//  2048VKApp
//
//  Created by Alisher Saideshov on 06.04.2024.
//

import UIKit

protocol GameManagerDelegate {
    func userDidLost()
    func scoreDidChanged(to score: Int)
    func userDidWon()
    func nothingChangedShift(to direction: Movement)
    func didCreatedBlock(_ block: Block?)
    func didMoveBlock(from source: Block, to destination: Block, completion: @escaping ()->Void)
    func didMoveBlock(from source: Block, to destination: Position, completion: @escaping ()->Void)
}

protocol GameSourceDelegate {
    func boardValuesChanged(to blocks: [Block])
}

