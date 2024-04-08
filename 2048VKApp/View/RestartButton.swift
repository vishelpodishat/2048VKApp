//
//  RestartButton.swift
//  2048VKApp
//
//  Created by Alisher Saideshov on 06.04.2024.
//

import UIKit

final class RestartButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        var configuration = UIButton.Configuration.filled()
        backgroundColor = AppColors.bubbleBlue
        setTitle("Перезапустить", for: .normal)
        setTitleColor(AppColors.black, for: .normal)
        layer.cornerRadius = 5
        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.borderColor = AppColors.black.cgColor
        titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        titleLabel?.textAlignment = .center
        titleLabel?.adjustsFontSizeToFitWidth = true
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 6, bottom: 4, trailing: 6)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
