//
//  AuthorNewCell.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 29.01.2022.
//
import UIKit
import SDWebImage

class AuthorNewFeedCell: UITableViewCell {

    @IBOutlet weak var authorNewsFeedLabel: UILabel!
    @IBOutlet weak var dateNewsFeedLabel: UILabel!
    @IBOutlet weak var authorImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    func config(authorName: String, authorAvatar: String, dateNews: String) {
//        
//        self.authorNewsFeedLabel.text = authorName
//        self.authorImage.sd_setImage(with: URL(string: authorAvatar))
//        self.dateNewsFeedLabel.text = dateNews
//    }

}

