//
//  DeleteUser.swift
//  bliss assessment
//
//  Created by Moses on 30/07/2022.
//

import Foundation


protocol DeleteUserUseCase {
    func execute(_ user: User) throws
}


final class DefaultDeleteUserUseCase: DeleteUserUseCase {
    private let repository: UsersRepository
    
    init(_ repository: UsersRepository) {
        self.repository = repository
    }
    
    func execute(_ user: User) throws {
        return try repository.delete(user)
    }
}
