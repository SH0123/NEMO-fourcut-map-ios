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
    let x: String
    let y: String
    let storeType: FourcutBrand?
    
    init(from locationInfo: LocationInfo) {
        id = locationInfo.id
        addressName = locationInfo.addressName
        roadAddress = locationInfo.roadAddress
        placeName = locationInfo.placeName
        x = locationInfo.x
        y = locationInfo.y
        storeType = FourcutBrand(name: locationInfo.placeName)
    }
}


struct Stores: Decodable {
    let all: [LocationInfo]
    
    enum CodingKeys: String, CodingKey {
        case all = "documents"
    }
}
