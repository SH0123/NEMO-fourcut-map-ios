//
//  FourcutStore.swift
//  NEMO-fourcut-map-ios
//
//  Created by sanghyo on 2022/10/04.
//

import Foundation



struct FourcutStore: Decodable {
    let id: String
    let addressName: String
    let roadAddress: String
    let placeName: String
    let x: String
    let y: String
    
    enum CodingKeys: String, CodingKey {
        case addressName = "address_name"
        case roadAddress = "road_address_name"
        case placeName = "place_name"
        case id
        case x
        case y
    }
}

extension FourcutStore {
    var storeType: FourcutBrand? {
        FourcutBrand(name: placeName)
    }
}

struct Stores: Decodable {
    let all: [FourcutStore]
    
    enum CodingKeys: String, CodingKey {
        case all = "documents"
    }
}

extension FourcutStore: CustomStringConvertible {
    var description: String {
        return "가게이름: \(placeName) "
    }
}
