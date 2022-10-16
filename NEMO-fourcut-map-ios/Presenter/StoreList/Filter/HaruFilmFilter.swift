//
//  HaruFilmFilter.swift
//  NEMO-fourcut-map-ios
//
//  Created by sanghyo on 2022/10/16.
//

import Foundation

struct HaruFilmFilter: StoreFilter {
    var filterName: String = FourcutBrand.haruFilm.rawKoreanString
    
    func filterStore(_ stores: [FourcutStore]) -> [FourcutStore] {
        return stores.filter {
            $0.storeType == .haruFilm
        }
    }
}
