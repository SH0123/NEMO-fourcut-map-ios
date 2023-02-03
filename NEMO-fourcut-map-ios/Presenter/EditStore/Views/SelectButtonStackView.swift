//
//  selectButtonStackView.swift
//  NEMO-fourcut-map-ios
//
//  Created by sanghyo on 2023/01/15.
//

import UIKit

final class SelectButtonStackView: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(_ labelTitle: String) {
        self.init(frame: .zero)
        setLabel(labelTitle)
        addSubview()
        setUpUI()
    }
    
    private let label = UILabel()
    private lazy var possibleButton = UIButton()
    private lazy var impossibleButton = UIButton()
    private lazy var buttonStack = UIStackView(arrangedSubviews: [possibleButton, impossibleButton])
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: 100, height: 50)
    }
}

private extension SelectButtonStackView {
    
    func addSubview() {
        addArrangedSubview(label)
        addArrangedSubview(buttonStack)
    }
    
    func setUpUI() {
        setPossibleButton()
        setImpossibleButton()
        setButtonStack()
        setSelf()
    }
}

private extension SelectButtonStackView {
    
    func setLabel(_ labelTitle: String) {
        label.font = UIFont.contentsDefaultAccent
        label.text = labelTitle
        label.textColor = UIColor.customBlack
    }
    
    func setPossibleButton() {
        var configuration = UIButton.Configuration.plain()
        var title = AttributedString.init("가능")
        title.font = UIFont.contentsAccent
        configuration.attributedTitle = title
        configuration.imagePadding = 15
        configuration.baseForegroundColor = .customBlack
        possibleButton.configurationUpdateHandler = {
            switch $0.state {
            case .selected:
                $0.configuration?.image = ImageLiterals.filledCheckSquare
            default:
                $0.configuration?.image = ImageLiterals.emptyCheckSquare
            }
        }
        possibleButton.configuration = configuration
        possibleButton.tintColor = .clear
        possibleButton.tag = 0
        possibleButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
    }
    
    func setImpossibleButton() {
        var configuration = UIButton.Configuration.plain()
        var title = AttributedString.init("불가능")
        title.font = UIFont.contentsAccent
        configuration.attributedTitle = title
        configuration.imagePadding = 15
        configuration.baseForegroundColor = .customBlack
        impossibleButton.configurationUpdateHandler = {
            switch $0.state {
            case .selected:
                $0.configuration?.image = ImageLiterals.filledCheckSquare
            default:
                $0.configuration?.image = ImageLiterals.emptyCheckSquare
            }
        }
        impossibleButton.configuration = configuration
        impossibleButton.tintColor = .clear
        impossibleButton.tag = 1
        impossibleButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
    }
    
    func setButtonStack() {
        buttonStack.axis = .horizontal
        buttonStack.alignment = .center
        buttonStack.distribution = .fillProportionally
        buttonStack.spacing = 40
    }
    
    func setSelf() {
        axis = .vertical
        alignment = .leading
        distribution = .fill
        spacing = 10
    }
}

private extension SelectButtonStackView {
    @objc func tapButton(_ sender: UIButton) {
        clearButtonSelected()
        
        switch sender.tag {
        case 0:
            possibleButton.isSelected = true
        case 1:
            impossibleButton.isSelected = true
        default:
            break
        }
    }
    
    func clearButtonSelected() {
        possibleButton.isSelected = false
        impossibleButton.isSelected = false
    }
}

#if DEBUG
import SwiftUI
struct SelectButtonSTackViewPreview: PreviewProvider {
    static var previews: some View {
        VStack {
            SelectButtonStackView("리모컨 사용")
                .toPreview()
                .frame(width: 150, height: 60)
            SelectButtonStackView("QR 코드 생성")
                .toPreview()
                .frame(width: 150, height: 60)
        }
    }
}
#endif
