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
    private lazy var starStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [starImage, starLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        stackView.alignment = .center
        return stackView
    }()
    
    private let heartImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.heartWithRound
        imageView.tintColor = .brandPink
        return imageView
    }()
    
    private let heartLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
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
    }
    
    // MARK: - configure
    
    private func configureAddsubviews() {
        contentView.addSubviews(
            container,
            storeNameLabel,
            starStack,
            distanceImage,
            distanceLabel,
            heartImage,
            heartLabel
        )
    }
    
    private func configureConstraints() {
        container.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(1)
        }
        
        storeNameLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(8)
        }
        
        starStack.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(8)
        }
        
        starImage.snp.makeConstraints {
            $0.size.equalTo(18)
        }
        
    }
}
