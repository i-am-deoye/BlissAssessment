//
//  Repository.swift
//  bliss assessment
//
//  Created by Moses on 29/07/2022.
//

import Foundation


typealias SuccessResponse = (data: Data, response: HTTPURLResponse)

extension Int {
    var STATUS_CODE_OK: Bool {
        return self == 200
    }
}


public enum ResponseError: Swift.Error {
    case connectivity
    case invalidData
    case otherCause
    
    public var localDescription: String {
        if self == .invalidData { return "invalid data" }
        if self == .connectivity { return "unable to connect to the server" }
        return "something went wrong, please try again later"
    }
}


protocol IRemoteRepository {
    var client: HTTPClient { get }
}

extension IRemoteRepository {
    func onResponse(_ result: HTTPClient.Result,
                      resultData: @escaping (Data) -> Void,
                      resultError: @escaping (ResponseError) -> Void) {
        switch result {
        case let .success(tupleResult as SuccessResponse):
            if !tupleResult.response.statusCode.STATUS_CODE_OK {
                resultError(.invalidData)
            } else {
                resultData(tupleResult.data)
            }
        case .failure(_):
            resultError(.connectivity)
        }
    }
}
