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
        button.setTitle("서울특별시 양천구 목동로 212", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setImage(ImageLiterals.downArrow, for: .normal)
        button.tintColor = UIColor.customBlack
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 20
        button.layer.applyShadow(alpha: 0.1, x: 0, y: 5, blur: 15)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        button.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        button.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.systemBackground
        view.addSubview(addressButton)
        addressButton.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.left.right.equalToSuperview().inset(24)
            $0.height.equalTo(44)
        }
    }


}

