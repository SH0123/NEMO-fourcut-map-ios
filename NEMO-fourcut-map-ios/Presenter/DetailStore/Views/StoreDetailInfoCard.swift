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
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.customGray?.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    private let remoteControllerStack = StoreDetailContentsStack(labelText: "리모컨 사용")
    private let qrStack = StoreDetailContentsStack(labelText: "QR 코드 생성")
    private let cardPaymentStack = StoreDetailContentsStack(labelText: "카드 결제")
    private let toolsStack = StoreDetailContentsStack(labelText: "세팅 도구")
    private let seasonThemaStack = StoreDetailContentsStack(labelText: "시즌 테마 프레임")
    private let disneyThemaStack = StoreDetailContentsStack(labelText: "디즈니 테마 프레임")
    
    private lazy var cardStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 10
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
        addSubviews(
            cardView,
            cardStack
        )
    }
    
    private func configureConstraints() {
        cardView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        cardStack.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview().inset(8)
        }
    }
}
