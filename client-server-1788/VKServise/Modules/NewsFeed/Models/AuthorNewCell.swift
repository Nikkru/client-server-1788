//
//  AuthorNewCell.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 29.01.2022.
//
import UIKit

class AuthorNewFeedCell: UITableViewCell {

    @IBOutlet weak var AuthorFeedLabel: UILabel!
    @IBOutlet weak var DateFeedLabel: UILabel!
    @IBOutlet weak var AuthorImge: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

