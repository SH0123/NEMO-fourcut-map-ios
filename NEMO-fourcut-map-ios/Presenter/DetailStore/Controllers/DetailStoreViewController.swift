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
    
    private let detailStoreScrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    private let contentView = UIView()
    
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
    
    private let qrInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .customBlack
        label.font = UIFont.contentsDefaultAccent
        label.text = "QR 동영상 방식"
        return label
    }()
    
    private let qrInfoCard: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.customGray?.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    private let qrInfo: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.contentsDefault
        label.text = "아직 등록된 정보가 없습니다"
        label.textColor = .darkGray
        return label
    }()
    
    private let retakeInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .customBlack
        label.font = UIFont.contentsDefaultAccent
        label.text = "재촬영 방식"
        return label
    }()
    
    private let retakeInfoCard: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.customGray?.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    private let retakeInfo: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.contentsDefault
        label.text = "아직 등록된 정보가 없습니다"
        label.textColor = .darkGray
        return label
    }()
    
    private lazy var infoEditButton: UIButton = {
        var button = UIButton()
        button.setTitle("정보 수정하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.contentsDefaultAccent
        button = button.setButtonProperty(backgroundColor: .brandPink, radius: 15, top: 8, left: 16, bottom: 8, right: 16, alpha: 0, x: 0, y: 0, blur: 0)
        return button
    }()
    
    private lazy var reviewWriteButton: UIButton = {
        var button = UIButton()
        button.setTitle("후기 작성하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.contentsDefaultAccent
        button = button.setButtonProperty(backgroundColor: .brandPink, radius: 15, top: 8, left: 16, bottom: 8, right: 16, alpha: 0, x: 0, y: 0, blur: 0)
        return button
    }()
    
    private let reviewLabel: UILabel = {
        let label = UILabel()
        label.text = "후기"
        label.textColor = .customBlack
        label.font = UIFont.contentsTitle
        return label
    }()
    
    private let reviewSummaryContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.customGray?.cgColor
        view.layer.borderWidth = 1
        return view
    }()

    private let reviewSummaryLabel: UILabel = {
        let label = UILabel()
        label.text = "리뷰 요약"
        label.textColor = .customBlack
        label.font = UIFont.contentsAccent
        return label
    }()
    
    private let reviewSummaryStar: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.filledStar
        imageView.tintColor = .brandPink
        return imageView
    }()
    
    private let reviewSummaryRating: UILabel = {
        let label = UILabel()
        label.text = "5.0점"
        label.textColor = .customBlack
        label.font = UIFont.contentsAccent
        return label
    }()
    
    private lazy var reviewSummaryRatingStack: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()
    
    private let reviewFirst: ReviewProgressStack = .init("조명", feelingLabel: "만족스러워요", textColor: .customBlack, textFont: .miniSemibold, tintColor: .brandPink, trackColor: .darkGray)
    
    private let reviewSecond: ReviewProgressStack = .init("보정", feelingLabel: "만족스러워요", textColor: .customBlack, textFont: .miniSemibold, tintColor: .brandPink, trackColor: .darkGray)
    
    private let reviewThird: ReviewProgressStack = .init("청결", feelingLabel: "깔끔,쾌적해요", textColor: .customBlack, textFont: .miniSemibold, tintColor: .brandPink, trackColor: .darkGray)
    
    private lazy var reviewSummaryStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [reviewFirst, reviewSecond, reviewThird])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.alignment = .fill
        return stack
    }()
    
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
        view.addSubview(detailStoreScrollView)
        detailStoreScrollView.addSubview(contentView)
        contentView.addSubviews(
            mapView,
            infoCard,
            copyToastMessage,
            storeInfoLabel,
            updateInfoLabel,
            storeDetailInfoCard,
            qrInfoLabel,
            qrInfoCard,
            retakeInfoLabel,
            retakeInfoCard,
            infoEditButton,
            reviewWriteButton,
            reviewLabel,
            reviewSummaryContainer
        )
        qrInfoCard.addSubviews(qrInfo)
        retakeInfoCard.addSubviews(retakeInfo)
        reviewSummaryContainer.addSubviews(reviewSummaryLabel,
                                            reviewSummaryStack)
    }
    
    private func configureConstraints() {
        
        detailStoreScrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(detailStoreScrollView.snp.width)
            $0.height.greaterThanOrEqualTo(detailStoreScrollView.snp.height).priority(.low)
        }
        
        mapView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(contentView.snp.top)
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
        
        storeInfoLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(Size.sidePadding)
            $0.top.equalTo(copyToastMessage.snp.bottom).offset(16)
        }
        
        updateInfoLabel.snp.makeConstraints {
            $0.centerY.equalTo(storeInfoLabel.snp.centerY)
            $0.leading.equalTo(storeInfoLabel.snp.trailing).offset(8)
        }
        
        storeDetailInfoCard.snp.makeConstraints {
            $0.top.equalTo(storeInfoLabel.snp.bottom).offset(32)
            $0.leading.trailing.equalToSuperview().inset(Size.sidePadding)
        }
        
        qrInfoLabel.snp.makeConstraints {
            $0.leading.equalTo(storeInfoLabel)
            $0.top.equalTo(storeDetailInfoCard.snp.bottom).offset(30)
        }
        
        qrInfoCard.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Size.sidePadding)
            $0.top.equalTo(qrInfoLabel.snp.bottom).offset(8)
        }
        
        qrInfo.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.top.bottom.equalToSuperview().inset(16)
        }
        
        retakeInfoLabel.snp.makeConstraints {
            $0.leading.equalTo(storeInfoLabel.snp.leading)
            $0.top.equalTo(qrInfoCard.snp.bottom).offset(30)
        }
        
        retakeInfoCard.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Size.sidePadding)
            $0.top.equalTo(retakeInfoLabel.snp.bottom).offset(8)
        }
        
        retakeInfo.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.top.bottom.equalToSuperview().inset(16)
        }
        
        infoEditButton.snp.makeConstraints {
            $0.trailing.equalTo(storeDetailInfoCard.snp.trailing)
            $0.centerY.equalTo(storeInfoLabel)
        }
        
        reviewLabel.snp.makeConstraints {
            $0.leading.equalTo(storeInfoLabel.snp.leading)
            $0.top.equalTo(retakeInfoCard.snp.bottom).offset(40)
        }
        
        reviewSummaryContainer.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Size.sidePadding)
            $0.top.equalTo(reviewLabel.snp.bottom).offset(16)
        }
        
        reviewSummaryLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().inset(10)
        }
        
        reviewSummaryStack.snp.makeConstraints {
            $0.top.equalTo(reviewSummaryLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().offset(-60)
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
