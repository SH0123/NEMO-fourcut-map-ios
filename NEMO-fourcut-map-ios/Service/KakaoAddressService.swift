//
//  KakaoAddressService.swift
//  NEMO-fourcut-map-ios
//
//  Created by sanghyo on 2022/10/12.
//

import Foundation

protocol AddressService {
    /// 현재 위치의 lat, lng을 바탕으로 도로명 주소와 지번 주소를 받아오는 함수
    /// Parameter longtitude :주소를 받아올 현재 경도
    ///         latitude: 주소를 받아올 현재 위도
    ///         completionHandler: 비동기 작업 이후 실행할 함수
    func requestAddress(longtitude x: Double, latitude y: Double, _ completionHandler: @escaping (DetailAddressInfo, Error?) -> Void)
}

final class KakaoAddressService: AddressService {
    static let shared = KakaoAddressService()

    func requestAddress(longtitude x: Double, latitude y: Double, _ completionHandler: @escaping (DetailAddressInfo, Error?) -> Void) {
        KakaoMapAPI.address(x: x, y: y).decodable(decodableType: Addresses.self) { value, error in
            guard !value.all.isEmpty else { return }
            let address = value.all[0]
            completionHandler(address.detailAddressInfo, error)
        }
    }
}
