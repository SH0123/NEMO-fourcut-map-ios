//
//  StoreDetailInfoCard.swift
//  NEMO-fourcut-map-ios
//
//  Created by sanghyo on 2022/10/18.
//

import Foundation
import UIKit
import SnapKit

final class StoreInfoCard: UIView {
    
    var store: FourcutStore? {
        didSet {
            setContents(store: store)
        }
    }
    
    private let infoCardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.applyShadow(x: 0, y: 5, blur: 15)
        return view
    }()
    
    private lazy var storeNameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.contentsTitle
        label.textColor = .customBlack
        return label
    }()
    
    private let storeLocationAddressLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.contentsDefault
        label.textColor = .customBlack
        return label
    }()
    
    private lazy var copyAddressButton: UIButton = {
        let button = UIButton()
        button.setTitle("주소복사", for: .normal)
        button.setTitleColor(.brandPink, for: .normal)
        button.titleLabel?.font = UIFont.contentsDefaultAccent
        return button
    }()
    
    private let starImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.starWithRound
        imageView.tintColor = .brandPink
        return imageView
    }()
    
    private let starLabel: UILabel = {
        let label = UILabel()
        label.text = "0.0 (0명)"
        label.font = UIFont.contentsAccent
        return label
    }()
    
    private let heartImage: UIImageView = { // size 20정도
        let imageView = UIImageView()
        imageView.image = ImageLiterals.heartWithRound
        imageView.tintColor = .brandPink
        return imageView
    }()
    
    private let heartLabel: UILabel = {
        let label = UILabel()
        label.text = "30"
        label.font = UIFont.contentsAccent
        return label
    }()
    
    private let distanceImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.locationWithRound
        imageView.tintColor = .brandPink
        return imageView
    }()
    
    private let distanceLabel: UILabel = {
        let label = UILabel()
        label.text = "-1m"
        label.font = UIFont.contentsAccent
        return label
    }()
    
    private lazy var starStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [starImage, starLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.alignment = .fill
        return stackView
    }()
    
    private lazy var distanceStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [distanceImage, distanceLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.alignment = .fill
        return stackView
    }()

    private lazy var heartStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [heartImage, heartLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.alignment = .fill
        return stackView
    }()
    
    private lazy var underStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [distanceStack, starStack, heartStack])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.alignment = .center
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureAddsubviews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - fucntion
    
    private func setContents(store: FourcutStore?) {
        guard let store = store else { return }
        storeNameLabel.text = store.placeName
        storeLocationAddressLabel.text = store.addressName
        distanceLabel.text = store.stringDistanceWithKm
    }
    
    // MARK: - configure
    
    private func configureUI() {
        backgroundColor = .white
        layer.cornerRadius = 20
        layer.applyShadow(x: 0, y: 5, blur: 15)
    }
    
    private func configureAddsubviews() {
        self.addSubviews(
            storeNameLabel,
            storeLocationAddressLabel,
            copyAddressButton,
            underStack
        )
    }
    
    private func configureConstraints() {
        
        storeLocationAddressLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        copyAddressButton.snp.makeConstraints {
            $0.leading.equalTo(storeLocationAddressLabel.snp.trailing).offset(16)
            $0.centerY.equalTo(storeLocationAddressLabel.snp.centerY)
        }
        
        storeNameLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(storeLocationAddressLabel.snp.top).offset(-20)
        }
        
        underStack.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(storeLocationAddressLabel.snp.bottom).offset(20)
        }
    }
}
