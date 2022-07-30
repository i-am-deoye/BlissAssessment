//
//  RepoRemote.swift
//  bliss assessment
//
//  Created by Moses on 30/07/2022.
//

import Foundation


struct RepoRemote: Decodable, Equatable {
    let id: Int
    let fullname: String
    let isPrivate: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case fullname = "full_name"
        case isPrivate = "private"
    }
}
