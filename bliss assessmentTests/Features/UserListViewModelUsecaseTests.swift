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
        let (sut, listUser , _) = Helper.makeMainSUT(testCase: self)
        listUser.whenQueryIsEmpty = false
        sut.fetchUsers()
        XCTAssertEqual(sut.usersCount, 1)
    }
    
    func test_fetchUsers_byQuery_whenNotFound() {
        let (sut, _ , _) = Helper.makeMainSUT(testCase: self)
        
        sut.fetchUsers()
        XCTAssertEqual(sut.usersCount, 0)
    }
    
    func test_deleteUser_whenSuccessful() {
        let (sut, _ , deleteUser) = Helper.makeMainSUT(testCase: self)
        
        
        deleteUser.isErrorDeleting = false
        var expectedResult : String?
        
        sut.deleteUser(at: 0, reload: {}) { error in
            expectedResult = error
        }
        
        XCTAssertNil(expectedResult)
    }
    
    
    func test_deleteUser_deliverError() {
        let (sut, _ , deleteUser) = Helper.makeMainSUT(testCase: self)
        sut.users = [User.init(id: "0", username: "demo", avatarUrl: "url")]
        
        deleteUser.isErrorDeleting = true
        var expectedResult : String?
        
        sut.deleteUser(at: 0, reload: {}) { error in
            expectedResult = error
        }
        
        XCTAssertNotNil(expectedResult)
    }
    
}
