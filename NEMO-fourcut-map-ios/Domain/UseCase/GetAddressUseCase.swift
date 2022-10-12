//
//  GetAddressUseCase.swift
//  NEMO-fourcut-map-ios
//
//  Created by sanghyo on 2022/10/12.
//

import Foundation

final class GetAddressUseCase {
    private let addressService: AddressService
    
    init(addressService: AddressService = KakaoAddressService.shared) {
        self.addressService = addressService
    }
    
    func getAddress(longtitude x: Double, latitude y: Double, _ completionHandler: @escaping (DetailAddressInfo, Error?) -> Void) {
        addressService.requestAddress(longtitude: x, latitude: y) { info, error in
            completionHandler(info, error)
        }
    }
}
