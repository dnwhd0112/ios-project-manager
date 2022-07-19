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
        firebaseManager.deleteAll()
    }

    override func tearDownWithError() throws {
       
    }

    func test_firebase_write() throws {
        let expectation = XCTestExpectation(description: "성공")
        
        try? firebaseManager.create(dummyTask)
        try? firebaseManager.readAll()
        
        wait(for: [expectation], timeout: 10)
    }

}
