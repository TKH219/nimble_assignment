//
//  TitleLabel.swift
//  nimble_assignment
//
//  Created by Trần Hà on 29/12/2023.
//

import Foundation
import UIKit
import SkeletonView

class TitleLabel: UILabel {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(titleString: String = "") {
        super.init(frame: CGRect.zero)
        self.text = titleString
        self.font = .boldSystemFont(ofSize: 28)
        self.textColor = .white
        self.numberOfLines = 2
        isSkeletonable = true
        skeletonTextLineHeight = .fixed(20)
        linesCornerRadius = 8
    }
}
