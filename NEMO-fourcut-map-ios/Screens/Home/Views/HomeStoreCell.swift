//
//  HomeStoreCell.swift
//  NEMO-fourcut-map-ios
//
//  Created by sanghyo on 2022/09/23.
//

import UIKit

class HomeStoreCell: UICollectionViewCell {
    static let itemSize: CGSize = CGSize(width: 260, height: 100)
    
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
        
    }
    
    private func configureConstraints() {
        
    }
}
