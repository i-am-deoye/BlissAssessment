//
//  HTTPClient+Mapper.swift
//  bliss assessment
//
//  Created by Moses on 29/07/2022.
//

import Foundation


struct RemoteMapper {
    
    static func emojis(_ item: EmojiRemotes) -> [Emoji] {
        
        let list : [Emoji] = item.keys.compactMap({ key in
            let value = item[key]!
            return Emoji.init(id: key, icon: value)
        })
        
        return list
    }
    
    static func emojis(_ item: EmojiRemotes) -> [EmojiEntity] {
        
        let list : [EmojiEntity] = item.keys.compactMap({ key in
            let value = item[key]!
            let entity = EmojiEntity.init()
            entity.id = key
            entity.icon = value
            return entity
        })
        
        return list
    }
    
    
    static func user(_ item: UserRemote) -> UserEntity {
        let entity = UserEntity()
        entity.id = String(item.id)
        entity.username = item.username
        entity.avatarUrl = item.avatarUrl
        return entity
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
