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
    
    func getStore(_ completionHandler: @escaping ([FourcutStore], Error?) -> Void) {
        let headers: HTTPHeaders = [
            "Authorization": "KakaoAK 7c09c34ede09a5c5ea55da86506a63bb"
        ]
        let parameters: [String: Any] = [
                    "query": "인생네컷",
                    "page": 1,
                    "size": 15,
                    "x": 126.9895294917,
                    "y": 37.574777452613,
                    "radius": 1000
                ]
        AF.request("https://dapi.kakao.com/v2/local/search/keyword.json", method: .get,
                   parameters: parameters, headers: headers)
        .validate(statusCode: 200..<300)
        .responseDecodable(of: Stores.self) { response in
            guard let fourcutStores = response.value?.all else { return }
            completionHandler(fourcutStores, response.error)
        }
    }
}
