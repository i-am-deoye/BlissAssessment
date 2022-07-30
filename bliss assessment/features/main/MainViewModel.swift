//
//  MainViewModel.swift
//  bliss assessment
//
//  Created by Moses on 29/07/2022.
//

import Foundation


protocol IMainViewModel {
    func fetchEmojis(success: @escaping () -> Void, error: @escaping (String) -> Void)
    func getRandomEmoji() -> Emoji?
    func fetchUser(search query: SearchQuery, success: @escaping () -> Void, error: @escaping (String) -> Void)
}


final class MainViewModel: IMainViewModel {
    private let fetchEmojisUsecase: FetchEmojisUseCase
    private let randomEmojiUsecase: GetRandomEmojiUseCase
    private let searchUserUseCase: SearchUserUseCase
    
    
    init(fetchEmojisUsecase: FetchEmojisUseCase,
         randomEmojiUsecase: GetRandomEmojiUseCase,
         searchUserUseCase: SearchUserUseCase) {
        self.fetchEmojisUsecase = fetchEmojisUsecase
        self.randomEmojiUsecase = randomEmojiUsecase
        self.searchUserUseCase = searchUserUseCase
    }
    
    func fetchEmojis(success: @escaping () -> Void, error: @escaping (String) -> Void) {
        self.fetchEmojisUsecase.execute(success: success, error: error)
    }
    
    func getRandomEmoji() -> Emoji? {
        return self.randomEmojiUsecase.execute()
    }
    
    func fetchUser(search query: SearchQuery, success: @escaping () -> Void, error: @escaping (String) -> Void) {
        self.searchUserUseCase.execute(search: query, success: success, error: error)
    }
    
    
}
