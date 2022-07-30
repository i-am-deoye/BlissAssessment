//
//  UserListViewModel.swift
//  bliss assessment
//
//  Created by Moses on 29/07/2022.
//

import Foundation

protocol IUserListViewModel {
    func fetchUsers(search query: SearchQuery) -> [User]
}

final class UserListViewModel: IUserListViewModel {
    private let listUsersUsecase: ListUsersUseCase
    
    init(listUsersUsecase: ListUsersUseCase) {
        self.listUsersUsecase = listUsersUsecase
    }
    
    func fetchUsers(search query: SearchQuery) -> [User] {
        return listUsersUsecase.execute(query)
    }
}
