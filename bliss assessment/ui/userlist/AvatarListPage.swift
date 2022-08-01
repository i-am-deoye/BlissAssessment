//
//  AvatarListPage.swift
//  bliss assessment
//
//  Created by Moses on 30/07/2022.
//

import UIKit
import Swinject


extension AvatarListPage {
    static func register( using container: Container) {
        container.register(AvatarListPage.self) { r in
            let controller = AvatarListPage.init()
            
            let client = AlamofireHTTPClient.init()
            let local = CoreDataDriver.shared
            
            let usersRepository = DefaultUsersRepository.init(client: client, local: local)
            
            let listUsersUseCase = DefaultListUsersUseCase.init(usersRepository)
            let deleteUserUseCase = DefaultDeleteUserUseCase.init(usersRepository)
            
            controller.viewmodel = UserListViewModel.init(listUsersUsecase: listUsersUseCase,
                                                          deleteUserUsercase: deleteUserUseCase)
            return controller
        }
    }
}


final class AvatarListPage : UICollectionViewController {
    var viewmodel: IUserListViewModel!

    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewmodel.fetchUsers()
        setup()
    }
    
    private func setup() {
        navigationItem.title = "Avatar List"
        navigationController?.navigationBar.prefersLargeTitles = true
        collectionView.register(AvatarCell.self, forCellWithReuseIdentifier: AvatarCell.identifier)
    }
}
