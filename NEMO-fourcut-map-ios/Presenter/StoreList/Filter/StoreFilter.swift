//
//  StoreFilter.swift
//  NEMO-fourcut-map-ios
//
//  Created by sanghyo on 2022/10/16.
//

import Foundation

protocol StoreFilter {
    var filterName: String { get }
    
    func filterStore(_ stores: [FourcutStore]) -> [FourcutStore]
}
