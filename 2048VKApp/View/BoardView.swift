//
//  BoardView.swift
//  2048VKApp
//
//  Created by Alisher Saideshov on 04.04.2024.
//

import UIKit

final class BoardView: UIView {

    // MARK: - Properties
    static let radius: CGFloat = 4.0

    let dimension: Int
    let tileSize: CGSize
    var spaceBtwTiles: CGFloat = 8
    var tileRects = [CGRect]()

    init(dimension: Int, offsetBtwTiles: CGFloat, boardSize: CGSize) {
        guard boardSize.height == boardSize.width else {
            fatalError("Square board!")
        }
        self.dimension = dimension
        self.spaceBtwTiles = offsetBtwTiles

        let sizeLength = (Double(boardSize.height) - Double(spaceBtwTiles) * Double(self.dimension + 1)) / Double(self.dimension)
        tileSize = CGSize(width: sizeLength, height: sizeLength)
        super.init(frame: CGRect(origin: CGPoint.zero, size: boardSize))

        setupBackGround()
        setupEmptyTiles()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup
extension BoardView {
    private func setupBackGround() {
        self.layer.cornerRadius = BoardView.radius
        self.backgroundColor = AppColors.grey
    }

    private func setupEmptyTiles() {
        var point = CGPoint(x: spaceBtwTiles, y: spaceBtwTiles)
        for x in 0..<dimension  {
            point.x = spaceBtwTiles
            for y in 0..<dimension {
                let backgroundTile = EmptyBlock(position: Position(x, y), 
                                               frame: CGRect(origin: point, size: tileSize))
                self.addSubview(backgroundTile)
                tileRects.append(backgroundTile.frame)

                point.x += spaceBtwTiles + tileSize.height
            }
            point.y += spaceBtwTiles + tileSize.height
        }
    }

    func positionRect(position: Position) -> CGRect {
        return tileRects[position.x * dimension + position.y]
    }

}
