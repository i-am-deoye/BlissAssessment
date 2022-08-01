//
//  MainViewModel.swift
//  bliss assessment
//
//  Created by Moses on 29/07/2022.
//

import Foundation


protocol IMainViewModel {
    
    var isAvatarSaved: Bool { get }
    
    func fetchEmojis(success: @escaping () -> Void, error: @escaping (String) -> Void)
    func getRandomEmoji() -> Emoji?
    func fetchUser(search query: SearchQuery, success: @escaping () -> Void, error: @escaping (String) -> Void)
}


final class MainViewModel: IMainViewModel {
    private let fetchEmojisUsecase: FetchEmojisUseCase
    private let randomEmojiUsecase: GetRandomEmojiUseCase
    private let searchUserUseCase: SearchUserUseCase
    private let listUsersUseCase : ListUsersUseCase
    
    private var isEmojisAvailable: Bool {
        return getRandomEmoji() != nil
    }
    
    var isAvatarSaved: Bool {
        return !listUsersUseCase.execute().isEmpty
    }
    
    init(fetchEmojisUsecase: FetchEmojisUseCase,
         randomEmojiUsecase: GetRandomEmojiUseCase,
         searchUserUseCase: SearchUserUseCase,
         listUsersUseCase : ListUsersUseCase) {
        self.fetchEmojisUsecase = fetchEmojisUsecase
        self.randomEmojiUsecase = randomEmojiUsecase
        self.searchUserUseCase = searchUserUseCase
        self.listUsersUseCase = listUsersUseCase
    }
    
    func fetchEmojis(success: @escaping () -> Void, error: @escaping (String) -> Void) {
        if isEmojisAvailable {
            success()
            return
        }
        self.fetchEmojisUsecase.execute(success: success, error: error)
    }
    
    func getRandomEmoji() -> Emoji? {
        return self.randomEmojiUsecase.execute()
    }
    
    func fetchUser(search query: SearchQuery, success: @escaping () -> Void, error: @escaping (String) -> Void) {
        self.searchUserUseCase.execute(search: query, success: success, error: error)
    }
    
    
}
