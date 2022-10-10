//
//  GetLocationsUseCase.swift
//  NEMO-fourcut-map-ios
//
//  Created by sanghyo on 2022/10/10.
//

import Foundation

final class GetLocationsUseCase {
    private let locationRepository: LocationRepository
    
    init(locationRepository: LocationRepository) {
        self.locationRepository = locationRepository
    }
}
