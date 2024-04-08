//
//  ViewController.swift
//  2048VKApp
//
//  Created by Alisher Saideshov on 04.04.2024.
//

import UIKit

final class GameViewController: UIViewController {

    // MARK: - Properties
    var manager: GameManager!
    var score: ScoreView!
    var highScore: HighScore!
    var renderer: GameBoardRenderer!
    var restartButton: RestartButton!

    var dimensions : Int {
        return 4
    }

    var extraSpace: CGFloat { // constant
        return 13
    }

    var winValue: Int { // constant
        return 2048
    }

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setDimention(to: dimensions)
        setupGestureRecognizer()
        manager.start(with: GameViewModel.shared.loadTiles(dimension: manager.dimension), score: score.value)
    }

    @objc private func restartGame() {
        let alert = UIAlertController(title: "Are sure to start new game?", message: "Current results will be lost", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
            self.renderer.reset()
            self.manager.start()
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    private func setDimention(to dimension: Int) {
        self.clearSubviews()

        let boardSize = CGSize(width: self.view.frame.width - (extraSpace + 1) * 2, height: self.view.frame.width - (extraSpace + 1) * 2)
        let board = BoardView(dimension: dimension, offsetBtwTiles: extraSpace, boardSize: boardSize)
        board.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(board)
        board.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        board.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        board.widthAnchor.constraint(equalToConstant: board.frame.width).isActive = true
        board.heightAnchor.constraint(equalToConstant: board.frame.height).isActive = true

        manager = GameManager(dimension: dimension, winValue: winValue)
        manager.delegate = self
        manager.sourceDelegate = self

        renderer = GameBoardRenderer(board: board)

        let scoreSize = CGSize(width: 100, height: 50)
        score = ScoreView(frame: CGRect(origin: CGPoint.zero, size: scoreSize))
        score.value = GameViewModel.shared.loadCurrentScore(for: dimension)
        score.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(score)
        score.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        score.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -extraSpace).isActive = true
        score.widthAnchor.constraint(equalToConstant: score.frame.width).isActive = true
        score.heightAnchor.constraint(equalToConstant: score.frame.height).isActive = true

        highScore = HighScore(frame: CGRect(origin: CGPoint.zero, size: scoreSize))
        highScore.value = GameViewModel.shared.loadHighScore(for: dimension)
        highScore.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(highScore)
        highScore.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        highScore.trailingAnchor.constraint(equalTo: score.leadingAnchor, constant: -extraSpace).isActive = true
        highScore.widthAnchor.constraint(equalToConstant: highScore.frame.width).isActive = true
        highScore.heightAnchor.constraint(equalToConstant: highScore.frame.height).isActive = true

        restartButton = RestartButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: scoreSize.width, height:
        scoreSize.height * 0.6)))
        restartButton.translatesAutoresizingMaskIntoConstraints = false
        restartButton.addTarget(self, action: #selector(restartGame), for: .touchUpInside)
        self.view.addSubview(restartButton)
        restartButton.topAnchor.constraint(equalTo: score.bottomAnchor, constant: extraSpace).isActive = true
        restartButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -extraSpace).isActive = true
        restartButton.widthAnchor.constraint(equalToConstant: restartButton.frame.width).isActive = true
        restartButton.heightAnchor.constraint(equalToConstant: restartButton.frame.height).isActive = true
    }

    private func clearSubviews() {
        view.backgroundColor = AppColors.white
        self.view.subviews.forEach({ $0.removeFromSuperview() })
    }
}

// MARK: Source
extension GameViewController: GameSourceDelegate {
    func boardValuesChanged(to blocks: [Block]) {
        GameViewModel.shared.save(dimension: manager.dimension, blocks: blocks)
    }
}

extension GameViewController: GameManagerDelegate {
    func userDidLost() {
        let alert = UIAlertController(title: "Ты проиграл",
                                      message: "Попытайся в другой раз",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Перезапустить", style: .default, handler: { _ in
            self.renderer.reset()
            self.manager.restart()
        }))
        self.present(alert, animated: true, completion: nil)
    }

    func scoreDidChanged(to score: Int) {
        self.score.value = score
        GameViewModel.shared.save(currentScore: score, for: manager.dimension)
        if highScore.value < score {
            self.highScore.value = score
            GameViewModel.shared.save(highScore: score, for: manager.dimension)
        }
    }

    func nothingChangedShift(to direction: Movement) {
        renderer.failedShifting(to: direction)
    }

    func didCreatedBlock(_ block: Block?) {
        guard let block = block else {
            return
        }
        renderer.add(block: block)
    }

    func didMoveBlock(from source: Block, to destination: Block, completion: @escaping () -> Void) {
        renderer.move(from: source, to: destination, completion: completion)
    }

    func didMoveBlock(from source: Block, to destination: Position, completion: @escaping () -> Void) {
        renderer.move(from: source, to: destination, completion: completion)

    }

    func userDidWon() {
        let alert = UIAlertController(title: "You win", message: "I've reached \(winValue)!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

