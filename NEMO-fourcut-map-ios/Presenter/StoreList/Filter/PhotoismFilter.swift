//
//  PhotoismFilter.swift
//  NEMO-fourcut-map-ios
//
//  Created by sanghyo on 2022/10/16.
//

import Foundation

struct PhotoismFilter: StoreFilter {
    var filterName: String = FourcutBrand.photoism.rawKoreanString
    
    func filterStore(_ stores: [FourcutStore]) -> [FourcutStore] {
        return stores.filter {
            $0.storeType == .photoism
        }
    }
}
