//
//  ProjectManagerTests.swift
//  ProjectManagerTests
//
//  Created by 우롱차, 파프리 on 05/07/2022.
//

import XCTest

@testable import ProjectManager

class RealmSyncTests: XCTestCase {

    //var projectManager: CloudTaskManager!
    var dbHandler: RealmDBHandler!
    
    override func setUpWithError() throws {
        dbHandler = RealmDBHandler.shared
    }

    override func tearDownWithError() throws {
        //try projectManager.deleteAll()
       // projectManager = nil
    }

    func test_Create() throws {
        
        let expectation = XCTestExpectation(description: "APIPrivoderTaskExpectation")
        
        dbHandler.loginApp { realm in
            let projectManager = CloudTaskManager(realmManager: RealmManager(realm: realm))
            let id = UUID().uuidString
            let project = CloudTask(id: id, date: Date(), body: "테스트 바디입니다.", owner_id: "user", title: "테스트 타이틀입니다.")
            try? projectManager.create(task: project)
            let result = projectManager.read(id: id)
            print(projectManager.readAll())
            expectation.fulfill()
            
            XCTAssertEqual(project, result)
        }
        
        wait(for: [expectation], timeout: 100)
    }
    /*
    
    func test_remove() {
        do {
            let project = Task(title: "삭제 테스트", date: Date(), body: "삭제바디입니다")
            let id = project.id
            try projectManager.create(task: project)
            try projectManager.delete(task: project)
            let data = projectManager.read(id: id)
            XCTAssertNil(data)
        } catch {
            XCTFail("삭제 실패")
        }
    }
    
    func test_update() {
        do {
            let updateTitle = "업데이트 성공!"
            let project = Task(title: "업데이트", date: Date(), body: "바디바디")
            try projectManager.create(task: project)
            let updateHandler: ((Task) -> Void) = { project in
                project.title = updateTitle
            }
            try projectManager.update(task: project, updateHandler: updateHandler)
            let value = projectManager.read(id: project.id)
            XCTAssertEqual(value?.title, updateTitle)
            XCTAssertEqual(project, value)
        } catch {
            XCTFail("업데이트 실패")
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
     */
}
