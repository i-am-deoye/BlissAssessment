//
//  EmojiListViewModel.swift
//  bliss assessment
//
//  Created by Moses on 29/07/2022.
//

import Foundation

protocol IEmojiListViewModel {
    func fetchEmojis() -> [Emoji]
}


final class EmojiListViewModel: IEmojiListViewModel {
    private let listEmojisUsecase: ListEmojisUseCase
    
    init(listEmojisUsecase: ListEmojisUseCase) {
        self.listEmojisUsecase = listEmojisUsecase
    }
    
    func fetchEmojis() -> [Emoji] {
        return listEmojisUsecase.execute()
    }
}
