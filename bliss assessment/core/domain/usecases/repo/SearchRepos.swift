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


final class DefaultSearchReposUseCase: SearchReposUseCase {
    private let repository: ReposRepository
    
    private var successHandler : SearchReposSuccessCompletion?
    private var errorHandler: SearchReposFailureCompletion?
    
    init(_ repository: ReposRepository) {
        self.repository = repository
    }
    
    func execute(search query: SearchQuery,
                 success: @escaping SearchReposSuccessCompletion,
                 error: @escaping SearchReposFailureCompletion) {
        
        self.successHandler = success
        self.errorHandler = error
        
        let searchedList = repository.search(query)
        
        if searchedList.isEmpty {
            repository.search(query, result: {[weak self] result in
                guard let self = self else { return }
                self.onExecuted(result)
            })
        }
    }
}

private extension DefaultSearchReposUseCase {
    
    func onExecuted(_ result: Result<[Repo], ResponseError>) {
        switch result {
        case let .failure(error):
            self.errorHandler?(error.localizedDescription)
        case let .success(repos):
            self.successHandler?(repos)
        }
    }
}




