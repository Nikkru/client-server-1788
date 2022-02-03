//
//  StorageViewController.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 22.12.2021.
//

import UIKit
import RealmSwift

// DTO - модель для работы с сетью
// DAO - модель для работы с базой данных

struct StudentDTO: Codable {
    var name = ""
    var group = ""
}

class StudentDAO: Object, Codable {
    @objc dynamic var name = ""
    @objc dynamic var group = ""
}

class StorageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       useRealm()
    }
    
    func useRealm() {
        let student = StudentDAO()
        student.name = "Boris"
        student.group = "1788"
        
        // Хранилище
        let realm = try! Realm()
        
        realm.beginWrite()
        realm.add(student)
        try! realm.commitWrite()
        
        let students = realm.objects(StudentDAO.self)
        students.forEach { print($0.name, $0.group) }
    }
   
}
