//
//  FirebaseManagerTests.swift
//  FirebaseManagerTests
//
//  Created by 우롱차, 파프리 on 19/07/2022.
//

import XCTest
@testable import ProjectManager

class FirebaseManagerTests: XCTestCase {
    var dummyTask: Task!
    let firebaseManager = FirebaseManager()

    override func setUpWithError() throws {
        dummyTask = Task(title: "제목", date: Date.today, body: "내용")
        // firebaseManager.deleteAll()
    }

    override func tearDownWithError() throws {
       
    }

    func test_firebase_write() throws {
        let expectation = XCTestExpectation(description: "쓰기 성공")
        
        try? firebaseManager.create(dummyTask)
        let completion: (([Task]) -> Void) = { array in
            array.forEach { task in
                print(task)
                expectation.fulfill()
            }
        }
        
        firebaseManager.readAll(completion: completion)
        
        wait(for: [expectation], timeout: 10)
    }
    
    func test_firebase_update() throws {
        let expectation = XCTestExpectation(description: "업데이트 성공")
        
        let key = "E4787BAE-24FE-4A3E-8CBC-45337F2CDAA4"
        let task = Task(id: key, title: "업데이트 성공!", date: Date.today, body: "업데이트 성공완료!")
        try? firebaseManager.update(updatedData: task)
        
        let completion: (([Task]) -> Void) = { array in
            array.forEach { task in
                print(task)
                expectation.fulfill()
            }
        }
        
        firebaseManager.readAll(completion: completion)
        
        wait(for: [expectation], timeout: 10)
    }
    
    func test_firebase_delete() throws {
        let expectation = XCTestExpectation(description: "삭제 성공")
        
        let key = "E4787BAE-24FE-4A3E-8CBC-45337F2CDAA4"
        let task = Task(id: key, title: "삭제! 성공!", date: Date.today, body: "삭제! 성공완료!")
        try? firebaseManager.delete(task)
        
        let completion: (([Task]) -> Void) = { array in
            array.forEach { task in
                print(task)
                expectation.fulfill()
            }
        }
        
        firebaseManager.readAll(completion: completion)
        
        wait(for: [expectation], timeout: 10)
    }

}
