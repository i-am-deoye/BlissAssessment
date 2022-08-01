//
//  MainPage+RandomEmoji.swift
//  bliss assessment
//
//  Created by Moses on 30/07/2022.
//

import UIKit


extension MainPage {
    
    @objc func showRandomEmoji() {
        if let emoji = viewmodel.getRandomEmoji() {
            randomImageView.set(emoji.icon)
        }
    }

}
