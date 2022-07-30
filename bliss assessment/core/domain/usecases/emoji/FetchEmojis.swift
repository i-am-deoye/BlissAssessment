//
//  FetchEmojiUseCase.swift
//  bliss assessment
//
//  Created by Moses on 29/07/2022.
//

import Foundation


protocol FetchEmojisUseCase {
    typealias FetchEmojiSuccessCompletion = () -> Void
    typealias FetchEmojiFailureCompletion = (String) -> Void
    
    func execute(success: @escaping FetchEmojiSuccessCompletion, error: @escaping FetchEmojiFailureCompletion)
}


final class DefaultFetchEmojisUseCase: FetchEmojisUseCase {
    private let repository: EmojisRepository
    
    private var successHandler : FetchEmojiSuccessCompletion?
    private var errorHandler: FetchEmojiFailureCompletion?
    
    init(_ repository: EmojisRepository) {
        self.repository = repository
    }
    
    func execute(success: @escaping FetchEmojiSuccessCompletion, error: @escaping FetchEmojiFailureCompletion) {
        self.successHandler = success
        self.errorHandler = error
        repository.fetch(result: {[weak self] result in
            guard let self = self else { return }
            self.onExecuted(result)
        })
    }
}


private extension DefaultFetchEmojisUseCase {
    
    func onExecuted(_ result: Result<Void, ResponseError>) {
        switch result {
        case let .failure(error):
            self.errorHandler?(error.localDescription)
        case .success(_):
            self.successHandler?()
        }
    }
}
