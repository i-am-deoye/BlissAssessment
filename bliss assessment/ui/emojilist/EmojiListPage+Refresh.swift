//
//  EmojiListPage+Refresh.swift
//  bliss assessment
//
//  Created by Moses on 30/07/2022.
//

import UIKit



extension EmojiListPage {
    
    @objc func refreshList() {
        refreshControl.beginRefreshing()
        viewmodel.fetchEmojis()
        collectionView.reloadData()
        refreshControl.endRefreshing()
    }
}
