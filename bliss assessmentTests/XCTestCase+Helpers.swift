//
//  XCTestCase+Helpers.swift
//  bliss assessmentTests
//
//  Created by Moses on 30/07/2022.
//

import XCTest
import bliss_assessment

struct Helper {
    
    static func trackForMemoryLeaks(_ instance: AnyObject, testCase: XCTestCase, file: StaticString = #filePath, line: UInt = #line) {
        testCase.addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak.", file: file, line: line)
        }
    }
    
    static func makeMainSUT(testCase: XCTestCase, file: StaticString = #filePath, line: UInt = #line) -> (sut: UserListViewModel, listUsers: ListUsersUseCaseSpy, deleteUser: DeleteUserUseCaseSpy) {
        let listUsers = ListUsersUseCaseSpy()
        let deleteUser = DeleteUserUseCaseSpy()
        
        let sut = UserListViewModel.init(listUsersUsecase: listUsers,
                                         deleteUserUsercase: deleteUser)
        
        
        trackForMemoryLeaks(listUsers, testCase: testCase, file: file, line: line)
        trackForMemoryLeaks(deleteUser, testCase: testCase, file: file, line: line)
        return (sut, listUsers, deleteUser)
    }

}

