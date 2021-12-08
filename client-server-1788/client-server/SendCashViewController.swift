//
//  ViewController.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 08.12.2021.
//

import UIKit

class SendCashViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var cashTextField: UITextField!
    
    let account = Account.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    @IBAction func sendCashAction(_ sender: Any) {
        
        guard let cashString = cashTextField.text,
              let cash = Int(cashString),
              let name = nameTextField.text
        else { return }
        
        account.name = name
        account.cash = cash
    }
    
}

