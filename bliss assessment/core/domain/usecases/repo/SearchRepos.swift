//
//  SearchRepos.swift
//  bliss assessment
//
//  Created by Moses on 29/07/2022.
//

import Foundation


protocol SearchReposUseCase {
    typealias SearchReposSuccessCompletion = ([Repo]) -> Void
    typealias SearchReposFailureCompletion = (String) -> Void
    
    func execute(search query: SearchQuery,
                 success: @escaping SearchReposSuccessCompletion,
                 error: @escaping SearchReposFailureCompletion)
}

struct Pagination {
    var page = 1
    let size = 10
    var items = [Repo]()
}


final class DefaultSearchReposUseCase: SearchReposUseCase {
    private let repository: ReposRepository
    
    private var successHandler : SearchReposSuccessCompletion?
    private var errorHandler: SearchReposFailureCompletion?
    private var pagination: Pagination
    private var repos = [Repo]()
    private var recentQuery: String?
    
    
    init(_ repository: ReposRepository) {
        self.repository = repository
        self.pagination = Pagination()
    }
    
    func execute(search query: SearchQuery,
                 success: @escaping SearchReposSuccessCompletion,
                 error: @escaping SearchReposFailureCompletion) {
        
        self.successHandler = success
        self.errorHandler = error
        
        
        if !pagination.items.isEmpty, let recent = recentQuery, recent == query {
            self.paginate()
            self.successHandler?(self.repos)
            return
        }
        
        self.recentQuery = query
         
        repository.search(query, page: pagination.page,  result: {[weak self] result in
            guard let self = self else { return }
            self.onExecuted(result)
        })
    }
    
    func resetPagination() {
        self.pagination = Pagination()
    }
    
    private func paginate() {
        var items = pagination.items
        if items.isEmpty {
            return
        }
        
        var nextItems = [Repo]()
        
        let size = pagination.size
        let endIndex = items.count > size ? size : items.count
        for _ in 0..<endIndex {
            nextItems.append(items.removeFirst())
        }
        
        self.repos.append(contentsOf: nextItems)
        self.pagination.items = items
        if items.isEmpty {
            pagination.page += 1
            return
        }
    }
    
}

private extension DefaultSearchReposUseCase {
    
    func onExecuted(_ result: Result<[Repo], ResponseError>) {
        switch result {
        case let .failure(error):
            self.errorHandler?(error.localizedDescription)
        case let .success(repos):
            self.pagination.items = repos
            self.paginate()
            self.successHandler?(self.repos)
        }
    }
}




