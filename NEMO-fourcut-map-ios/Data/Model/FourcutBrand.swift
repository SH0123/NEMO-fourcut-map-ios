//
//  FourcutBrand.swift
//  NEMO-fourcut-map-ios
//
//  Created by sanghyo on 2022/10/07.
//

import Foundation

enum FourcutBrand: Int, CaseIterable {
    case lifeFourcut
    case haruFilm
    case selpix
    case photoSignature
    case photoism
    
    init?(name: String) {
        switch name {
        case let name where name.contains("인생네컷"):
            self = .lifeFourcut
        case let name where name.contains("하루필름"):
            self = .haruFilm
        case let name where name.contains("셀픽스"):
            self = .selpix
        case let name where name.contains("포토시그니처"):
            self = .photoSignature
        case let name where name.contains("포토이즘"):
            self = .photoism
        default:
            return nil
        }
    }
    
    var rawInt: Int {
        return self.rawValue
    }
    
    var rawKoreanString: String {
        switch self {
        case .lifeFourcut:
            return "인생네컷"
        case .haruFilm:
            return "하루필름"
        case .selpix:
            return "셀픽스"
        case .photoSignature:
            return "포토시그니처"
        case .photoism:
            return "포토이즘"
        }
    }
}
