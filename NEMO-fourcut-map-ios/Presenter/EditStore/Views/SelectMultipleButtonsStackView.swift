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
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init() {
        self.init(frame: .zero)
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
        
    }
    
    func setExplanationLabel() {
        
    }
    
    func setDryerButton() {
        
    }
    
    func setHairIronButton() {
        
    }
    
    func setCombButton() {
        
    }
    
    func setLabelStack() {
        
    }
    
    func setButtonStack() {
        
    }
    
    func setSelf() {
        
    }
}

// MARK: - objc method
private extension SelectMultipleButtonsStackView {
    
}

#if DEBUG
import SwiftUI

struct SelectMultipleButtonsStackViewPreview: PreviewProvider {
    static var previews: some View {
        VStack {
            
        }
    }
}
#endif
