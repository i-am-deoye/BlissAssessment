//
//  ListUsers.swift
//  bliss assessment
//
//  Created by Moses on 29/07/2022.
//

import Foundation


public protocol ListUsersUseCase {
    func execute() -> [User]
}


final class DefaultListUsersUseCase: ListUsersUseCase {
    private let repository: UsersRepository
    
    init(_ repository: UsersRepository) {
        self.repository = repository
    }
    
    func execute() -> [User] {
        return repository.fetchUsers()
    }
}
