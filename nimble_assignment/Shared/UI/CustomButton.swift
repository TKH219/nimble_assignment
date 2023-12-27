//
//  CustomButton.swift
//  nimble_assignment
//
//  Created by Trần Hà on 24/12/2023.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    
    var completionBlock: (() -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.setTitleColor(.black, for: .normal) //.black_151A
        self.layer.cornerRadius = 10
        self.addTarget(self, action: #selector(onTapButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc func onTapButton() {
        completionBlock?()
    }
}
