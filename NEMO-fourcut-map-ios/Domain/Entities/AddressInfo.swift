//
//  AddressInfo.swift
//  NEMO-fourcut-map-ios
//
//  Created by sanghyo on 2022/10/11.
//

import Foundation

struct DetailAddressInfo: Decodable {
    let addressName: String
    
    enum CodingKeys: String, CodingKey {
        case addressName = "address_name"
    }
}

struct AddressInfo: Decodable {
    let detailAddressInfo: DetailAddressInfo
    
    enum CodingKeys: String, CodingKey {
        case detailAddressInfo = "address"
    }
}

struct Addresses: Decodable {
    let all: [AddressInfo]
    
    enum CodingKeys: String, CodingKey {
        case all = "documents"
    }
}
