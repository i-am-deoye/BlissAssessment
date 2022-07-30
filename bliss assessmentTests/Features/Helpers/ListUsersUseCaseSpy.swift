//
//  ListUsersUseCaseSpy.swift
//  bliss assessmentTests
//
//  Created by Moses on 30/07/2022.
//

import Foundation
import bliss_assessment


class ListUsersUseCaseSpy: ListUsersUseCase {
    private var whenQueryIs = "demo"
    
    func execute(_ query: SearchQuery) -> [User] {
        if whenQueryIs == query { return [User.init(id: "1", username: "demo", avatarUrl: "<url>")] }
        return []
    }
}
