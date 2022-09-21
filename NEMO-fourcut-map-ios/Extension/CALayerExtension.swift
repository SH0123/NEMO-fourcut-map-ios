//
//  CALayerExtension.swift
//  NEMO-fourcut-map-ios
//
//  Created by sanghyo on 2022/09/21.
//

import Foundation
import UIKit

extension CALayer {
    func applyShadow(
        color: UIColor = .gray,
        alpha: Float = 0.1,
        x: CGFloat = 0,
        y: CGFloat = 5,
        blur: CGFloat = 15
    ) {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
    }
}
