//
//  ReviewCard.swift
//  NEMO-fourcut-map-ios
//
//  Created by sanghyo on 2023/01/12.
//

import UIKit

final class ReviewCard: UIView {
    
    private let container = UIView()
    private let divider = UIView()
    private let nameLabel = UILabel()
    private let dateLabel = UILabel()
    private let oneLineReviewLabel = UILabel()
    private let oneLineReview = UILabel()
    private let detailReview = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview()
        setUpConstraints()
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// Basic setup
private extension ReviewCard {
    
    func addSubview() {
        addSubview(container)
        container.addSubviews(divider,
                    nameLabel,
                    dateLabel,
                    oneLineReviewLabel,
                    oneLineReview,
                    detailReview)
    }
    
    func setUpConstraints() {
        setUpContainerConstraints()
        setUpDividerConstraints()
        setUpNameLabel()
        setUpDateLabel()
        setUpOneLineReviewLabel()
        setUpOneLineReview()
        setUpDetailReview()
    }
    
    func setUpUI() {
        setUpContainer()
        setUpDivider()
        setUpNameLabelConstraints()
        setUpDateLabelConstraints()
        setUpOneLineReviewLabelConstraints()
        setUpOneLineReviewConstraints()
        setUpDetailReviewConstraints()
    }
}

// SetUp
private extension ReviewCard {
    
    func setUpContainer() {
        container.backgroundColor = .background
    }
    
    func setUpDivider() {
        divider.layer.borderWidth = 1
        divider.layer.borderColor = UIColor.customGray?.cgColor
    }
    
    func setUpNameLabel() {
        nameLabel.text = "테스트"
        nameLabel.font = UIFont.contentsDefaultAccent
        nameLabel.textColor = .black
    }
    
    func setUpDateLabel() {
        dateLabel.text = "테스트 날짜"
        dateLabel.font = UIFont.mini
        dateLabel.textColor = .darkGray
    }
    
    func setUpOneLineReviewLabel() {
        oneLineReviewLabel.text = "한 줄 후기"
        oneLineReviewLabel.font = UIFont.miniSemibold
        oneLineReviewLabel.textColor = .darkGray
    }
    
    func setUpOneLineReview() {
        oneLineReview.text = "테스트용 글씨입니다. 테스트용 글씨입니다.테스트용 글씨입니다.테스트용 글씨입니다.테스트용 글씨입니다.테스트용 글씨입니다."
        oneLineReview.font = UIFont.miniSemibold
        oneLineReview.textColor = .customBlack
        oneLineReview.lineBreakMode = .byCharWrapping
        oneLineReview.numberOfLines = 0
    }
    
    func setUpDetailReview() {
        detailReview.numberOfLines = 0
        detailReview.lineBreakMode = .byCharWrapping
        detailReview.text = "테스트용 글씨입니다. 테스트용 글씨입니다.테스트용 글씨입니다.테스트용 글씨입니다.테스트용 글씨입니다.테스트용 글씨입니다.테스트용 글씨입니다. 테스트용 글씨입니다.테스트용 글씨입니다.테스트용 글씨입니다.테스트용 글씨입니다.테스트용 글씨입니다.테스트용 글씨입니다. 테스트용 글씨입니다.테스트용 글씨입니다.테스트용 글씨입니다.테스트용 글씨입니다.테스트용 글씨입니다."
        detailReview.font = UIFont.mini
        detailReview.textColor = .customBlack
    }
}

// Constraints
private extension ReviewCard {
    
    func setUpContainerConstraints() {
        container.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setUpDividerConstraints() {
        divider.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.height.equalTo(1)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    func setUpNameLabelConstraints() {
        nameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(divider.snp.bottom).offset(17)
        }
    }
    
    func setUpDateLabelConstraints() {
        dateLabel.snp.makeConstraints {
            $0.centerY.equalTo(nameLabel.snp.centerY)
            $0.trailing.equalToSuperview()
        }
    }
    
    func setUpOneLineReviewLabelConstraints() {
        oneLineReviewLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(21)
            $0.leading.equalToSuperview()
        }
    }
    
    func setUpOneLineReviewConstraints() {
        oneLineReview.snp.makeConstraints {
            $0.top.equalTo(oneLineReviewLabel.snp.top)
            $0.leading.equalTo(oneLineReviewLabel.snp.trailing).offset(9)
            $0.trailing.equalToSuperview()
        }
    }
    
    func setUpDetailReviewConstraints() {
        detailReview.snp.makeConstraints {
            $0.top.equalTo(oneLineReview.snp.bottom).offset(14)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
    }
}

#if DEBUG
import SwiftUI
struct ReviewCardPreview: PreviewProvider {
    static var previews: some View {
        VStack {
            ReviewCard()
                .toPreview()
                .frame(width: UIScreen.main.bounds.width - 32, height: 500)
        }
    }
}
#endif
