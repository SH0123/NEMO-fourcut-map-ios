//
//  StoreRepository.swift
//  NEMO-fourcut-map-ios
//
//  Created by sanghyo on 2022/10/03.
//

import Foundation

protocol StoreRepository {
    /// 주변의 네컷 가게를 가져오는 함수
    /// - Parameter completionHandler: 비동기 작업 이후 실행할 함수
    func getAllStore(latitude x: String, longtitude y: String, _ completionHandler: @escaping ([FourcutStore], Error?) -> Void)
}
