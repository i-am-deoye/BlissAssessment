//
//  AlamofireHTTPClient.swift
//  bliss assessment
//
//  Created by Moses on 29/07/2022.
//

import Foundation
import Alamofire


final class AlamofireHTTPClient : HTTPClient {
    
    
    func get(from url: URL, completion: @escaping (HTTPClient.Result) -> Void) {
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default).response { response in
            switch response.result {
            case let .success(data):
                completion(.success((data!, response.response!)))
            case let .failure(afError):
                completion(.failure(afError.underlyingError!))
            }
        }
    }
}
