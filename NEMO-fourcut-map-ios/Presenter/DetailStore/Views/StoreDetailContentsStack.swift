//
//  StoreDetailContentsStack.swift
//  NEMO-fourcut-map-ios
//
//  Created by sanghyo on 2022/10/20.
//

import Foundation
import UIKit

final class StoreDetailContentsStack: UIStackView {
    
    private let label = UILabel()
    private let contents = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAddSubviews()
        configureUI()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(labelText: String, contentsText: String? = nil) {
        self.init(frame: .zero)
        bindLabel(text: labelText)
        bindContents(text: contentsText)
    }
    
    private func bindLabel(text: String) {
        label.text = text
        label.font = UIFont.contentsDefaultAccent
        label.textColor = .customBlack
    }

    private func bindContents(text: String?) {
        contents.text = text == nil ? "아직 등록된 정보가 없습니다" : text!
        contents.font = UIFont.contentsDefault
        contents.textColor = text == nil ? .darkGray : .customBlack
    }
    
    // MARK: - configure
    
    private func configureAddSubviews() {
        addArrangedSubview(label)
        addArrangedSubview(contents)
    }
    
    private func configureUI() {
        axis = .horizontal
        spacing = 10
        distribution = .equalSpacing
        alignment = .center
    }
}
