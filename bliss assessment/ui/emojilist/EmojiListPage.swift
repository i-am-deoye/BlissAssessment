//
//  EmojiListPage.swift
//  bliss assessment
//
//  Created by Moses on 30/07/2022.
//

import UIKit
import Swinject


extension EmojiListPage {
    static func register( using container: Container) {
        container.register(EmojiListPage.self) { r in
            let controller = EmojiListPage.init()
            
            let client = AlamofireHTTPClient.init()
            let local = CoreDataDriver.shared
            
            let emojiRepository = DefaultEmojisRepository.init(client: client, local: local)
            let listEmojisUseCase = DefaultListEmojisUseCase.init(emojiRepository)
            
            controller.viewmodel = EmojiListViewModel.init(listEmojisUsecase: listEmojisUseCase)
            return controller
        }
    }
}


final class EmojiListPage : UICollectionViewController {
    var viewmodel: IEmojiListViewModel!
    
    lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.translatesAutoresizingMaskIntoConstraints = false
        refresh.tintColor = UIColor.red
        refresh.addTarget(self, action: #selector(refreshList), for: .valueChanged)
        return refresh
    }()
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewmodel.fetchEmojis()
        setup()
    }
    
    private func setup() {
        navigationItem.title = "Emoji List"
        navigationController?.navigationBar.prefersLargeTitles = true
        collectionView.register(EmojiCell.self, forCellWithReuseIdentifier: EmojiCell.identifier)
        
        self.collectionView?.alwaysBounceVertical = true
        self.collectionView?.refreshControl = refreshControl
    }
}
