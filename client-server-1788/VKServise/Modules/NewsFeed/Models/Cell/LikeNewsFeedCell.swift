//
//  LikeNewsFeedCell.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 26.01.2022.
//

import UIKit

class LikeNewsFeedCell: UITableViewCell {

    @IBOutlet weak var LikeNewsButton: UIButton!
    @IBOutlet weak var CommentNewsButton: UIButton!
    @IBOutlet weak var SharedNewsButton: UIButton!
    @IBOutlet weak var CountLikeLabel: UILabel!
    @IBOutlet weak var CountCommentLabel: UILabel!
    @IBOutlet weak var CountSharedLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
