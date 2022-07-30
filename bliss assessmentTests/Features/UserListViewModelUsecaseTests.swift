//
//  UserListViewModelUsecaseTests.swift
//  bliss assessmentTests
//
//  Created by Moses on 30/07/2022.
//

import XCTest
import bliss_assessment



class UserListViewModelUsecaseTests: XCTestCase {
    
    
    func test_fetchUsers_byQuery_whenNotEmpty() {
        let (sut, _ , _) = Helper.makeMainSUT(testCase: self)
        
        let query = "demo"
        
        let users = sut.fetchUsers(search: query)
        XCTAssertEqual(users.count, 1)
    }
    
    func test_fetchUsers_byQuery_whenNotFound() {
        let (sut, _ , _) = Helper.makeMainSUT(testCase: self)
        
        let query = "demo-"
        
        let users = sut.fetchUsers(search: query)
        XCTAssertEqual(users.count, 0)
    }
    
    func test_deleteUser_whenSuccessful() {
        let (sut, _ , deleteUser) = Helper.makeMainSUT(testCase: self)
        
        
        deleteUser.isErrorDeleting = false
        var expectedResult : String?
        
        let user = User.init(id: "0", username: "demo", avatarUrl: "<url>")
        sut.delete(user: user) { error in
            expectedResult = error
        }
        
        XCTAssertNil(expectedResult)
    }
    
    
    func test_deleteUser_deliverError() {
        let (sut, _ , deleteUser) = Helper.makeMainSUT(testCase: self)
        
        let expectation = expectation(description: "Delete user deliver error")
        
        deleteUser.isErrorDeleting = true
        var expectedResult : String?
        
        let user = User.init(id: "0", username: "demo", avatarUrl: "<url>")
        sut.delete(user: user) { error in
            expectedResult = error
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
        XCTAssertNotNil(expectedResult)
    }
    
}
