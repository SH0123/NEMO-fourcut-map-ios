//
//  ViewController.swift
//  NEMO-fourcut-map-ios
//
//  Created by sanghyo on 2022/09/20.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private lazy var addressButton: UIButton = {
        let button = UIButton()
        button.setTitle("주소", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = UIColor.white
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.cornerRadius = 20
        button.layer.shadowOffset = CGSize(width: 0, height: 5)
        button.layer.shadowOpacity = 0.1
        return button
    }()
    
    private let downArrowImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.down")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.systemBackground
        view.addSubview(addressButton)
        view.addSubview(downArrowImage)
        addressButton.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.left.right.equalToSuperview().inset(24)
            $0.height.equalTo(44)
        }
        
        downArrowImage.snp.makeConstraints {
            $0.height.equalTo(15)
            $0.centerY.equalTo(addressButton.snp.centerY)
            $0.trailing.equalTo(addressButton.snp.trailing).offset(-20)
        }
    }


}

