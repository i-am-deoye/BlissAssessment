//
//  ListEmojis.swift
//  bliss assessment
//
//  Created by Moses on 29/07/2022.
//

import Foundation


protocol ListEmojisUseCase {
    func execute() -> [Emoji]
}


final class DefaultListEmojisUseCase: ListEmojisUseCase {
    private let repository: EmojisRepository
    
    init(_ repository: EmojisRepository) {
        self.repository = repository
    }
    
    func execute() -> [Emoji] {
        return repository.list()
    }
}
