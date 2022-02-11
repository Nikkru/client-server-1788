//
//  TextNewsFeedCell.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 26.01.2022.
//

import UIKit

class TextNewsFeedCell: UITableViewCell {

    @IBOutlet weak var textFeedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(text: String) {
        
        self.textFeedLabel.text = text
    }

}
