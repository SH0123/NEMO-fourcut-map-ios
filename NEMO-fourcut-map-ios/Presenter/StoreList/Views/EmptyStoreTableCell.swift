//
//  EmptyStoreTableCell.swift
//  NEMO-fourcut-map-ios
//
//  Created by sanghyo on 2022/10/14.
//

import UIKit

class EmptyStoreTableCell: UITableViewCell {
    static let registerId = "EmptyStoreTableCell"
    
    private let emptyStateImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.sadNemo
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let emptyStateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.contentsAccent
        label.textColor = .customMidBlack
        label.text = "주변에 네컷 매장이 없어요"
        return label
    }()
    
    private lazy var emptyStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emptyStateImageView, emptyStateLabel])
        stackView.axis = .vertical
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
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - configure
    
    private func configureAddsubviews() {
        contentView.addSubview(emptyStackView)
    }
    
    private func configureConstraints() {
        emptyStackView.snp.makeConstraints {
            $0.height.equalTo(300)
            $0.center.equalToSuperview()
        }
        
        emptyStateImageView.snp.makeConstraints {
            $0.width.equalTo(100)
        }
    }
}
