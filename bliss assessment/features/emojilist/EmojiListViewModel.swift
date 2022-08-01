//
//  EmojiListViewModel.swift
//  bliss assessment
//
//  Created by Moses on 29/07/2022.
//

import Foundation
import RxSwift

protocol IEmojiListViewModel {
    var emojis: [Emoji] { get set }
    var emojiCount: Int { get }
    
    func getEmoji(by index: Int) -> Emoji?
    func fetchEmojis()
    func deleteEmoji(at index: Int, reload: @escaping () -> Void)
}


final class EmojiListViewModel: IEmojiListViewModel {
    private let listEmojisUsecase: ListEmojisUseCase
    
    var emojis = [Emoji]()
    
    var emojiCount: Int {
        return emojis.count
    }
    
    init(listEmojisUsecase: ListEmojisUseCase) {
        self.listEmojisUsecase = listEmojisUsecase
    }
    
    func fetchEmojis() {
        self.emojis = listEmojisUsecase.execute()
    }
    
    func getEmoji(by index: Int) -> Emoji? {
        if emojis.isEmpty { return nil }
        if index > emojiCount - 1 { return nil }
        return emojis[index]
    }
    
    func deleteEmoji(at index: Int, reload: @escaping () -> Void) {
        if emojis.isEmpty { return }
        if index > emojiCount - 1 { return }
        self.emojis.remove(at: index)
        reload()
    }
}
