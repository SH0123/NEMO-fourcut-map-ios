//
//  StoreRepository.swift
//  NEMO-fourcut-map-ios
//
//  Created by sanghyo on 2022/10/03.
//

import Foundation

protocol StoreRepository {
    /// 주변의 네컷 가게를 가져오는 함수
    /// - Parameter
    /// - Returns:내 주변의 네컷 가게
    func getStore() -> Void
}
