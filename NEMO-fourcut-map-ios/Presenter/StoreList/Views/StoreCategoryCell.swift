//
//  StoreCategoryCell.swift
//  NEMO-fourcut-map-ios
//
//  Created by sanghyo on 2022/10/14.
//

import UIKit

final class StoreCategoryCell: UICollectionViewCell {
    static let registerId = "StoreCategoryCell"
    static let cellHeight: CGFloat = 44
    
    override var isSelected: Bool {
        didSet {
            setSelected()
        }
    }
    
    private let container: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.backgroundColor = .clear
        return view
    }()
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.contentsDefault
        label.textColor = .customBlack
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAddsubviews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - function
    
    private func setSelected() {
        DispatchQueue.main.async {
            self.container.backgroundColor = self.isSelected ? .brandPink : .clear
            self.categoryLabel.textColor = self.isSelected ? .white : .customBlack
        }
    }
    
    func getProperCellWidth(cellHeight: CGFloat, text: String) -> CGSize {
        categoryLabel.text = text
        
        let targetSize = CGSize(width: UIView.layoutFittingCompressedSize.width, height: cellHeight)
        let targetWidth = contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .fittingSizeLevel, verticalFittingPriority: .required).width
        
        return .init(width: targetWidth, height: cellHeight)
    }
    
    func setLabel(with labelName: String) {
        categoryLabel.text = labelName
    }
    
    // MARK: - configure
    
    private func configureAddsubviews() {
        contentView.addSubviews(
            container,
            categoryLabel
        )
    }
    
    private func configureConstraints() {
        container.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(4)
        }
        
        categoryLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
    }
}
