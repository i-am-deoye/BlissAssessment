//
//  AppleReposPage.swift
//  bliss assessment
//
//  Created by Moses on 30/07/2022.
//

import UIKit
import Swinject


extension AppleReposPage {
    static func register( using container: Container) {
        container.register(AppleReposPage.self) { r in
            let controller = AppleReposPage.init()
            
            let client = AlamofireHTTPClient.init()
            let local = CoreDataDriver.shared
            
            let reposRepository = DefaultReposRepository.init(client: client, local: local)
            
            let searchReposUseCase = DefaultSearchReposUseCase.init(reposRepository)
            controller.viewmodel = SearchRepoViewModel.init(searchReposUsecase: searchReposUseCase)
            return controller
        }
    }
}

final class AppleReposPage: UITableViewController {
    var viewmodel: ISearchRepoViewModel!
    let cellIdentifier = "\(UITableViewCell.self)"
    
    lazy var progressView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchAppleRepos()
    }
    
    private func setup() {
        navigationItem.title = "Apple Repos"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(progressView)
        
        NSLayoutConstraint.activate([
            progressView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            progressView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
}


