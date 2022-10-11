//
//  LocationInfo.swift
//  NEMO-fourcut-map-ios
//
//  Created by sanghyo on 2022/10/08.
//

import Foundation

struct LocationInfo: Decodable {
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

struct Locations: Decodable {
    let all: [LocationInfo]
    
    enum CodingKeys: String, CodingKey {
        case all = "documents"
    }
}
