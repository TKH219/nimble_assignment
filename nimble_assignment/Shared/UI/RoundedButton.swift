//
//  RoundedButton.swift
//  nimble_assignment
//
//  Created by Trần Hà on 29/12/2023.
//

import UIKit

class RoundedButton: UIButton {
    
    init(imageString: String?) {
        super.init(frame: CGRect.zero)
        if let image = imageString {
            self.setImage(UIImage(named: image), for: .normal)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.layer.cornerRadius = self.bounds.height / 2
    }
}
