//
//  EndPoints.swift
//  bliss assessment
//
//  Created by Moses on 29/07/2022.
//

import Foundation

public enum EndPoints: String {
    private var baseURL: String { return "https://api.github.com/" }
    
    case emojis = "emojis"
    case users = "users/{username}"
    case repos = "users/{username}/repos?page={page}"
    
    
    public var absoluteString: String {
        return baseURL+self.rawValue
    }
    
    public var url: URL {
        guard let url = URL.init(string: absoluteString) else {
            preconditionFailure("The url used in \(EndPoints.self) is not valid")
        }
        
        return url
    }
}

extension String {
    func param(key: String, with value: String) -> String {
        let value = value.replacingOccurrences(of: " ", with: "%20")
        return self.replacingOccurrences(of: key, with: value)
    }
    
    var url: URL? {
        return URL(string: self)
    }
}
