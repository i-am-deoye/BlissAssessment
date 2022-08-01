//
//  MainPage+FetchEmojis.swift
//  bliss assessment
//
//  Created by Moses on 30/07/2022.
//

import Foundation


extension MainPage {
    func fetchEmojis() {
        progressView.startAnimating()
        viewmodel.fetchEmojis(success: onFetchedEmojis) { [weak self] message in
            guard let self = self else { return }
            self.progressView.stopAnimating()
            self.onError(message, refresh: self.refresh)
        }
    }
    
    
    private func refresh() {
        self.fetchEmojis()
    }
    
    private func onFetchedEmojis() {
        self.progressView.stopAnimating()
        self.randomEmojiButton.isEnabled = true
        self.emojiListButton.isEnabled = true
    }
}

