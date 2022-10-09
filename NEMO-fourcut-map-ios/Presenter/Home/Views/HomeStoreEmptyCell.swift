//
//  HomeStoreEmptyCell.swift
//  NEMO-fourcut-map-ios
//
//  Created by sanghyo on 2022/09/23.
//

import UIKit

class HomeStoreEmptyCell: UICollectionViewCell {
    static let registerId = "HomeStoreEmptyCell"
    static let itemSize: CGSize = CGSize(width: 280, height: 120)
    
    private let container: UIView = {
        let container = UIView()
        container.backgroundColor = UIColor.white
        container.layer.cornerRadius = 20
        container.layer.applyShadow()
        return container
    }()
    
    private let emptyCharacterView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.sadNemo
        return imageView
    }()
    
    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "주변에 네컷 매장이 없어요 ㅠ.ㅠ"
        label.font = UIFont.contentsDefaultAccent
        label.textColor = .customMidBlack
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
    
    // MARK: - configure
    private func configureAddsubview() {
        contentView.addSubviews(
            container,
            emptyCharacterView,
            emptyLabel
        )
    }
    
    private func configureConstraints() {
        container.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        emptyCharacterView.snp.makeConstraints {
            $0.leading.equalTo(container).offset(16)
            $0.centerY.equalTo(container)
            $0.width.equalTo(27)
            $0.height.equalTo(67)
        }
        
        emptyLabel.snp.makeConstraints {
            $0.leading.equalTo(emptyCharacterView.snp.trailing).offset(16)
            $0.centerY.equalTo(emptyCharacterView)
        }
    }
}
