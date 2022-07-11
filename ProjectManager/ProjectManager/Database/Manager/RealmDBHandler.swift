//
//  RealmDBHandler.swift
//  ProjectManager
//
//  Created by 곽우종 on 2022/07/10.
//

import Foundation
import RealmSwift
class RealmDBHandler: NSObject {
  let app = App(id: "application-0-jikqd")
  //lazy var partitionValue = "owner_id = user" // Specific to the user id that created
  //lazy var configuration = user.configuration(partitionValue: partitionValue)
  static let shared: RealmDBHandler = {
    let instance = RealmDBHandler()
    return instance
  }()
    
    func loginApp(excuteHandler: @escaping ((Realm) -> Void)) {
        
        //test
        app.login(credentials: Credentials.anonymous) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print("Login failed: \(error)")
                case .success(let user):
                    print("Login as \(user) succeeded!")
                    let partitionValue = "owner_id=\(user.id)"
                    // Get a sync configuration from the user object.
                    var syncConfig = user.configuration(partitionValue: partitionValue)
                    syncConfig.objectTypes = [CloudTask.self]
                    //let syncConfig = Realm.Configuration.defaultConfiguration
                    Realm.asyncOpen(configuration: syncConfig) { result in
                        switch result {
                        case .failure(let error):
                            print("Failed to open realm: \(error.localizedDescription)")
                            // Handle error...
                        case .success(let realm):
                            // Realm opened
                            excuteHandler(realm)
                        }
                    }
                }
                    // Continue below
                }
            }
        }
    }
