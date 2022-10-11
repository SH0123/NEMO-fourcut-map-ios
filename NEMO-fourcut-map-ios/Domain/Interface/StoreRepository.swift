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
    ///             longtitude: 검색할 위치의 경도
    ///             latitude: 검색할 위치의 위도
    func getAllStores(longtitude x: Double, latitude y: Double, _ completionHandler: @escaping ([FourcutStore] , Error?) -> Void)
}
