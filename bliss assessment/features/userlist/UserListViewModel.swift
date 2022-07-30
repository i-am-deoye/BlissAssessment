//
//  UserListViewModel.swift
//  bliss assessment
//
//  Created by Moses on 29/07/2022.
//

import Foundation

public protocol IUserListViewModel {
    func fetchUsers(search query: SearchQuery) -> [User]
    func delete(user: User, error: (String) -> Void)
}

public final class UserListViewModel: IUserListViewModel {
    private let listUsersUsecase: ListUsersUseCase
    private let deleteUserUsercase: DeleteUserUseCase
    
    public init(listUsersUsecase: ListUsersUseCase, deleteUserUsercase: DeleteUserUseCase) {
        self.listUsersUsecase = listUsersUsecase
        self.deleteUserUsercase = deleteUserUsercase
    }
    
    public func fetchUsers(search query: SearchQuery) -> [User] {
        return listUsersUsecase.execute(query)
    }
    
    public func delete(user: User, error handler: (String) -> Void) {
        do {
            try deleteUserUsercase.execute(user)
        } catch {
            handler(error.localizedDescription)
        }
    }
}
