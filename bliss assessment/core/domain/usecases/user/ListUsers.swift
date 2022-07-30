//
//  ListUsers.swift
//  bliss assessment
//
//  Created by Moses on 29/07/2022.
//

import Foundation


public protocol ListUsersUseCase {
    func execute(_ query: SearchQuery) -> [User]
}


final class DefaultListUsersUseCase: ListUsersUseCase {
    private let repository: UsersRepository
    
    init(_ repository: UsersRepository) {
        self.repository = repository
    }
    
    func execute(_ query: SearchQuery) -> [User] {
        return repository.search(query)
    }
}
