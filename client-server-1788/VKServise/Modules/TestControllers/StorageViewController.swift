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
        
    }
   
}
