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
    private var selectedCategoryIdx = 0
    private let categoryNameList: [String] = ["전체"] + FourcutBrand.allCases.map { $0.rawKoreanString }
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.text = ""
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
        layout.sectionInset = UIEdgeInsets(top: 0, left: Size.sidePadding, bottom: 0, right: Size.sidePadding)
        collectionView.register(StoreCategoryCell.self, forCellWithReuseIdentifier: StoreCategoryCell.registerId)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    private let divideLine: UIView = {
        let view = UIView()
        view.backgroundColor = .customGray
        return view
    }()
    private lazy var distanceSortButton: UIButton = {
        let button = UIButton()
        button.setTitle("거리순", for: .normal)
        button.setTitleColor(.customBlack, for: .normal)
        button.setTitleColor(.white, for: .selected)
        button.titleLabel?.font = UIFont.contentsDefault
        button.backgroundColor = .clear
        button.layer.cornerRadius = 15
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        button.addTarget(self, action: #selector(tapSortButton(_:)), for: .touchUpInside)
        return button
    }()
    private lazy var rankingSortButton: UIButton = {
        let button = UIButton()
        button.setTitle("별점순", for: .normal)
        button.setTitleColor(.customBlack, for: .normal)
        button.setTitleColor(.white, for: .selected)
        button.titleLabel?.font = UIFont.contentsDefault
        button.backgroundColor = .clear
        button.layer.cornerRadius = 15
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        button.addTarget(self, action: #selector(tapSortButton(_:)), for: .touchUpInside)
        return button
    }()
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [distanceSortButton,
                                                       rankingSortButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        stackView.alignment = .center
        return stackView
    }()
    private lazy var turnToMapButton: UIButton = {
        var button = UIButton()
        button.setTitle("지도 보기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.contentsDefault
        button = button.setButtonProperty(
                                    backgroundColor: UIColor.customBlack,
                                   radius: 20,
                                   top: 8, left: 16, bottom: 8, right: 16)
        button.addTarget(self, action: #selector(turnToMap), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureAddsubview()
        configureConstraints()
        configureDelegate()
    }
    
    // MARK: - function
    
    func bindingData(addressName: String, stores: [FourcutStore]) {
        addressLabel.text = addressName
        storeList = stores
    }
    
    private func changeButtonUIState(button: UIButton, bgColor: UIColor?, selected: Bool) {
        button.isSelected = selected
        button.backgroundColor = bgColor
    }
    
    // MARK: - @objc func
    
    @objc private func turnToMap() {
        self.dismiss(animated: true)
    }
    
    @objc private func tapSortButton(_ sender: UIButton) {
        for button in [distanceSortButton, rankingSortButton] {
            if button == sender {
                changeButtonUIState(button: button, bgColor: .brandPink, selected: true)
            } else {
                changeButtonUIState(button: button, bgColor: .clear, selected: false)
            }
        }
    }
    
    // MARK: - configure
    
    private func configureDelegate() {
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
    }
    
    private func configureUI() {
        view.backgroundColor = .background
        changeButtonUIState(button: distanceSortButton,
                            bgColor: .brandPink,
                            selected: true)
    }
    
    private func configureAddsubview() {
        view.addSubviews(
            titleStack,
            categoryCollectionView,
            divideLine,
            buttonStackView,
            turnToMapButton
        )
    }

    private func configureConstraints() {
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        
        titleStack.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Size.sidePadding)
            $0.top.equalTo(safeAreaLayoutGuide).offset(30)
        }
        
        categoryCollectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(titleStack.snp.bottom).offset(16)
            $0.height.equalTo(50)
        }
        
        divideLine.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(categoryCollectionView.snp.bottom).offset(8)
            $0.height.equalTo(2)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(divideLine.snp.bottom).offset(28)
            $0.trailing.equalToSuperview().inset(Size.sidePadding)
        }
        
        turnToMapButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-16)
            $0.width.equalTo(90)
            $0.height.equalTo(40)
            $0.centerX.equalToSuperview()
        }
    }
}

// MARK: - Datasource, Delegate

extension StoreListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoreCategoryCell.registerId, for: indexPath) as? StoreCategoryCell else { return StoreCategoryCell() }
        cell.setLabel(with: categoryNameList[indexPath.row])
        if indexPath.row == 0 {
            cell.isSelected = true
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .init())
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryNameList.count
    }
}

extension StoreListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoreCategoryCell.registerId, for: indexPath) as? StoreCategoryCell else { return .zero }
        let text = categoryNameList[indexPath.row]
        return cell.getProperCellWidth(cellHeight: StoreCategoryCell.cellHeight, text: text)
    }
}
