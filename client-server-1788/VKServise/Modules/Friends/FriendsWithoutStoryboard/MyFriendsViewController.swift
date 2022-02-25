//
//  MyFriendsViewController.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 20.02.2022.
//

import UIKit

class MyFriendsViewController: UIViewController {
    
    private let myFriendTableView: UITableView = {
        
        let tableView = UITableView()
//        let tableView = UITableView(frame: .zero, style: .plain)
//        tableView.register(MyFriendsCell.self, forCellReuseIdentifier: MyFriendsCell.cellIndetifier)
        tableView.register(MyFriendsCell.self, forCellReuseIdentifier: MyFriendsCell.cellIndetifier)
        return tableView
    }()
    
    private let text = "Apple also mandates retina images at 2x and 3x resolution while Android requires support for 4x (xxxhdpi), 3x (xxhdpi), 2x (xhdpi), 1.5x (hdpi), 1x (mdpi), and 0.75x (ldpi) drawables. Thanks, iOS and Android overlords! Supporting multiple devices and battling these amazingly talented developers is evidently not enough of a challenge. The benevolent platform bosses also want to drown developers in menial work that should be automated natively by iOS and Android platforms."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configerTableView()
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//
//        myFriendTableView.frame = view.bounds
//    }

//    MARK: - Метод сборки настроек TableView
    func configerTableView() {
        
        view.addSubview(myFriendTableView)
        myFriendTableView.delegate = self
        myFriendTableView.dataSource = self
        myFriendTableView.frame = view.bounds
//        myFriendTableView.estimatedRowHeight = CGFloat.greatestFiniteMagnitude
        myFriendTableView.rowHeight = UITableView.automaticDimension
    }
}

extension MyFriendsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyFriendsCell.cellIndetifier, for: indexPath) as? MyFriendsCell else { return UITableViewCell() }
        cell.configer(text: text)

        return cell
    }
}

extension MyFriendsViewController: UITableViewDelegate {

}
