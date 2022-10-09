//
//  HomeStoreCell.swift
//  NEMO-fourcut-map-ios
//
//  Created by sanghyo on 2022/09/23.
//

import UIKit
import SnapKit

class HomeStoreCell: UICollectionViewCell {
    static let registerId = "HomeStoreCell"
    static let itemSize: CGSize = CGSize(width: 280, height: 120)
    
    var storeInfo: FourcutStore? {
        didSet {
            setCellContents(with: storeInfo)
        }
    }
    
    private let container: UIView = {
        let container = UIView()
        container.backgroundColor = UIColor.white
        container.layer.cornerRadius = 20
        container.layer.applyShadow()
        return container
    }()
    
    private let brandCharacterView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.lifeNemo
        return imageView
    }()
    
    private let storeNameLabel: UILabel = {
        let label = UILabel()
        label.text = "인생네컷 서울숲노가리마트 일식점"
        label.font = UIFont.contentsAccent
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
        label.font = UIFont.mini
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
        label.text = "0"
        label.font = UIFont.mini
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
        label.font = UIFont.mini
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAddsubview()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - function
    
    private func setCellContents(with store: FourcutStore?) {
        guard let store  = store else { return }
        storeNameLabel.text = store.placeName
        brandCharacterView.image = store.storeType?.brandImage
        distanceLabel.text = over1km(distance: store.distance)
    }
    
    private func over1km(distance: Int) -> String {
        return distance >= 1000 ? "1km+" : "\(distance)m"
    }
    
    // MARK: - configure
    
    private func configureAddsubview() {
        contentView.addSubviews(
            container,
            brandCharacterView,
            storeNameLabel,
            starImage,
            starLabel,
            heartImage,
            heartLabel,
            distanceImage,
            distanceLabel
        )
    }
    
    private func configureConstraints() {
        container.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        brandCharacterView.snp.makeConstraints {
            $0.leading.equalTo(container).offset(16)
            $0.centerY.equalTo(container)
            $0.width.equalTo(27)
            $0.height.equalTo(67)
        }
        
        storeNameLabel.snp.makeConstraints {
            $0.leading.equalTo(brandCharacterView.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(brandCharacterView)
        }
        
        starImage.snp.makeConstraints {
            $0.size.equalTo(16)
            $0.leading.equalTo(storeNameLabel)
            $0.bottom.equalTo(distanceImage.snp.top).offset(-8)
        }
        
        starLabel.snp.makeConstraints {
            $0.leading.equalTo(distanceLabel)
            $0.bottom.equalTo(starImage)
        }
        
        heartImage.snp.makeConstraints {
            $0.size.equalTo(16)
            $0.leading.equalTo(starLabel.snp.trailing).offset(16)
            $0.bottom.equalTo(starImage)
        }
        
        heartLabel.snp.makeConstraints {
            $0.leading.equalTo(heartImage.snp.trailing).offset(4)
            $0.bottom.equalTo(starImage)
        }
        
        distanceImage.snp.makeConstraints {
            $0.size.equalTo(16)
            $0.leading.equalTo(storeNameLabel)
            $0.bottom.equalTo(brandCharacterView)
        }
        
        distanceLabel.snp.makeConstraints {
            $0.leading.equalTo(distanceImage.snp.trailing).offset(4)
            $0.bottom.equalTo(distanceImage)
        }
    }
}
