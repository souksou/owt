//
//  DatabaseManager.swift
//  owt-tiny-mvvm
//
//  Created by Souksouvanh Thomas on 30/05/2019.
//  Copyright © 2019 th. All rights reserved.
//

import UIKit
import RealmSwift

class DatabaseManager {
    
    static let shared = DatabaseManager()
    private let realm = try! Realm()
    
    // MARK: - Lifecycle
    
    private init() {}
    
    
    // MARK: - Work With TinyUrl
    func add(tinyUrls: TinyUrl) {
        try! realm.write {
            realm.add(tinyUrls)
        }
    }
    
    func searchTinyUrl(query: String) -> [TinyUrl] {
        let predicate = NSPredicate(format: "originalUrl CONTAINS %@", query)
        let tinyUrisFilter = realm.objects(TinyUrl.self).filter(predicate).sorted(byKeyPath: "dateCreate")
        return Array(tinyUrisFilter)
    }
    
    func fetchTinyUrl() -> [TinyUrl] {
        let uris = realm.objects(TinyUrl.self).sorted(byKeyPath: "dateCreate")
        return Array(uris)
    }
    
    // MARK: - Work With Objects
    func delete(object: Object) {
        try! realm.write {
            realm.delete(object)
        }
    }
}

