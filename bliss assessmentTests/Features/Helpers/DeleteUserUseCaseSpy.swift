//
//  DeleteUserUseCaseSpy.swift
//  bliss assessmentTests
//
//  Created by Moses on 30/07/2022.
//

import Foundation
import bliss_assessment


class DeleteUserUseCaseSpy: DeleteUserUseCase {
    var isErrorDeleting = false
    
    
    func execute(_ user: User) throws {
        if isErrorDeleting {
            throw NSError.init(domain: "error", code: 00009, userInfo: nil)
        }
    }
}
