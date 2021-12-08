//
//  DitailCashViewController.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 08.12.2021.
//

import UIKit

class DitailCashViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cashLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cashLabel.text = String(Account.shared.cash)
        nameLabel.text = Account.shared.name
    }
}
