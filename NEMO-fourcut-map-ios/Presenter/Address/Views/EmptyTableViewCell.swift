//
//  EmptyTableViewCell.swift
//  NEMO-fourcut-map-ios
//
//  Created by sanghyo on 2022/10/09.
//

import UIKit

final class EmptyTableViewCell: UITableViewCell {
    static let registerId = "EmptyTableViewCell"
    
    private let emptyStateImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageLiterals.nonSelectedMarker)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let emptyStateTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "검색 결과가 없어요"
        label.font = UIFont.contentsAccent
        label.textColor = .customMidBlack
        return label
    }()
    
    private let emptyStateSubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "구, 동, 역 등으로 다시 검색해주세요"
        label.font = UIFont.contentsAccent
        label.textColor = .customMidBlack
        return label
    }()
    
    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emptyStateTitleLabel,
                                                      emptyStateSubtitleLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 1
        return stackView
    }()
    
    private lazy var emptyStateStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emptyStateImageView,
                                                       titleStackView])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 20
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .customGray
        configureAddsubview()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - function
    
    // MARK: - configure
    
    private func configureAddsubview() {
        contentView.addSubview(emptyStateStackView)
    }
    
    private func configureConstraints() {
        emptyStateStackView.snp.makeConstraints {
            $0.height.equalTo(300)
            $0.center.equalToSuperview()
        }
    }
}
