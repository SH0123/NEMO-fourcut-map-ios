//
//  StoreKakaoMapRepository.swift
//  NEMO-fourcut-map-ios
//
//  Created by sanghyo on 2022/10/04.
//

import Foundation
import Alamofire

enum NecutBrand: Int, CaseIterable {
    case lifeFourcut
    case haruFilm
    case selpix
    case photoSignature
    case photoism
    
    var rawInt: Int {
        return self.rawValue
    }
    
    var rawKoreanString: String {
        switch self {
        case .lifeFourcut:
            return "인생네컷"
        case .haruFilm:
            return "하루필름"
        case .selpix:
            return "셀픽스"
        case .photoSignature:
            return "포토시그니쳐"
        case .photoism:
            return "포토이즘"
        }
    }
}

final class StoreKakaoMapRepository: StoreRepository {
    
    static let shared = StoreKakaoMapRepository()
    private var stores: [FourcutStore] = []
    private var error: Error?
    
    private init() {}
    
    func getAllStores(longtitude x: Double, latitude y: Double, _ completionHandler: @escaping ([FourcutStore], Error?) -> Void) {
        let fetchingGroup = DispatchGroup()
        for store in NecutBrand.allCases {
            getEachStore(dispatchGroup: fetchingGroup,
                         storeName: store.rawKoreanString,
                         longtitude: String(x),
                         latitude: String(y))
        }
        
        fetchingGroup.notify(queue: .global()) { [weak self] in
            guard let self = self else { return }
            completionHandler(self.stores, self.error)
        }
    }
    
    private func getEachStore(dispatchGroup: DispatchGroup, storeName: String, longtitude x: String, latitude y: String) {
        dispatchGroup.enter()
        let headers: HTTPHeaders = [
            "Authorization": "KakaoAK 7c09c34ede09a5c5ea55da86506a63bb"
        ]
        let radius = 10000
        let parameters: [String: Any] = [
                    "query": storeName,
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
            guard let fourcutStores = response.value?.all else { return }
            self.stores += fourcutStores
            self.error = response.error
            dispatchGroup.leave()
        }
    }
}
