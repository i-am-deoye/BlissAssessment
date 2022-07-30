//
//  UserRemote.swift
//  bliss assessment
//
//  Created by Moses on 29/07/2022.
//

import Foundation


struct UserRemote: Decodable, Equatable {
    let id: String
    let username: String
    let avatarUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case username = "login"
        case avatarUrl = "avatar_url"
    }
}
