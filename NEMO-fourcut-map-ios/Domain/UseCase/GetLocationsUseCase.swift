//
//  GetLocationsUseCase.swift
//  NEMO-fourcut-map-ios
//
//  Created by sanghyo on 2022/10/10.
//

import Foundation

final class GetLocationsUseCase {
    private let locationService: LocationService
    
    init(locationService: LocationService = KakaoLocationService.shared) {
        self.locationService = locationService
    }
    
    func getLocations(keyword: String, _ completionHandler: @escaping ([LocationInfo], Error?) -> Void) {
        locationService.requestLocations(keyword: keyword) { locationInfoList, error in
            completionHandler(locationInfoList, error)
        }
    }
}
