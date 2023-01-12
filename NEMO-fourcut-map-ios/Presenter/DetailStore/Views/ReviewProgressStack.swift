//
//  ReviewProgressStack.swift
//  NEMO-fourcut-map-ios
//
//  Created by sanghyo on 2023/01/12.
//

import UIKit

final class ReviewProgressStack: UIStackView {

    private let feelingLabel = UILabel()
    private let progressView = UIProgressView(progressViewStyle: .default)
    private let percentageLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(_ category: String? = nil,
                     feelingLabel: String,
                     textColor: UIColor?,
                     textFont: UIFont?,
                     tintColor: UIColor?,
                     trackColor: UIColor?,
                     scale: CGFloat = 1,
                     percentage: Float) {
        self.init(frame: .zero)
        setPaddingLabel(category: category)
        addSubview()
        setUpUI()
        setFeelingLabel(text: feelingLabel,
                        textColor: textColor,
                        textFont: textFont)
        setProgressView(tintColor: tintColor,
                        trackColor: trackColor,
                        percentage: percentage,
                        scale: scale)
        setPercentageLabel(text: percentage,
                        textColor: textColor,
                        textFont: textFont)
    }

}

private extension ReviewProgressStack {
    
    func addSubview() {
        addArrangedSubview(feelingLabel)
        addArrangedSubview(progressView)
        addArrangedSubview(percentageLabel)
    }
    
    func setUpUI() {
        axis = .horizontal
        spacing = 10
        distribution = .fill
        alignment = .center
    }
}

private extension ReviewProgressStack {
    
    func setPaddingLabel(category: String?) {
        if let category = category {
            let label = PaddingLabel(inset: .init(top: 8, left: 16, bottom: 8, right: 16))
            label.text = category
            label.font = UIFont.miniSemibold
            label.textColor = .brandPink
            label.layer.cornerRadius = 10
            label.layer.borderWidth = 1
            label.layer.borderColor = UIColor.brandPink?.cgColor
            label.layer.masksToBounds = true
            addArrangedSubview(label)
        }
    }
    
    func setFeelingLabel(text: String, textColor: UIColor?, textFont: UIFont?) {
        feelingLabel.text = text
        feelingLabel.textColor = textColor
        feelingLabel.font = textFont
    }
    
    func setProgressView(tintColor: UIColor?, trackColor: UIColor?, percentage: Float, scale: CGFloat) {
        progressView.tintColor = tintColor
        progressView.trackTintColor = trackColor
        progressView.progress = percentage / 100
        progressView.transform = progressView.transform.scaledBy(x: 1, y: scale)
    }
    
    func setPercentageLabel(text: Float, textColor: UIColor?, textFont: UIFont?) {
        percentageLabel.text = "\(Int(text))%"
        percentageLabel.textColor = textColor
        percentageLabel.font = textFont
    }
}

#if DEBUG
import SwiftUI
struct ReviewProgressStackPreview: PreviewProvider {
    static var previews: some View {
        VStack {
            ReviewProgressStack(feelingLabel: "만족스러워요", textColor: .brandPink, textFont: UIFont.mini, tintColor: .brandPink, trackColor: .darkGray, scale: 1, percentage: 88)
                .toPreview()
                .frame(width: UIScreen.main.bounds.width - 32, height: 25)
            ReviewProgressStack(feelingLabel: "만족스러워요", textColor: .customMidBlack, textFont: UIFont.mini, tintColor: .customMidBlack, trackColor: .darkGray, scale: 1, percentage: 30)
                .toPreview()
                .frame(width: UIScreen.main.bounds.width - 32, height: 25)
            ReviewProgressStack(feelingLabel: "만족스러워요", textColor: .customBlack, textFont: UIFont.miniSemibold, tintColor: .darkGray, trackColor: .darkGray, scale: 0.5, percentage: 30)
                .toPreview()
                .frame(width: UIScreen.main.bounds.width - 32, height: 25)
            ReviewProgressStack("조명", feelingLabel: "만족스러워요", textColor: .customBlack, textFont: UIFont.miniSemibold, tintColor: .brandPink, trackColor: .darkGray, scale: 1, percentage: 30)
                .toPreview()
                .frame(width: UIScreen.main.bounds.width - 32, height: 25)
        }
    }
}
#endif


