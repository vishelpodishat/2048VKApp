//
//  HighScore.swift
//  2048VKApp
//
//  Created by Alisher Saideshov on 08.04.2024.
//

import UIKit

class HighScore: ScoreView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.label.text = "High Score"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("coder isn't allowed")
    }
}
