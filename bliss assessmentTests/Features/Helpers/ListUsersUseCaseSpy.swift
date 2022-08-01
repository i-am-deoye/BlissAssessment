//
//  ListUsersUseCaseSpy.swift
//  bliss assessmentTests
//
//  Created by Moses on 30/07/2022.
//

import Foundation
import bliss_assessment


class ListUsersUseCaseSpy: ListUsersUseCase {
    
    var whenQueryIsEmpty = true
    
    func execute() -> [User] {
        if !whenQueryIsEmpty { return [User.init(id: "1", username: "demo", avatarUrl: "<url>")] }
        return []
    }
}
