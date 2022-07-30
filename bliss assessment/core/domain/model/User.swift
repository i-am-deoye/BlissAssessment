//
//  User.swift
//  bliss assessment
//
//  Created by Moses on 29/07/2022.
//

import Foundation


public struct User {
    public let id: String
    public let username: String
    public let avatarUrl: String
    
    public init(id: String, username: String, avatarUrl: String) {
        self.id = id
        self.username = username
        self.avatarUrl = avatarUrl
    }
}
