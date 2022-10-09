//
//  FourcutStore.swift
//  NEMO-fourcut-map-ios
//
//  Created by sanghyo on 2022/10/04.
//

import Foundation

struct FourcutStore {
    let id: String
    let addressName: String
    let roadAddress: String
    let placeName: String
    let x: Double
    let y: Double
    let storeType: FourcutBrand?
    let distance: Int = -1

    init?(from locationInfo: LocationInfo) {
        guard let x = Double(locationInfo.x), let y = Double(locationInfo.y) else { return nil }
        self.id = locationInfo.id
        self.addressName = locationInfo.addressName
        self.roadAddress = locationInfo.roadAddress
        self.placeName = locationInfo.placeName
        self.x = x
        self.y = y
        self.storeType = FourcutBrand(name: locationInfo.placeName)
    }
}


struct Stores: Decodable {
    let all: [LocationInfo]
    
    enum CodingKeys: String, CodingKey {
        case all = "documents"
    }
}
