//
//  StoreTableCell.swift
//  NEMO-fourcut-map-ios
//
//  Created by sanghyo on 2022/10/14.
//

import UIKit

class StoreTableCell: UITableViewCell {
    static let registerId = "StoreTableCell"
    static let itemHeight: CGFloat = 130
    
    private let container: UIView = {
        let container = UIView()
        container.backgroundColor = UIColor.white
        container.layer.cornerRadius = 20
        container.layer.applyShadow(x: 0, y: 5, blur: 15)
        return container
    }()

    
    private let storeNameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.contentsAccent
        label.textColor = .customBlack
        return label
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
        label.font = UIFont.contentsDefault
        return label
    }()
    
    private let heartImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.heartWithRound
        imageView.tintColor = .brandPink
        return imageView
    }()
    
    private let heartLabel: UILabel = {
        let label = UILabel()
        label.text = "30"
        label.font = UIFont.contentsDefault
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
        label.font = UIFont.contentsDefault
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

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureAddsubviews()
        configureConstraints()
    }
    
    override func layoutSubviews() {
            super.layoutSubviews()
            contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0))
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - function
    
    func setCellContents(with store: FourcutStore?) {
        guard let store = store else { return }
        storeNameLabel.text = store.placeName
        distanceLabel.text = store.stringDistanceWithKm
    }
    
    // MARK: - configure
    
    private func configureAddsubviews() {
        contentView.addSubviews(
            container,
            storeNameLabel,
            underStack
        )
    }
    
    private func configureConstraints() {
        container.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(1)
        }
        
        storeNameLabel.snp.makeConstraints {
            $0.centerY.equalTo(container.snp.centerY).offset(-20)
            $0.centerX.equalToSuperview()
        }
        
        underStack.snp.makeConstraints {
            $0.centerY.equalTo(container.snp.centerY).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        starImage.snp.makeConstraints {
            $0.size.equalTo(18)
        }
        
        distanceImage.snp.makeConstraints {
            $0.size.equalTo(18)
        }
        
        heartImage.snp.makeConstraints {
            $0.size.equalTo(18)
        }
    }
}
