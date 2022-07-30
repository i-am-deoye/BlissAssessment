//
//  UserRepo.swift
//  bliss assessment
//
//  Created by Moses on 29/07/2022.
//

import Foundation



protocol UsersRepository: IRemoteRepository, ILocalRepository {
    typealias UsersResultCompletion = (Result<Void, ResponseError>) -> Void
    
    func search(_ query: SearchQuery, result completion: @escaping UsersResultCompletion)
    func search(_ query: SearchQuery) -> [User]
    func search(_ query: SearchQuery) -> User?
}


final class DefaultUsersRepository: UsersRepository {
    var client: HTTPClient
    var local: IDataBaseDriver
    
    private var searchHandler: UsersResultCompletion?
    
    init(client: HTTPClient, local: IDataBaseDriver) {
        self.client = client
        self.local = local
    }
    
    
    func search(_ query: SearchQuery, result completion: @escaping UsersResultCompletion) {
        self.searchHandler = completion
        
        let url = EndPoints.users.url
        client.get(from: url, completion: {[weak self] result in
            guard let self = self else { return }
            self.onSearched(result)
        })
    }
    
    func search(_ query: SearchQuery) -> [User] {
        let query = Query().equal(key: "username", value: query)
        let entities = local.fetch(UserEntity.self, query: query).items
        let users = EntityMapper.users(entities)
        return users
    }
    
    func search(_ query: SearchQuery) -> User? {
        let query = Query().equal(key: "username", value: query)
        let entity = local.fetch(UserEntity.self, query: query).item
        
        guard let entity = entity else {
            return nil
        }

        let user = EntityMapper.user(entity)
        return user
    }
}


private extension DefaultUsersRepository {
    
    func onSearched(_ result: HTTPClient.Result) {
        self.onResponse(result, resultData: { data in
            do {
                let json = try JSONDecoder().decode(UserRemote.self, from: data)
                let entity = RemoteMapper.user(json)
                self.local.save(entity)
                self.searchHandler?(.success(()))
            } catch {
                self.searchHandler?(.failure(.otherCause))
            }
        }, resultError: { error in
            self.searchHandler?(.failure(error))
        })
    }
}
