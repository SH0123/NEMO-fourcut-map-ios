//
//  StoreDetailInfoCard.swift
//  NEMO-fourcut-map-ios
//
//  Created by sanghyo on 2022/10/19.
//

import Foundation
import UIKit

final class StoreDetailInfoCard: UIView {
    
    private let cardView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let remoteControllerStack: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()
    
    private let qrStack: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()
    
    private let cardPaymentStack: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()
    
    private let toolsStack: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()
    
    private let seasonThemaStack: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()
    
    private let disneyThemaStack: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAddsubviews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - configure
    
    private func configureAddsubviews() {
        
    }
    
    private func configureConstraints() {
        
    }
}
