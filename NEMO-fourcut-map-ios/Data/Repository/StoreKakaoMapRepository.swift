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
    
    func getAllStore(latitude x: String, longtitude y: String, _ completionHandler: @escaping ([FourcutStore], Error?) -> Void) {
        let fetchingGroup = DispatchGroup()
        fetchingGroup.enter()
        for store in NecutBrand.allCases {
            getEachStore(dispatchGroup: fetchingGroup,
                         storeName: store.rawKoreanString,
                         latitude: x,
                         longtitude: y)
        }
        
        fetchingGroup.notify(queue: .global()) {
            completionHandler(self.stores, self.error)
        }
    }
    
    private func getEachStore(dispatchGroup: DispatchGroup, storeName: String, latitude x: String, longtitude y: String) {
        // TODO: 각각의 가게 정보 불러오기
        let headers: HTTPHeaders = [
            "Authorization": "KakaoAK 7c09c34ede09a5c5ea55da86506a63bb"
        ]
        let parameters: [String: Any] = [
                    "query": storeName,
                    "page": 1,
                    "size": 15,
                    "x": x,
                    "y": y,
                    "radius": 1000
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
