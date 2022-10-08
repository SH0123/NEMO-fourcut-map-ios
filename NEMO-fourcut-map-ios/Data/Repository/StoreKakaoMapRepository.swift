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
    private var stores: [FourcutStore] = []
    private var error: Error?
    
    private init() {}
    
    func getAllStores(longtitude x: Double, latitude y: Double, _ completionHandler: @escaping ([FourcutStore] , Error?) -> Void) {
        clearStoreList()
        let fetchingGroup = DispatchGroup()
        for store in FourcutBrand.allCases {
            getEachStore(dispatchGroup: fetchingGroup,
                         store: store,
                         longtitude: String(x),
                         latitude: String(y))
        }
        
        fetchingGroup.notify(queue: .global()) { [weak self] in
            guard let self = self else { return }
            completionHandler(self.stores, self.error)
        }
    }
    
    private func clearStoreList() { stores = [] }
    
    private func getEachStore(dispatchGroup: DispatchGroup, store: FourcutBrand, longtitude x: String, latitude y: String) {
        dispatchGroup.enter()
        let headers: HTTPHeaders = [
            "Authorization": "KakaoAK 7c09c34ede09a5c5ea55da86506a63bb"
        ]
        let radius = 1000
        let parameters: [String: Any] = [
                    "query": store.rawKoreanString,
                    "page": 1,
                    "size": 15,
                    "x": x,
                    "y": y,
                    "radius": radius
                ]
        AF.request("https://dapi.kakao.com/v2/local/search/keyword.json", method: .get,
                   parameters: parameters, headers: headers)
        .validate(statusCode: 200..<300)
        .responseDecodable(of: Stores.self) { response in
            guard var fourcutStores = response.value?.all else { return }
            self.stores += fourcutStores
            self.error = response.error
            dispatchGroup.leave()
        }
    }
}
