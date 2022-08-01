//
//  ReposRepository.swift
//  bliss assessment
//
//  Created by Moses on 29/07/2022.
//

import Foundation


protocol ReposRepository: IRemoteRepository, ILocalRepository {
    typealias ReposResultCompletion = (Result<[Repo], ResponseError>) -> Void
    
    func search(_ query: SearchQuery, page: Int, result completion: @escaping ReposResultCompletion)
    func search(_ query: SearchQuery) -> [Repo]
}


final class DefaultReposRepository: ReposRepository {
    var client: HTTPClient
    var local: IDataBaseDriver
    
    private var searchHandler: ReposResultCompletion?
    
    init(client: HTTPClient, local: IDataBaseDriver) {
        self.client = client
        self.local = local
    }
    
    
    func search(_ query: SearchQuery, page: Int, result completion: @escaping ReposResultCompletion) {
        self.searchHandler = completion
        
        guard let url = EndPoints.repos.absoluteString
            .param(key: "{username}", with: query)
            .param(key: "{page}", with: "\(page)")
            .url else {
                completion(.failure(.otherCause))
                return
            }
        
        client.get(from: url, completion: {[weak self] result in
            guard let self = self else { return }
            self.onSearched(result)
        })
    }
    
    func search(_ query: SearchQuery) -> [Repo] {
        let query = Query().equal(key: "fullname", value: query)
        let entities = local.fetch(RepoEntity.self, query: query).items
        let repos = EntityMapper.repos(entities)
        return repos
    }
    
}


private extension DefaultReposRepository {
    
    func onSearched(_ result: HTTPClient.Result) {
        self.onResponse(result, resultData: { data in
            do {
                let json = try JSONDecoder().decode([RepoRemote].self, from: data)
                let entities : [RepoEntity] = RemoteMapper.repos(json)
                let repos : [Repo] = RemoteMapper.repos(json)
                self.local.save(entities)
                self.searchHandler?(.success(repos))
            } catch {
                self.searchHandler?(.failure(.otherCause))
            }
        }, resultError: { error in
            self.searchHandler?(.failure(error))
        })
    }
}
