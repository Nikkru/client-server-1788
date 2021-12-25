//
//  RealmViewController.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 24.12.2021.
//

import UIKit
import RealmSwift

@objcMembers

class PersonDAO: Object {
    dynamic var name = ""
    dynamic var age = 0
    dynamic var gender = ""
    dynamic var adress = ""
}

class RealmViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let person = PersonDAO()
        
        person.name = "Jack"
        person.gender = "male"
        person.age = 34
        person.adress = "Bali"
        
        let migration = Realm.Configuration(schemaVersion: 1)

        let mainRealm = try! Realm(configuration: migration)
        
//        do {
            mainRealm.beginWrite()
            mainRealm.add(person)
            try! mainRealm.commitWrite()
            
//        } catch {
//
//            print(error)
//        }
        print(mainRealm.configuration.fileURL)
        
        let newPerson = mainRealm.objects(PersonDAO.self)
        newPerson.forEach { print($0.gender, $0.gender, $0.age)}
        
        mainRealm.beginWrite()
        mainRealm.delete(person)
        try! mainRealm.commitWrite()
    }
}
