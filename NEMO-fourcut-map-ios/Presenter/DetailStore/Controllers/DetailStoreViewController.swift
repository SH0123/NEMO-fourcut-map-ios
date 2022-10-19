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
            guard let brandName = store?.storeType?.rawKoreanString else { return }
            setNavigationTitle(brandName)
        }
    }
    
    private let mapView: NMFMapView = {
        let mapView = NMFMapView()
        mapView.zoomLevel = 14
        mapView.positionMode = .disabled
        return mapView
    }()
    
    private let detailCard = StoreInfoCard()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - function
    private func setNavigationTitle(_ brandName: String) {
        self.navigationItem.title = brandName
    }
    
    
    // MARK: - configure
    
    private func configureUI() {
        view.backgroundColor = .background
    }
    
    private func configureAddSubviews() {
        
    }
    
    private func configureConstraints() {
        
    }
}
