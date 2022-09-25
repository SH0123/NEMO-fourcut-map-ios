//
//  UIViewExtension.swift
//  NEMO-fourcut-map-ios
//
//  Created by sanghyo on 2022/09/21.
//

import Foundation
import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
