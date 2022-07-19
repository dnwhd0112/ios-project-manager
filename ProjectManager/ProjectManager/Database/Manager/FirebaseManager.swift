//
//  FirebaseManager.swift
//  ProjectManager
//
//  Created by 우롱차, 파프리 on 19/07/2022.
//

import Foundation
import FirebaseDatabase

final class FirebaseManager {
    private var database = Database.database().reference()
    
    func create(_ data: Task) throws {
        let taskItemRef = database.child("task").child(data.id)
        let values: [String: Any] = ["id": data.id, "title": data.title, "date": data.date.isoDateString, "body": data.body]
        taskItemRef.setValue(values)
    }
    
    func read() {
        
    }
    
    func readAll() {

    }
    
    func update(data: Task, updateHandler: ((Task) -> Void)) throws {
        
    }
    
    func delete(_ data: Task) throws {
        
    }
    
    func deleteAll() throws {
       
    }
}
