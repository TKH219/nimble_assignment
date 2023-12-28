//
//  UIView+.swift
//  nimble_assignment
//
//  Created by Trần Hà on 28/12/2023.
//

import Foundation
import UIKit

extension UIView {
    func asImage(bounds: CGRect) -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
