//
//  GetLocationsUseCase.swift
//  NEMO-fourcut-map-ios
//
//  Created by sanghyo on 2022/10/10.
//

import Foundation

final class GetLocationsUseCase {
    private let locationRepository: LocationRepository
    
    init(locationRepository: LocationRepository = LocationKakaoMapRepository.shared) {
        self.locationRepository = locationRepository
    }
    
    func getLocations(keyword: String, _ completionHandler: @escaping ([LocationInfo], Error?) -> Void) {
        locationRepository.getLocations(keyword: keyword) { locationInfoList, error in
            completionHandler(locationInfoList, error)
        }
    }
}
