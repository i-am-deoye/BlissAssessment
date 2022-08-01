//
//  UserListViewModel.swift
//  bliss assessment
//
//  Created by Moses on 29/07/2022.
//

import Foundation
import RxSwift

public protocol IUserListViewModel {
    var users: [User] { get set }
    var usersCount: Int { get }
    
    func fetchUsers()
    func getUser(by index: Int) -> User?
    func deleteUser(at index: Int, reload: @escaping () -> Void, error: (String) -> Void)
}

public final class UserListViewModel: IUserListViewModel {
    
    
    public var users = [User]()
    
    public var usersCount: Int {
        return users.count
    }
    
    
    
    private let listUsersUsecase: ListUsersUseCase
    private let deleteUserUsercase: DeleteUserUseCase
    
    public init(listUsersUsecase: ListUsersUseCase, deleteUserUsercase: DeleteUserUseCase) {
        self.listUsersUsecase = listUsersUsecase
        self.deleteUserUsercase = deleteUserUsercase
    }
    
    
    private func delete(user: User, error handler: (String) -> Void) {
        do {
            try deleteUserUsercase.execute(user)
        } catch {
            handler(error.localizedDescription)
        }
    }
    
    public func fetchUsers() {
        self.users = listUsersUsecase.execute()
    }
    
    public func getUser(by index: Int) -> User? {
        if users.isEmpty { return nil }
        if index > usersCount - 1 { return nil }
        return users[index]
    }
    
    
    public func deleteUser(at index: Int, reload: @escaping () -> Void, error: (String) -> Void) {
        if users.isEmpty { return }
        if index > usersCount - 1 { return }
        let user = users.remove(at: index)
        delete(user: user, error: error)
        reload()
    }
}
