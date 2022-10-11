//
//  LocationKakaoMapRepository.swift
//  NEMO-fourcut-map-ios
//
//  Created by sanghyo on 2022/10/10.
//

import Foundation
import Alamofire

final class LocationKakaoMapRepository: LocationRepository {
    static let shared = LocationKakaoMapRepository()
    private var stores: [LocationInfo] = []
    
    private init() { }
    
    func getLocations(keyword: String, _ completionHandler: @escaping ([LocationInfo], Error?) -> Void) {
        clearStores()
        
        let headers: HTTPHeaders = [
            "Authorization": "KakaoAK 7c09c34ede09a5c5ea55da86506a63bb"
        ]
        let parameters: [String: Any] = [
            "query": keyword
        ]
        AF.request("https://dapi.kakao.com/v2/local/search/keyword.json", method: .get,
                   parameters: parameters, headers: headers)
        .validate(statusCode: 200..<300)
        .responseDecodable(of: Locations.self) { [weak self] response in
            guard let self = self else { return }
            guard let locations = response.value?.all else { return }
            self.stores += locations
            completionHandler(self.stores, response.error)
        }
    }
    
    private func clearStores() { stores = [] }
}
