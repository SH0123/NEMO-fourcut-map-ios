//
//  PaddingLabel.swift
//  NEMO-fourcut-map-ios
//
//  Created by sanghyo on 2023/01/12.
//

import UIKit

final class PaddingLabel: UILabel {
    private var inset: UIEdgeInsets = .init(top: 8, left: 16, bottom: 8, right: 16)
    
    convenience init(inset: UIEdgeInsets) {
        self.init()
        self.inset = inset
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: inset))
    }
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += inset.top + inset.bottom
        contentSize.width += inset.left + inset.right
        
        return contentSize
    }
}
