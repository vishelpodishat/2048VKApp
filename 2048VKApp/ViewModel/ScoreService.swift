//
//  ScoreService.swift
//  2048VKApp
//
//  Created by Alisher Saideshov on 08.04.2024.
//

import UIKit

protocol ScoreStorageProtocol {
    func saveCurrentScore(_ score: Int)
    func saveHighestScore(_ score: Int)
    func fetchCurrentScore() -> Int
    func fetchHighestScore() -> Int
}

final class ScoreStorage: ScoreStorageProtocol {

    enum CodingKeys {
        static var currentScore = "currentScore"
        static var highestScore = "highestScore"
    }

    func fetchCurrentScore() -> Int {
        return UserDefaults.standard.integer(forKey: CodingKeys.currentScore)
    }
    func fetchHighestScore() -> Int {
        return UserDefaults.standard.integer(forKey: CodingKeys.highestScore)
    }

    func saveCurrentScore(_ score: Int) {
        UserDefaults.standard.set(score, forKey: CodingKeys.currentScore)
    }
    func saveHighestScore(_ score: Int) {
        if score > fetchHighestScore() {
            UserDefaults.standard.set(score, forKey: CodingKeys.highestScore)
        }
    }
}
