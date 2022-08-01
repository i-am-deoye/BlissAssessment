//
//  AppleReposPage+Fetch.swift
//  bliss assessment
//
//  Created by Moses on 30/07/2022.
//

import Foundation


extension AppleReposPage {
    func fetchAppleRepos() {
        progressView.startAnimating()
        viewmodel.search(query: "apple", success: {[weak self] in
            guard let self = self else { return }
            self.onFetched()
        }) {[weak self] message in
            guard let self = self else { return }
            self.progressView.stopAnimating()
            self.onError(message, refresh: self.refresh)
        }
    }
    
    
    private func refresh() {
        self.fetchAppleRepos()
    }
    
    private func onFetched() {
        self.progressView.stopAnimating()
        self.tableView.reloadData()
    }
}
