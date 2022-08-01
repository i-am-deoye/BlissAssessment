//
//  MainPage+SearchAvatar.swift
//  bliss assessment
//
//  Created by Moses on 30/07/2022.
//

import UIKit


extension MainPage {
    
    func checkIfAvatarsSaved() {
        userListButton.isEnabled = viewmodel.isAvatarSaved
    }

    @objc func searchAvatar() {
        searchInputBar.resignFirstResponder()
        if let query = searchInputBar.text, !query.isEmpty {
            searchInputBar.text = ""
            searchAvatar(query)
        }
    }
    
    private func searchAvatar(_ query: String) {
        progressView.startAnimating()
        viewmodel.fetchUser(search: query, success: onSearched) { [weak self] message in
            guard let self = self else { return }
            self.progressView.stopAnimating()
            self.onError(message)
        }
    }
    
    private func onSearched() {
        progressView.stopAnimating()
        userListButton.isEnabled = true
    }
}

extension MainPage: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let isTextNotEmpty = !searchText.isEmpty
        self.searchButton.isEnabled = isTextNotEmpty
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchAvatar()
    }
}
