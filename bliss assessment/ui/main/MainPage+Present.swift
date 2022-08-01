//
//  MainPage+Navigator.swift
//  bliss assessment
//
//  Created by Moses on 30/07/2022.
//

import UIKit


extension MainPage {
    
    @objc func presentEmojiList() {
        push(EmojiListPage.self, controller: self)
    }
    
    @objc func presentAvatarList() {
        push(AvatarListPage.self, controller: self)
    }
    
    @objc func presentAppleRepos() {
        push(AppleReposPage.self, controller: self)
    }
}
