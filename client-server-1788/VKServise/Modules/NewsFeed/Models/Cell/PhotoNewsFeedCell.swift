//
//  PhotoNewsFeedCell.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 26.01.2022.
//

import UIKit
import SDWebImage

class PhotoNewsFeedCell: UITableViewCell {

    @IBOutlet weak var photoFeedImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func config(urlAuthorPhoto: String) {
        
        guard  let url = URL(string: urlAuthorPhoto) else { return
            self.photoFeedImageView.image = UIImage(systemName: "person")
        }
        self.photoFeedImageView.sd_setImage(with: url)
    }
    
}
