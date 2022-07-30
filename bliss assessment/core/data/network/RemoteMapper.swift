//
//  HTTPClient+Mapper.swift
//  bliss assessment
//
//  Created by Moses on 29/07/2022.
//

import Foundation


struct RemoteMapper {
    
    static func emojij(_ item: EmojiRemote) -> Emoji? {
        guard let key = item.keys.first, let value = item.values.first else { return nil }
        return Emoji.init(id: key, icon: value)
    }
    
    static func emojij(_ item: EmojiRemote) -> EmojiEntity? {
        guard let key = item.keys.first, let value = item.values.first else { return nil }
        let entity = EmojiEntity.init()
        entity.id = key
        entity.icon = value
        return entity
    }
    
    static func emojis(_ items: EmojiRemotes) -> [Emoji] {
        return items.compactMap(emojij(_:))
    }
    
    static func emojis(_ items: EmojiRemotes) -> [EmojiEntity] {
        return items.compactMap(emojij(_:))
    }
    
    
    static func user(_ item: UserRemote) -> User {
        return User.init(id: item.id, username: item.username, avatarUrl: item.avatarUrl)
    }
    
    
    static func repos(_ items: [RepoRemote]) -> [Repo] {
        let repos = items.compactMap({ Repo.init(id: String($0.id), fullname: $0.fullname, isPrivate: $0.isPrivate) })
        return repos
    }
    
    static func repos(_ items: [RepoRemote]) -> [RepoEntity] {
        let entities : [RepoEntity] = items.compactMap({ item in
            let entity = RepoEntity.init()
            entity.id = String(item.id)
            entity.fullname = item.fullname
            entity.isPrivate = item.isPrivate
            return entity
        })
        
        return entities
    }
}
