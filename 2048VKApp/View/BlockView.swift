//
//  BlockView.swift
//  2048VKApp
//
//  Created by Alisher Saideshov on 08.04.2024.
//

import UIKit

final class BlockView: EmptyBlock {

    var value: Int {
        didSet {
            if value == 0 {
                self.label.isHidden = true
                return
            }
            updateAttibutes()
        }
    }

    let label : UILabel

    init(value: Int, position: Position, frame: CGRect) {
        self.label = UILabel(frame: CGRect(origin: CGPoint.zero, size: frame.size))
        self.value = value
        super.init(position: position, frame: frame)
        self.label.textAlignment = .center
        self.label.numberOfLines = 1
        self.label.font = UIFont(name: "Helvetica-Bold", size: self.frame.height * 2 / 3)
        self.label.minimumScaleFactor = 1 / self.label.font.pointSize
        self.label.adjustsFontSizeToFitWidth = true
        self.addSubview(label)
        self.layer.cornerRadius = BoardView.radius

        self.value = value
        updateAttibutes()
    }

    private func updateAttibutes() {
        self.label.isHidden = false
        self.label.text = "\(value)"

        self.backgroundColor = App.tile(value: value).color
        self.label.textColor = App.tileText(value: value).color
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("coder isn't allowed")
    }
}


class EmptyBlock: UIView {
    var position: Position

    init(position: Position, frame: CGRect) {
        self.position = position
        super.init(frame: frame)
        self.backgroundColor = App.tile(value: nil).color
        self.layer.cornerRadius = BoardView.radius
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
