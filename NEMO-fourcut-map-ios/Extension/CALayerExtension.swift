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
        x: CGFloat = 3,
        y: CGFloat = 3,
        blur: CGFloat = 10
    ) {
        self.shadowColor = color.cgColor
        self.shadowOpacity = alpha
        self.shadowOffset = CGSize(width: x, height: y)
        self.shadowRadius = blur / 2.0
    }
}
