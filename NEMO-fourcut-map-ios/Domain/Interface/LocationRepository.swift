//
//  LocationRepository.swift
//  NEMO-fourcut-map-ios
//
//  Created by sanghyo on 2022/10/10.
//

import Foundation

protocol LocationRepository {
    /// 검색어를 바탕으로 장소 정보를 받아오는 함수
    /// Parameter completionHandler: 비동기 작업 이후 실행할 함수
    func getLocations(keyword: String, _ completionHandler: @escaping ([LocationInfo], Error?) -> Void)
}
