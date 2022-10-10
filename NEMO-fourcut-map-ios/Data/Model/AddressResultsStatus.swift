//
//  AddressResultsStatus.swift
//  NEMO-fourcut-map-ios
//
//  Created by sanghyo on 2022/10/10.
//

import Foundation

enum AddressResultsStatus {
    case notDetermined
    case empty
    case notEmpty
    
    init(results: [LocationInfo]?) {
        switch results?.isEmpty {
        case nil:
            self = .notDetermined
        case true:
            self = .empty
        default:
            self = .notEmpty
        }
    }
}
