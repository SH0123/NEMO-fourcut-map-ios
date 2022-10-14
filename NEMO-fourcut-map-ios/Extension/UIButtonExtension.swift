//
//  UIButtonExtension.swift
//  NEMO-fourcut-map-ios
//
//  Created by sanghyo on 2022/09/23.
//

import Foundation
import UIKit

extension UIButton {
    func setButtonProperty(backgroundColor: UIColor?, radius: CGFloat, top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) -> UIButton {
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = radius
        self.contentEdgeInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        self.layer.applyShadow(alpha: 0.15, x: 0, y: 1)
        return self
    }
}
