//
//  KakaoLocationService.swift
//  NEMO-fourcut-map-ios
//
//  Created by sanghyo on 2022/10/11.
//

import Foundation

protocol LocationService {
    /// 검색어를 바탕으로 장소 정보를 받아오는 함수
    /// Parameter completionHandler: 비동기 작업 이후 실행할 함수
    func requestLocations(keyword: String, _ completionHandler: @escaping ([LocationInfo], Error?) -> Void)
}

final class KakaoLocationService: LocationService {
    static let shared = KakaoLocationService()
    private var locationInfoList: [LocationInfo] = []
    
    private init() { }
    
    func requestLocations(keyword: String, _ completionHandler: @escaping ([LocationInfo], Error?) -> Void) {
        clearLocationList()
        
        KakaoMapAPI.keyword(keyword: keyword).decodable(decodableType: Locations.self) { [weak self] value, error in
            guard let self = self else { return }
            self.locationInfoList += value.all
            completionHandler(self.locationInfoList, error)
        }
    }
    
    private func clearLocationList() { locationInfoList = [] }
}
