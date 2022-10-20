//
//  StoreDetailContentsStack.swift
//  NEMO-fourcut-map-ios
//
//  Created by sanghyo on 2022/10/20.
//

import Foundation
import UIKit

final class StoreDetailContentsStack: UIStackView {
    
    private var labelText: String = "" {
        didSet {
            bindLabel(text: labelText)
        }
    }
    private var contentsText: String? = nil {
        didSet {
            bindContents(text: contentsText)
        }
    }
    
    private let label = UILabel()
    private let contents = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        configureAddSubviews()
        configureUI()
    }
    
    convenience init(labelText: String, contentsText: String? = nil) {
        self.init(frame: .zero)
        self.labelText = labelText
        self.contentsText = contentsText
    }
    
    private func bindLabel(text: String) {
        label.text = text
        label.font = UIFont.contentsDefaultAccent
        label.textColor = .customBlack
    }
    
    private func bindContents(text: String?) {
        label.text = text == nil ? "아직 등록된 정보가 없습니다" : text!
        contents.font = UIFont.contentsDefault
        contents.textColor = text == "" ? .darkGray : .customBlack
    }
    
    // MARK: - configure
    private func configureAddSubviews() {
        addArrangedSubview(label)
        addArrangedSubview(contents)
    }
    
    private func configureUI() {
        axis = .horizontal
        distribution = .fill
        alignment = .center
        spacing = 10
    }
}
