//
//  FirebaseManager.swift
//  ProjectManager
//
//  Created by 우롱차, 파프리 on 19/07/2022.
//

import Foundation
import FirebaseDatabase
import FirebaseDatabaseSwift
import RealmSwift

protocol FirebaseManagerAble {
    func create<T: FirebaseDatable>(_ data: T) throws
    func readAll<T: FirebaseDatable> (completion: @escaping ([T])->(Void))
    func update<T: FirebaseDatable>(updatedData: T) throws
    func delete<T: FirebaseDatable>(_ data: T) throws
//    func deleteAll() throws
}

//: DatabaseManagerable
final class FirebaseManager: FirebaseManagerAble {
    
    private var database: DatabaseReference
    
    init(firebaseReference: DatabaseReference = Database.database().reference()) {
        self.database = firebaseReference
    }
    
    func create<T: FirebaseDatable>(_ data: T) throws {
        guard let encodedValues = (data as? Encodable)?.toDictionary else {
            return
        }
        
        let taskItemRef = data.detailPath.reduce(database) { database, path in
            database.child(path)
        }
        
        taskItemRef.setValue(encodedValues)
    }
    
    func readAll<T: FirebaseDatable>(completion: @escaping ([T]) -> Void) {
        
        let taskItemRef = T.path.reduce(database) { database, path in
            database.child(path)
        }
        
        taskItemRef.getData { error, dataSnapshot in
            guard error == nil, let dataSnapshot = dataSnapshot
            else {
                return
            }
            
            guard let childArray = dataSnapshot.children.allObjects as? [DataSnapshot] else {
                return
            }
            
            let array = childArray.compactMap { child in
                try? child.data(as: T.self)
            }
            
            completion(array)
        }
    }
    
    func update<T: FirebaseDatable>(updatedData: T) throws {
        guard let encodedValues = (updatedData as? Encodable)?.toDictionary else {
            return
        }
        
        let taskItemRef = updatedData.detailPath.reduce(database) { database, path in
            database.child(path)
        }
        
        taskItemRef.updateChildValues(encodedValues)
    }
    
    func delete<T: FirebaseDatable>(_ data: T) throws {
        
        let taskItemRef = data.detailPath.reduce(database) { database, path in
            database.child(path)
        }
        
        taskItemRef.removeValue()
    }
    
    /*
    func deleteAll() throws {
        try realm.write({
            realm.deleteAll()
        })
    }
    */
}
    /*
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
     */

protocol FirebaseDatable: Decodable {
    var detailPath: [String] { get }
    static var path: [String] { get }
}

protocol DataAble {
    
}

extension DataSnapshot {
    var data: Data? {
        guard let value = value, !(value is NSNull) else { return nil }
        return try? JSONSerialization.data(withJSONObject: value)
    }
    var json: String? { data?.string }
}
extension Data {
    var string: String? { String(data: self, encoding: .utf8) }
}
