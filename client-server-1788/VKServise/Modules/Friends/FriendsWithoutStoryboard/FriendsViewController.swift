//
//  FriendsViewController.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 18.02.2022.
//

import UIKit

class FriendsViewController: UIViewController {
    
    private var data = [String]()
    private let apiCaller = APICaller()
    private let cell = FriendTableViewCell()
    
    private let friendsTableView: UITableView = {
        
//        let tableView = UITableView()
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(FriendTableViewCell.self, forCellReuseIdentifier: FriendTableViewCell.indetifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configerFriendsTableView()
    }
    
//    MARK: - viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        cell.configerCell()
        
        friendsTableView.frame = view.bounds
        
        apiCaller.fetchData( pagination: false, completion: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.data.append(contentsOf: data) // приложение падает при поворте
                DispatchQueue.main.async {
                    self.friendsTableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
        
        
    }
  
    // MARK: - сборка настройки FriendsTableView
    private func configerFriendsTableView() {
        
        friendsTableView.backgroundColor = .link
        view.addSubview(friendsTableView)
        friendsTableView.dataSource = self
        friendsTableView.delegate = self
    }
}

// MARK: - UITableViewDataSource
extension FriendsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = friendsTableView.dequeueReusableCell(withIdentifier: FriendTableViewCell.indetifier, for: indexPath) as? FriendTableViewCell else { return UITableViewCell() }
        
        cell.config(text: data[indexPath.row])
//        cell.textLabel?.text = data[indexPath.row]
//        cell.imageView?.image = UIImage(named: "Placeholderimage")
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension FriendsViewController: UITableViewDelegate {


}

// MARK: - UIScrollViewDelegate
extension FriendsViewController: UIScrollViewDelegate {
    
    // MARK: - creatSpinerFooter
    private func creatSpinerFooter() -> UIView {
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        
        return footerView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let position = scrollView.contentOffset.y
        if position > (friendsTableView.contentSize.height - 100 - scrollView.frame.size.height) {
            
            //            fetch more data
            guard !apiCaller.isPaginated else {
                //                here we are already fetching more data
                return
            }
            self.friendsTableView.tableFooterView = creatSpinerFooter()
            
            apiCaller.fetchData(pagination: true) { [weak self] result in
                guard let strongSelf = self else { return }
                
              
                
                switch result {
                case .success(let data):
                    strongSelf.data.append(contentsOf: data)
                    DispatchQueue.main.async {
                        strongSelf.friendsTableView.tableFooterView = nil
                        strongSelf.friendsTableView.reloadData()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}

