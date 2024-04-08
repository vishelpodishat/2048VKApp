//
//  GameViewModel.swift
//  2048VKApp
//
//  Created by Alisher Saideshov on 06.04.2024.
//

import UIKit
import CoreData

final class GameViewModel {
    
    // MARK: - Singletion
    static let shared = GameViewModel()

    func save(currentScore: Int, for dimention: Int) {
        UserDefaults.standard.set(currentScore, forKey: Key.currentScore(for: dimention).key)
    }

    func loadCurrentScore(for dimention: Int) -> Int {
        return UserDefaults.standard.integer(forKey: Key.currentScore(for: dimention).key)
    }


    func save(highScore: Int, for dimention: Int) {
        UserDefaults.standard.set(highScore, forKey: Key.highScore(for: dimention).key)
    }

    func loadHighScore(for dimention: Int) -> Int {
        return UserDefaults.standard.integer(forKey: Key.highScore(for: dimention).key)
    }

    func save(dimension: Int, blocks: [Block]) {
        deleteAllTiles()
        for block in blocks {
            let blockModel = BlockModel(context: GameSessionService.context)
            blockModel.positionX = Int16(block.position.x)
            blockModel.positionY = Int16(block.position.y)
            blockModel.blockValue = Int32(block.value ?? 0)
            GameSessionService.saveContext()
        }
    }

    func loadTiles(dimension: Int) -> [Block] {
        let fetchRequest: NSFetchRequest<BlockModel> = BlockModel.fetchRequest()
        var blocks = [Block]()
        do {
            let blockModels = try GameSessionService.context.fetch(fetchRequest)
            for blockModel in blockModels {
                if blockModel.blockValue == 0 {
                    blocks.append(
                        Block(
                            position: Position(
                                Int(
                                    blockModel.positionX
                                ),
                                Int(
                                    blockModel.positionY
                                )
                            ),
                            value: nil
                        )
                    )
                } else {
                    blocks.append(
                        Block(
                            position: Position(
                                Int(
                                    blockModel.positionX
                                ),
                                Int(
                                    blockModel.positionY
                                )
                            ),
                            value: Int(
                                blockModel.blockValue
                            )
                        )
                    )
                }
            }
        } catch {}

        return blocks
    }

    func deleteAllTiles() {
        let context = GameSessionService.context
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "BlockModel")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try context.execute(deleteRequest)
            try context.save()
        }
        catch{}
    }
}

// MARK: - Key
extension GameViewModel {
    enum Key {

        case highScore(for: Int)
        case currentScore(for: Int)

        var key: String {
            switch self {
            case .highScore(let dimention):
                return "Рекорд \(dimention)"
            case .currentScore(let dimention):
                return "Текущий счет \(dimention)"
            }
        }
    }
}
