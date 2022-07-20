//
//  Project.swift
//  ProjectManager
//
//  Created by 우롱차, 파프리 on 2022/07/05.
//

import RealmSwift

class Task: Object, FirebaseDatable, Codable {
    static var path: [String] = ["task"]
    
    var detailPath: [String] {
        var newPath = Task.path
        newPath.append(id)
        return newPath
    }
    
    @Persisted(primaryKey: true) var id: String
    @Persisted var title: String?
    @Persisted var date: String
    @Persisted var body: String?

    convenience init(id: String = UUID().uuidString, title: String?, date: Date, body: String?) {
        self.init()
        self.id = id
        self.title = title
        self.date = date.isoDateString
        self.body = body
    }
}
