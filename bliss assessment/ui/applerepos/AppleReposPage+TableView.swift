//
//  AppleReposPage+TableView.swift
//  bliss assessment
//
//  Created by Moses on 30/07/2022.
//

import UIKit



extension AppleReposPage {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewmodel.reposCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let repo = viewmodel.getRepo(by: indexPath.row)
        cell.textLabel?.text = repo?.fullname ?? ""
        return cell
    }
    
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if ((tableView.contentOffset.y + tableView.frame.size.height) >= tableView.contentSize.height) {
            self.fetchAppleRepos()
        }
    }
}
