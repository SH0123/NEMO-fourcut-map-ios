//
//  ViewController.swift
//  NEMO-fourcut-map-ios
//
//  Created by sanghyo on 2022/09/20.
//

import UIKit
import CoreLocation
import NMapsMap
import SnapKit

final class HomeViewController: UIViewController {
    enum Size {
        static let contentInset: CGFloat = (UIScreen.main.bounds.width - HomeStoreCell.itemSize.width) / 2
        static let minimumInterItem: CGFloat = 10
    }
    
    private var storeList: [Int] = [1, 2, 3, 4, 5]
    private var currentPageIndex: CGFloat = 0

    private let mapView: UIView = {
        let mapView = NMFMapView()
        mapView.zoomLevel = 15
        return mapView
    }()
    private lazy var addressButton: UIButton = {
        let button = UIButton()
        button.setTitle("서울특별시 양천구 목동로 212", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.contentsAccent
        button.setImage(ImageLiterals.downArrow, for: .normal)
        button.tintColor = UIColor.customBlack
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 20
        button.layer.applyShadow()
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        button.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        button.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        
        return button
    }()
    private lazy var researchButton: UIButton = {
        var button = UIButton()
        button.setTitle("현재 위치 기준으로 다시 찾아보기", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.contentsDefaultAccent
        button = button.setButtonProperty(
                                   backgroundColor: UIColor.brandPink,
                                   radius: 15,
                                   top: 8, left: 16, bottom: 8, right: 16)
        button.isHidden = true
        return button
    }()
    
    private lazy var turnToListButton: UIButton = {
        var button = UIButton()
        button.setTitle("목록 보기", for: .normal)
        button.setTitleColor(UIColor.customBlack, for: .normal)
        button.titleLabel?.font = UIFont.contentsDefault
        button = button.setButtonProperty(
                                    backgroundColor: UIColor.white,
                                   radius: 15,
                                   top: 8, left: 16, bottom: 8, right: 16)
        return button
    }()
    
    private let storeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        collectionView.contentInset = UIEdgeInsets(top: 0, left: Size.contentInset, bottom: 0, right: Size.contentInset)
        collectionView.register(HomeStoreCell.self, forCellWithReuseIdentifier: HomeStoreCell.registerId)
        collectionView.register(HomeStoreEmptyCell.self, forCellWithReuseIdentifier: HomeStoreEmptyCell.registerId)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureAddsubview()
        configureConstraints()
        configureDelegate()
    }
    
    // MARK: - configure
    
    private func configureDelegate() {
        storeCollectionView.dataSource = self
        storeCollectionView.delegate = self
    }
    
    private func configureAddsubview() {
        view.addSubviews(
            mapView,
            addressButton,
            researchButton,
            turnToListButton,
            storeCollectionView
        )
    }
    
    private func configureConstraints() {
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        addressButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            $0.left.right.equalToSuperview().inset(24)
            $0.height.equalTo(44)
        }
        
        researchButton.snp.makeConstraints {
            $0.top.equalTo(addressButton.snp.bottom).offset(8)
            $0.centerX.equalTo(addressButton.snp.centerX)
            $0.height.equalTo(40)
        }
        
        storeCollectionView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(110)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-24)
        }
        
        turnToListButton.snp.makeConstraints {
            $0.bottom.equalTo(storeCollectionView.snp.top).offset(-10)
            $0.height.equalTo(30)
            $0.centerX.equalTo(researchButton)
        }
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = storeList.isEmpty ? 1 : storeList.count
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if storeList.isEmpty {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeStoreEmptyCell.registerId, for: indexPath) as? HomeStoreEmptyCell else { return HomeStoreEmptyCell() }
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeStoreCell.registerId, for: indexPath) as? HomeStoreCell else { return HomeStoreCell() }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Size.minimumInterItem
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return HomeStoreCell.itemSize
    }
}

// MARK: - UIScrollViewDelegate

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageWidthIncludingSpace = HomeStoreCell.itemSize.width + Size.minimumInterItem
        let offset = targetContentOffset.pointee.x
        let index = (offset + Size.contentInset) / pageWidthIncludingSpace
        var roundedIndex = round(index)
        
        if currentPageIndex < roundedIndex {
            currentPageIndex += 1
            roundedIndex = currentPageIndex
        } else if currentPageIndex > roundedIndex {
            currentPageIndex -= 1
            roundedIndex = currentPageIndex
        }
        
        targetContentOffset.pointee = CGPoint(x: roundedIndex * pageWidthIncludingSpace - Size.contentInset, y: 0)
    }
}
