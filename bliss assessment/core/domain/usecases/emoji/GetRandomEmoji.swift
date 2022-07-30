//
//  GetRandomEmoji.swift
//  bliss assessment
//
//  Created by Moses on 29/07/2022.
//

import Foundation


protocol GetRandomEmojiUseCase {
    func execute() -> Emoji?
}


final class DefaultGetRandomEmojiUseCase: GetRandomEmojiUseCase {
    private let repository: EmojisRepository
    private var emojies = [Emoji]()
    
    init(_ repository: EmojisRepository) {
        self.repository = repository
    }
    
    
    func execute() -> Emoji? {
        if emojies.isEmpty {
            self.emojies = repository.list()
        }
        
        if self.emojies.isEmpty { return nil }
        let count = self.emojies.count
        let index = Int.random(in: 0..<count)
        return self.emojies[index]
    }
}
