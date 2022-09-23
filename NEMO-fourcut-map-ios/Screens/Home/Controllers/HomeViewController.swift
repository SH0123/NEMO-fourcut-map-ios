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
                                   radius: 20,
                                   top: 8, left: 16, bottom: 8, right: 16)
        button.isHidden = false
        return button
    }()
    private lazy var turnToListButton: UIButton = {
        var button = UIButton()
        button.setTitle("목록 보기", for: .normal)
        button.setTitleColor(UIColor.customBlack, for: .normal)
        button.titleLabel?.font = UIFont.contentsDefault
        button = button.setButtonProperty(
                                    backgroundColor: UIColor.white,
                                   radius: 10,
                                   top: 8, left: 16, bottom: 8, right: 16)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureAddsubview()
        configureConstraints()
    }
    
    // MARK: - configure
    
    private func configureDelegate() {
        
    }
    
    private func configureAddsubview() {
        view.addSubviews(
            mapView,
            addressButton,
            researchButton,
            turnToListButton
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
    }
}

