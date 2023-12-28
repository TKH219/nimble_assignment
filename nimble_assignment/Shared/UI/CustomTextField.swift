//
//  CustomTextField.swift
//  nimble_assignment
//
//  Created by Trần Hà on 24/12/2023.
//

import Foundation

import UIKit

class CustomTextField: UITextField {
    
    let padding: UIEdgeInsets
    
    init(padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 10)) {
        self.padding = padding
        super.init(frame: .zero)
        self.setOverlay()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    enum Direction {
        case Left
        case Right
    }
    
    func addIconWithImage(direction: Direction, image: UIImage) {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25 + 10, height: 25))
        imageView.contentMode = .center
        imageView.image = image
        switch direction {
        case .Left:
            self.leftView = imageView
            self.leftViewMode = .always
        case .Right:
            self.rightView = imageView
            self.rightViewMode = .always
            
        }
    }
    
    func setPlaceHolder(_ text: String) {
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.lightGray,
        ]
        
        self.attributedPlaceholder = NSAttributedString(string: text, attributes:attributes)
    }
    
    func setOverlay() {
        self.layer.cornerRadius = 12
        self.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.18)
    }
}
