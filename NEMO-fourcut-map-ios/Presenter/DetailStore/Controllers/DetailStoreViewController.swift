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
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        label.textAlignment = .center
        label.alpha = 0
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
        configureDelegate()
    }
    
    // MARK: - function
    private func setStoreInfo(_ store: FourcutStore) {
        self.navigationItem.title = store.storeType?.rawKoreanString
        infoCard.store = store
    }
    
    // MARK: - configure
    
    private func configureDelegate() {
        infoCard.delegate = self
    }
    
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
        
        copyToastMessage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(infoCard.snp.bottom).offset(16)
            $0.width.equalTo(200)
            $0.height.equalTo(30)
        }
    }
}


// MARK: - delegate

extension DetailStoreViewController: clickCopyButtonDelegate {
    func copyAddress() {
        UIView.animate(withDuration: 1.0,
                       animations: {
            self.copyToastMessage.alpha = 1
        }) { _ in
            UIView.animate(withDuration: 0.5,
                           animations: {
                self.copyToastMessage.alpha = 0
            })
            
        }
    }
}
