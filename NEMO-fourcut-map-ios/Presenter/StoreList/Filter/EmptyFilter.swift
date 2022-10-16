//
//  EmptyFilter.swift
//  NEMO-fourcut-map-ios
//
//  Created by sanghyo on 2022/10/16.
//

import Foundation

struct EmptyFilter: StoreFilter {
    var filterName: String = "전체"
    
    func filterStore(_ stores: [FourcutStore]) -> [FourcutStore] {
        return stores
    }
    
    
}
