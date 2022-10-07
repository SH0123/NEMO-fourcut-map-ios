//
//  GetAllStoresUseCase.swift
//  NEMO-fourcut-map-ios
//
//  Created by sanghyo on 2022/10/06.
//

import Foundation

final class GetAllStoresUseCase {
    private let storeRepository: StoreRepository
    
    init(storeRepository: StoreRepository = StoreKakaoMapRepository.shared) {
        self.storeRepository = storeRepository
    }
    /// 가게들을 모두 받아오는 함수
    /// - Parameters:
    ///     - x: 현재 내 위치 경도
    ///     - y: 현재 내 위치 위도
    ///     - completion: ViewController에서 처리해줄 completionHandler
    func getAllStores(longtitude x: Double, latitude y: Double, _ completionHandler: @escaping ([FourcutStore] , Error?) -> Void) {
        storeRepository.getAllStores(longtitude: x, latitude: y) { results, error in
            completionHandler(results, error)
        }
    }
}
