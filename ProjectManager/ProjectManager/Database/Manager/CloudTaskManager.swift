//
//  TaskManager.swift
//  TaskManager
//
//  Created by 우롱차, 파프리 on 05/07/2022.
//

import Foundation

final class CloudTaskManager {
    private let realmManager: RealmManagerable
    
    init(realmManager: RealmManager) {
        self.realmManager = realmManager
    }
    
    func create(task: CloudTask) throws {
        try realmManager.create(task)
    }
    
    func read(id: String) -> CloudTask? {
        let predicate = NSPredicate(format: "_id = %@", id)
        return realmManager.read(predicate)
    }
    
    func readAll() -> [CloudTask] {
        return realmManager.readAll()
    }
    
    func update(task: CloudTask, updateHandler: (CloudTask) -> Void) throws {
        try realmManager.update(data: task, updateHandler: updateHandler)
    }
    
    func delete(task: CloudTask) throws {
        try realmManager.delete(task)
    }
    
    func deleteAll() throws {
        try realmManager.deleteAll()
    }
}
