//
//  MainPage.swift
//  bliss assessment
//
//  Created by Moses on 30/07/2022.
//

import UIKit
import Swinject


extension MainPage {
    static func register( using container: Container) {
        container.register(MainPage.self) { r in
            let controller = MainPage.init()
            
            let client = AlamofireHTTPClient.init()
            let local = CoreDataDriver.shared
            
            let emojiRepository = DefaultEmojisRepository.init(client: client, local: local)
            let fetchEmojisUseCase = DefaultFetchEmojisUseCase.init(emojiRepository)
            let getRandomEmojiUseCase = DefaultGetRandomEmojiUseCase.init(emojiRepository)
            
            let usersRepository = DefaultUsersRepository.init(client: client, local: local)
            let searchUserUseCase = DefaultSearchUserUseCase.init(usersRepository)
            let listUsersUseCase = DefaultListUsersUseCase.init(usersRepository)
            
            controller.viewmodel = MainViewModel.init(fetchEmojisUsecase: fetchEmojisUseCase,
                                                      randomEmojiUsecase: getRandomEmojiUseCase,
                                                      searchUserUseCase: searchUserUseCase,
                                                      listUsersUseCase: listUsersUseCase)
            return controller
        }
    }
}


final class MainPage : UIViewController {
    var viewmodel: IMainViewModel!
    private let stackSpacing: CGFloat = 16
    
    lazy var progressView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private lazy var stack: UIStackView = {
        let content = UIStackView.init(arrangedSubviews: [randomEmojiButton, emojiListButton,
                                                          searchStack, userListButton,
                                                          appleReposButton])
        content.spacing = stackSpacing
        content.axis = .vertical
        content.distribution = .fillEqually
        content.translatesAutoresizingMaskIntoConstraints = false
        return content
    }()
    
    private lazy var searchStack: UIStackView = {
        let content = UIStackView.init(arrangedSubviews: [searchInputBar, searchButton])
        content.spacing = stackSpacing
        content.axis = .horizontal
        content.translatesAutoresizingMaskIntoConstraints = false
        searchButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        return content
    }()
    
    lazy var searchInputBar: UISearchBar = {
        let search = UISearchBar()
        search.delegate = self
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()
    
    lazy var randomEmojiButton: UIButton = {
        let button = UIButton()
        button.setTitle("RANDOM EMOJI", for: .normal)
        button.backgroundColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false
        button.addTarget(self, action: #selector(showRandomEmoji), for: .touchUpInside)
        return button
    }()
    
    lazy var emojiListButton: UIButton = {
        let button = UIButton()
        button.setTitle("EMOJI LIST", for: .normal)
        button.backgroundColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false
        button.addTarget(self, action: #selector(presentEmojiList), for: .touchUpInside)
        return button
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("SEARCH", for: .normal)
        button.backgroundColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(searchAvatar), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    lazy var userListButton: UIButton = {
        let button = UIButton()
        button.setTitle("AVATAR LIST", for: .normal)
        button.backgroundColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(presentAvatarList), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    private lazy var appleReposButton: UIButton = {
        let button = UIButton()
        button.setTitle("APPLE REPOS", for: .normal)
        button.backgroundColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(presentAppleRepos), for: .touchUpInside)
        return button
    }()
    
    
    lazy var randomImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchEmojis()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkIfAvatarsSaved()
    }
    
    private func setup() {
        
        view.addSubview(randomImageView)
        
        NSLayoutConstraint.activate([
            randomImageView.heightAnchor.constraint(equalToConstant: 120),
            randomImageView.widthAnchor.constraint(equalToConstant: 120),
            randomImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            randomImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stack.topAnchor.constraint(equalTo: randomImageView.bottomAnchor, constant: 16),
            stack.heightAnchor.constraint(equalToConstant: 389)
        ])
        
        view.addSubview(progressView)
        NSLayoutConstraint.activate([
            progressView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            progressView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
}
