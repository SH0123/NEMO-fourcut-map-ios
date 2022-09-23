//
//  NSObjectExtension.swift
//  NEMO-fourcut-map-ios
//
//  Created by sanghyo on 2022/09/23.
//

import Foundation

extension NSObject {
    static var className: String {
        return String(describing: self)
    }
}
