//
//  VKRepository.swift
//  LoginUI
//
//  Created by Роман Мисников on 06.06.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import Foundation
import RealmSwift

enum VKGroupSavePredicate {
    case userGroup
    case searchGroup
    
    var value: String {
        switch self {
        case .userGroup:
            return USER_GROUP
        case .searchGroup:
            return SEARCH_GROUP
        }
    }
}

class VKRepository {
    
    private let realm = try! Realm()
    
    // load saved data to Realm
    func loadData<T: Object>(type: T.Type, groupPredicate:VKGroupSavePredicate?) -> Array<T>? {
        guard let realm = try? Realm() else { return nil }
        // load all type data
        var object = realm.objects(type)
        // filter data
        if let pred = groupPredicate { object = object.filter("type == %@", pred.value) }
        
        return Array(object)
    }
    
    // save to Realm data base
    func savaData<T: Object>(data: [T], groupPredicate: VKGroupSavePredicate?) {
        do {
            // create realm object (get access to data base)
            let realm = try Realm()
            // load existed data
            var oldData = realm.objects(T.self)
            // ​.filter(​"​city​​==​​%@",​​"​Moscow")
            if let pred = groupPredicate { oldData = oldData.filter("type == %@", pred.value) }
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

