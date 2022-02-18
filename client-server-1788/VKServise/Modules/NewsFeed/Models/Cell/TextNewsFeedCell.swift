//
//  TextNewsFeedCell.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 26.01.2022.
//

import UIKit

class TextNewsFeedCell: UITableViewCell {
    
    let instets: CGFloat = 10.0
    
    @IBOutlet weak var textFeedLabel: UILabel! {
        didSet {
            textFeedLabel.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setLabelFrame(label: textFeedLabel, instets: instets)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func config(text: String) {

        self.textFeedLabel.text = text
        self.setLabelFrame(label: textFeedLabel, instets: instets)
    }
}
