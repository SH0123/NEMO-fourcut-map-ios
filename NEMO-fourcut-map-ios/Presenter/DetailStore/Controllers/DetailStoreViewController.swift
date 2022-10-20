//
//  DetailStoreViewController.swift
//  NEMO-fourcut-map-ios
//
//  Created by sanghyo on 2022/10/18.
//

import Foundation
import UIKit
import NMapsMap
import SnapKit

final class DetailStoreViewController: UIViewController {
    
    var store: FourcutStore? = nil {
        didSet {
            guard let store = store else { return }
            setStoreInfo(store)
        }
    }
    
    private let mapView: NMFMapView = {
        let mapView = NMFMapView()
        mapView.zoomLevel = 14
        mapView.positionMode = .disabled
        return mapView
    }()
    
    private lazy var infoCard = StoreInfoCard()
    
    private let copyToastMessage: UILabel = {
        let label = UILabel()
        label.text = "주소가 복사되었습니다"
        label.font = UIFont.contentsAccent
        label.backgroundColor = .brandPink
        label.textColor = .white
        label.layer.cornerRadius = 10
        return label
    }()
    
    private let storeInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "가게 정보"
        label.font = UIFont.contentsTitle
        label.textColor = .customBlack
        return label
    }()
    
    private let updateInfoLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.mini
        label.textColor = .darkGray
        return label
    }()
    
    private let storeDetailInfoCard = StoreDetailInfoCard()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureAddSubviews()
        configureConstraints()
    }
    
    // MARK: - function
    private func setStoreInfo(_ store: FourcutStore) {
        self.navigationItem.title = store.storeType?.rawKoreanString
        infoCard.store = store
    }
    
    // MARK: - configure
    
    private func configureUI() {
        view.backgroundColor = .background
    }
    
    private func configureAddSubviews() {
        view.addSubviews(
            mapView,
            infoCard,
            copyToastMessage,
            storeInfoLabel,
            updateInfoLabel,
            storeDetailInfoCard
        )
    }
    
    private func configureConstraints() {
        let safeAreaLayout = view.safeAreaLayoutGuide
        
        mapView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(safeAreaLayout)
            $0.height.equalTo(220)
        }
        
        infoCard.snp.makeConstraints {
            $0.top.equalTo(mapView.snp.bottom).offset(-44)
            $0.leading.trailing.equalToSuperview().inset(Size.sidePadding)
            $0.height.equalTo(160)
        }
    }
}
