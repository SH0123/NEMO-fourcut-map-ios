//
//  StoreListViewController.swift
//  NEMO-fourcut-map-ios
//
//  Created by sanghyo on 2022/10/14.
//

import UIKit
import SnapKit

class StoreListViewController: UIViewController {
    enum Size {
        static let sidePadding: CGFloat = 24
    }
    
    private var storeList: [FourcutStore] = []
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.text = "dkdkdk"
        label.font = UIFont.contentsDefaultAccent
        label.textColor = .darkGray
        return label
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "우리의 추억은 여기서 네컷으로 남기는거야"
        label.font = UIFont.contentsTitle
        label.textColor = .customBlack
        return label
    }()
    private lazy var titleStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [addressLabel,
                                                      titleLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        return stackView
    }()
    private let categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        
        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureAddsubview()
        configureConstraints()
    }
    
    // MARK: - function
    
    func bindingData(addressName: String, stores: [FourcutStore]) {
        addressLabel.text = addressName
        storeList = stores
    }
    
    // MARK: - configure
    
    private func configureUI() {
        view.backgroundColor = .background
    }
    
    private func configureAddsubview() {
        view.addSubviews(
            titleStack
        )
    }

    private func configureConstraints() {
        titleStack.snp.makeConstraints {
            let safeAreaLayoutGuide = view.safeAreaLayoutGuide
            $0.leading.trailing.equalToSuperview().inset(Size.sidePadding)
            $0.top.equalTo(safeAreaLayoutGuide).offset(30)
            $0.height.equalTo(40)
        }
    }
}
