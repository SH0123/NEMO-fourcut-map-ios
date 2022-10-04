//
//  FourcutStore.swift
//  NEMO-fourcut-map-ios
//
//  Created by sanghyo on 2022/10/04.
//

import Foundation

struct FourcutStore: Decodable {
    let addressName: String
    let placeName: String
    
    enum CodingKeys: String, CodingKey {
        case addressName = "address_name"
        case placeName = "place_name"
    }
}

struct Stores: Decodable {
    let all: [FourcutStore]
    
    enum CodingKeys: String, CodingKey {
        case all = "documents"
    }
}
