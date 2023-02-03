//
//  SelectMultipleButtonsStackView.swift
//  NEMO-fourcut-map-ios
//
//  Created by sanghyo on 2023/01/15.
//

import UIKit

final class SelectMultipleButtonsStackView: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview()
        setUpUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let label = UILabel()
    private let explanationLabel = UILabel()
    private lazy var dryerButton = UIButton()
    private lazy var hairIronButton = UIButton()
    private lazy var combButton = UIButton()
    private lazy var labelStack = UIStackView(arrangedSubviews: [label, explanationLabel])
    private lazy var buttonStack = UIStackView(arrangedSubviews: [dryerButton, hairIronButton, combButton])
}

// MARK: - add View, set UI
private extension SelectMultipleButtonsStackView {
    
    func addSubview() {
        addArrangedSubview(labelStack)
        addArrangedSubview(buttonStack)
    }
    
    func setUpUI() {
        setLabel()
        setExplanationLabel()
        setDryerButton()
        setHairIronButton()
        setCombButton()
        setLabelStack()
        setButtonStack()
        setSelf()
    }
}

// MARK: - setUpUI
private extension SelectMultipleButtonsStackView {
    
    func setLabel() {
        label.text = "세팅 도구"
        label.font = UIFont.contentsDefaultAccent
        label.textColor = UIColor.customBlack
    }
    func setExplanationLabel() {
        explanationLabel.text = "(여러 항목 선택 가능)"
        explanationLabel.font = UIFont.mini
        explanationLabel.textColor = UIColor.darkGray
    }
    
    func setDryerButton() {
        var config = UIButton.Configuration.plain()
        var text = AttributedString.init("드라이기")
        text.font = UIFont.contentsAccent
        text.foregroundColor = .customBlack
        config.baseForegroundColor = .customBlack
        config.attributedTitle = text
        config.imagePadding = 5
        config.contentInsets = .zero
        dryerButton.configurationUpdateHandler = {
            switch $0.state {
            case .selected:
                $0.configuration?.image = ImageLiterals.filledSelectRound
                $0.configuration?.imageColorTransformer = .init {_ in UIColor.brandPink! }
            default:
                $0.configuration?.image = ImageLiterals.emptySelectRound
                $0.configuration?.imageColorTransformer = .init {_ in UIColor.customBlack! }
            }
        }
        dryerButton.configuration = config
        dryerButton.tintColor = .clear
        dryerButton.tag = 0
        dryerButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
    }
    
    func setHairIronButton() {
        var config = UIButton.Configuration.plain()
        var text = AttributedString.init("고데기")
        text.font = UIFont.contentsAccent
        text.foregroundColor = .customBlack
        config.baseForegroundColor = .customBlack
        config.attributedTitle = text
        config.imagePadding = 5
        config.contentInsets = .zero
        hairIronButton.configurationUpdateHandler = {
            switch $0.state {
            case .selected:
                $0.configuration?.image = ImageLiterals.filledSelectRound
                $0.configuration?.imageColorTransformer = .init {_ in UIColor.brandPink! }
            default:
                $0.configuration?.image = ImageLiterals.emptySelectRound
                $0.configuration?.imageColorTransformer = .init {_ in UIColor.customBlack! }
            }
        }
        hairIronButton.configuration = config
        hairIronButton.tintColor = .clear
        hairIronButton.tag = 1
        hairIronButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
    }
    
    func setCombButton() {
        var config = UIButton.Configuration.plain()
        var text = AttributedString.init("빗")
        text.font = UIFont.contentsAccent
        text.foregroundColor = .customBlack
        config.baseForegroundColor = .customBlack
        config.attributedTitle = text
        config.imagePadding = 5
        config.contentInsets = .zero
        combButton.configurationUpdateHandler = {
            switch $0.state {
            case .selected:
                $0.configuration?.image = ImageLiterals.filledSelectRound
                $0.configuration?.imageColorTransformer = .init {_ in UIColor.brandPink! }
            default:
                $0.configuration?.image = ImageLiterals.emptySelectRound
                $0.configuration?.imageColorTransformer = .init {_ in UIColor.customBlack! }
            }
        }
        combButton.configuration = config
        combButton.tintColor = .clear
        combButton.tag = 2
        combButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
    }
    
    func setLabelStack() {
        labelStack.axis = .horizontal
        labelStack.alignment = .center
        labelStack.distribution = .fill
        labelStack.spacing = 20
    }
    
    func setButtonStack() {
        buttonStack.axis = .horizontal
        buttonStack.alignment = .center
        buttonStack.distribution = .equalSpacing
        buttonStack.spacing = 10
    }
    
    func setSelf() {
        axis = .vertical
        alignment = .leading
        distribution = .fill
        spacing = 10
    }
}

// MARK: - objc method
private extension SelectMultipleButtonsStackView {
    @objc func tapButton(_ sender: UIButton) {
        if let button = buttonStack.arrangedSubviews[sender.tag] as? UIButton {
            button.isSelected = button.isSelected ? false : true
        }
    }
}

#if DEBUG
import SwiftUI

struct SelectMultipleButtonsStackViewPreview: PreviewProvider {
    static var previews: some View {
        VStack {
            SelectMultipleButtonsStackView()
                .toPreview()
                .frame(width: UIScreen.main.bounds.width, height: 100)
        }
    }
}
#endif
