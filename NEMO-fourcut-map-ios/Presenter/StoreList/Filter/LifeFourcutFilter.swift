//
//  LifeFourcutFilter.swift
//  NEMO-fourcut-map-ios
//
//  Created by sanghyo on 2022/10/16.
//

import Foundation

struct LifeFourcutFilter: StoreFilter {
    var filterName: String = FourcutBrand.lifeFourcut.rawKoreanString
    
    func filterStore(_ stores: [FourcutStore]) -> [FourcutStore] {
        return stores.filter {
            $0.storeType == .lifeFourcut
        }
    }
}
