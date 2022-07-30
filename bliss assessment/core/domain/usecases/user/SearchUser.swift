//
//  SearchUser.swift
//  bliss assessment
//
//  Created by Moses on 29/07/2022.
//

import Foundation



protocol SearchUserUseCase {
    typealias SearchUserSuccessCompletion = () -> Void
    typealias SearchUserFailureCompletion = (String) -> Void
    
    func execute(search query: SearchQuery,
                 success: @escaping SearchUserSuccessCompletion,
                 error: @escaping SearchUserFailureCompletion)
}



final class DefaultSearchUserUseCase: SearchUserUseCase {
    private let repository: UsersRepository
    
    private var successHandler : SearchUserSuccessCompletion?
    private var errorHandler: SearchUserFailureCompletion?
    
    init(_ repository: UsersRepository) {
        self.repository = repository
    }
    
    func execute(search query: SearchQuery,
                 success: @escaping SearchUserSuccessCompletion,
                 error: @escaping SearchUserFailureCompletion) {
        
        self.successHandler = success
        self.errorHandler = error
        
        let searchedUser: User? = repository.search(query)
        if searchedUser != nil {
            successHandler?()
            return
        }
        
        repository.search(query, result: {[weak self] result in
            guard let self = self else { return }
            self.onExecuted(result)
        })
    }
}


private extension DefaultSearchUserUseCase {
    
    func onExecuted(_ result: Result<Void, ResponseError>) {
        switch result {
        case let .failure(error):
            self.errorHandler?(error.localDescription)
        case .success(_):
            self.successHandler?()
        }
    }
}
