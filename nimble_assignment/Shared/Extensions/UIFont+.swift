//
//  UIFont+.swift
//  nimble_assignment
//
//  Created by Trần Hà on 24/12/2023.
//

import UIKit

enum Font: String {
    case regular = "NeuzeitSLTStd-Book"
    case bold = "NeuzeitSLTStd-BookHeavy"
}

extension Font {
    func size(_ size: CGFloat) -> UIFont {
        return UIFont(name: self.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    var normal: UIFont { return size(14) }
    
    var medium: UIFont { return size(16) }
    
    var bigTitle: UIFont { return size(22) }
    
    var mediumTitle: UIFont { return size(20) }
    
    var title: UIFont { return size(18) }
    
    var subttile: UIFont { return size(15) }
    
    var small: UIFont { return size(12) }
    
    var smaller: UIFont { return size(10) }
}
