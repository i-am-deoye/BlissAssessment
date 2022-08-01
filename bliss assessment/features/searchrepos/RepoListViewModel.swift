//
//  RepoListViewModel.swift
//  bliss assessment
//
//  Created by Moses on 29/07/2022.
//

import Foundation


protocol ISearchRepoViewModel {
    var repos: [Repo] { get set }
    var reposCount: Int { get }
    
    func getRepo(by index: Int) -> Repo?
    func search(query: SearchQuery, success: @escaping () -> Void, error: @escaping (String) -> Void )
}




final class SearchRepoViewModel: ISearchRepoViewModel {
    private let searchReposUsecase: SearchReposUseCase
    
    var repos = [Repo]()
    var reposCount: Int {
        return repos.count
    }
    
    init(searchReposUsecase: SearchReposUseCase) {
        self.searchReposUsecase = searchReposUsecase
    }
    
    func getRepo(by index: Int) -> Repo? {
        if repos.isEmpty { return nil }
        if index > reposCount - 1 { return nil }
        return repos[index]
    }
    
    func search(query: SearchQuery, success: @escaping () -> Void, error: @escaping (String) -> Void) {
        return searchReposUsecase.execute(search: query, success: {[weak self] repos in
            guard let self = self else { return }
            self.repos = repos
            success()
        }, error: error)
    }
}
