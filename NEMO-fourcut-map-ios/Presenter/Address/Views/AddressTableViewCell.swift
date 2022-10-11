//
//  AddressTableViewCell.swift
//  NEMO-fourcut-map-ios
//
//  Created by sanghyo on 2022/10/09.
//

import UIKit

final class AddressTableViewCell: UITableViewCell {
    static let registerId = "AddressTableViewCell"
    static let itemHeight: CGFloat = 80
    enum Size {
        static let sidePadding: CGFloat = 24
    }
    
    var locationInfo: LocationInfo? {
        didSet {
            setCellContents(with: locationInfo)
        }
    }
    
    private let storeNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.contentsAccent
        label.textColor = .customBlack
        return label
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.mini
        label.textColor = .customMidBlack
        return label
    }()
    
    private lazy var labelStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [storeNameLabel,
                                                  addressLabel])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fillEqually
        stack.spacing = 3
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureAddsubview()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - function
    
    private func setCellContents(with locationInfo: LocationInfo?) {
        guard let locationInfo = locationInfo else { return }
        storeNameLabel.text = locationInfo.placeName
        addressLabel.text = locationInfo.addressName
    }
    
    // MARK: - configure
    
    private func configureUI() {
        contentView.backgroundColor = .background
    }
    
    private func configureAddsubview() {
        contentView.addSubviews(
            labelStack
        )
    }
    
    private func configureConstraints() {
        labelStack.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Size.sidePadding)
            $0.centerY.equalToSuperview()
        }
    }
}
