//
//  FetchEmojis.swift
//  bliss assessment
//
//  Created by Moses on 29/07/2022.
//

import Foundation

protocol EmojisRepository: IRemoteRepository, ILocalRepository {
    typealias EmojisResultCompletion = (Result<Void, ResponseError>) -> Void
    
    func fetch(result completion: @escaping EmojisResultCompletion)
    func list() -> [Emoji]
}


final class DefaultEmojisRepository: EmojisRepository {
    var client: HTTPClient
    var local: IDataBaseDriver
    
    private var fetchHandler: EmojisResultCompletion?
    
    init(client: HTTPClient, local: IDataBaseDriver) {
        self.client = client
        self.local = local
    }
    
    func fetch(result completion: @escaping EmojisResultCompletion) {
        self.fetchHandler = completion
        
        let url = EndPoints.emojis.url
        client.get(from: url, completion: {[weak self] result in
            guard let self = self else { return }
            self.onFetched(result)
        })
    }
    
    func list() -> [Emoji] {
        let entities = local.fetch(EmojiEntity.self).items
        let emojis = EntityMapper.emojis(entities)
        return emojis
    }
}


private extension DefaultEmojisRepository {
    
    func onFetched(_ result: HTTPClient.Result) {
        self.onResponse(result, resultData: { data in
            do {
                let json = try JSONDecoder().decode(EmojiRemotes.self, from: data)
                let entities : [EmojiEntity] = RemoteMapper.emojis(json)
                self.local.save(entities)
                self.fetchHandler?(.success(()))
            } catch {
                self.fetchHandler?(.failure(.otherCause))
            }
        }, resultError: { error in
            self.fetchHandler?(.failure(error))
        })
    }
}
