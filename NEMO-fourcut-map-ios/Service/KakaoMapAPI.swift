//
//  APICall.swift
//  NEMO-fourcut-map-ios
//
//  Created by sanghyo on 2022/10/11.
//
import Alamofire

protocol APICall {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameters { get }
    var header: HTTPHeaders { get }
}

enum KakaoMapAPI {
    case keyword(keyword: String)
    case address(x: Double, y: Double)
}

extension KakaoMapAPI {
    func decodable<T: Decodable>(decodableType: T.Type, _ completionHandler: @escaping (T, Error?) -> Void) {
        AF.request(baseURL + path, method: method, parameters: parameters, headers: header)
            .validate(statusCode: 200 ..< 300)
            .responseDecodable(of: T.self) { response in
                print(response)
                guard let decodedValue = response.value else { return }
                completionHandler(decodedValue, response.error)
            }
    }
}

extension KakaoMapAPI: APICall {
    var baseURL: String {
        return "https://dapi.kakao.com/v2/local/"
    }
    
    var path: String {
        switch self {
        case .keyword:
            return "search/keyword.json"
        case .address:
            return "geo/coord2address.json"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        return .get
    }
    
    var parameters: Alamofire.Parameters {
        switch self {
        case let .keyword(keyword):
            return [ "query": keyword ]
        case let .address(x, y):
            return [
                "x": String(x),
                "y": String(y)
            ]
        }
    }
    
    var header: Alamofire.HTTPHeaders {
        return ["Authorization": "KakaoAK \(APIKey.apiKey)"]
    }
    
    
}
