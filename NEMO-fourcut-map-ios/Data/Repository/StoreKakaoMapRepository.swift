//
//  StoreKakaoMapRepository.swift
//  NEMO-fourcut-map-ios
//
//  Created by sanghyo on 2022/10/04.
//

import Foundation
import Alamofire

final class StoreKakaoMapRepository: StoreRepository {
    
    static let shared = StoreKakaoMapRepository()
    private let locationManager = LocationManager.shared
    private var stores: [FourcutStore] = []
    private var error: Error?
    
    private init() {}
    
    func getAllStores(longtitude x: Double, latitude y: Double, _ completionHandler: @escaping ([FourcutStore] , Error?) -> Void) {
        clearStoreList()
        let fetchingGroup = DispatchGroup()
        for store in FourcutBrand.allCases {
            getEachStore(dispatchGroup: fetchingGroup,
                         store: store,
                         longtitude: x,
                         latitude: y)
        }
        
        fetchingGroup.notify(queue: .global()) { [weak self] in
            guard let self = self else { return }
            completionHandler(self.stores, self.error)
        }
    }
    
    private func clearStoreList() { stores = [] }
    
    private func getEachStore(dispatchGroup: DispatchGroup, store: FourcutBrand, longtitude x: Double, latitude y: Double) {
        dispatchGroup.enter()
        
        locationManager.settingLocationManager()
        guard let currentLocation = locationManager.getCurrentLocation() else { return }
        
        let headers: HTTPHeaders = [
            "Authorization": "KakaoAK 7c09c34ede09a5c5ea55da86506a63bb"
        ]
        let radius = 2000
        let parameters: [String: Any] = [
                    "query": store.rawKoreanString,
                    "page": 1,
                    "size": 15,
                    "x": String(x),
                    "y": String(y),
                    "radius": radius
                ]
        AF.request("https://dapi.kakao.com/v2/local/search/keyword.json", method: .get,
                   parameters: parameters, headers: headers)
        .validate(statusCode: 200..<300)
        .responseDecodable(of: Stores.self) { [weak self] response in
            guard let self = self else { return }
            guard let locationInfoes = response.value?.all else { return }
            let stores = locationInfoes.compactMap {
                return FourcutStore(from: $0, by: currentLocation)
            }
            self.stores += stores
            self.error = response.error
            dispatchGroup.leave()
        }
    }
}
