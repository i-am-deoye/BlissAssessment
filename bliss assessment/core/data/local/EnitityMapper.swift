//
//  CoreDataDriver+Mapper.swift
//  bliss assessment
//
//  Created by Moses on 30/07/2022.
//

import Foundation



struct EntityMapper {
    static func emojij(_ item: EmojiEntity) -> Emoji? {
        return Emoji.init(id: item.id, icon: item.icon)
    }
    
    static func emojis(_ items: [EmojiEntity]) -> [Emoji] {
        return items.compactMap(emojij(_:))
    }
    
    static func user(_ item: UserEntity) -> User {
        return User.init(id: item.id, username: item.username, avatarUrl: item.avatarUrl)
    }
    
    static func users(_ items: [UserEntity]) -> [User] {
        return items.compactMap(user(_:))
    }
    
    
    static func repos(_ items: [RepoEntity]) -> [Repo] {
        let repos = items.compactMap({ Repo.init(id: $0.id, fullname: $0.fullname, isPrivate: $0.isPrivate) })
        return repos
    }

}
