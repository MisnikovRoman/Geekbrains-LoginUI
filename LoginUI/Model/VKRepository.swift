//
//  VKRepository.swift
//  LoginUI
//
//  Created by Роман Мисников on 06.06.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import Foundation
import RealmSwift

class VKRepository {
    
    private let realm = try! Realm()
    
    // load saved data to Realm
    func loadData<T: Object>(type: T.Type) -> Array<T>? {
        guard let realm = try? Realm() else { return nil }
        return Array(realm.objects(type))
    }
    
    // save to Realm data base
    func savaData<T: Object>(data: [T]) {
        do {
            // create realm object (get access to data base)
            let realm = try Realm()
            // load existed data
            let oldData = realm.objects(T.self)
            // start writting data
            try realm.write {
                realm.delete(oldData)
                realm.add(data)
            }
        } catch {
            print("<!> Realm error: ", error.localizedDescription)
        }
    }
}

