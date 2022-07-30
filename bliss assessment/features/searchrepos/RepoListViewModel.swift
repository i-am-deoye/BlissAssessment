//
//  RepoListViewModel.swift
//  bliss assessment
//
//  Created by Moses on 29/07/2022.
//

import Foundation


protocol ISearchRepoViewModel {
    func search(query: SearchQuery, success: @escaping ([Repo]) -> Void, error: @escaping (String) -> Void )
}


final class SearchRepoViewModel: ISearchRepoViewModel {
    private let searchReposUsecase: SearchReposUseCase
    
    init(searchReposUsecase: SearchReposUseCase) {
        self.searchReposUsecase = searchReposUsecase
    }
    
    func search(query: SearchQuery, success: @escaping ([Repo]) -> Void, error: @escaping (String) -> Void) {
        return searchReposUsecase.execute(search: query, success: success, error: error)
    }
}
