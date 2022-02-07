//
//  LikeNewsFeedCell.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 26.01.2022.
//

import UIKit

class LikeNewsFeedCell: UITableViewCell {

    @IBOutlet weak var likeNewsButton: UIButton!
    @IBOutlet weak var commentNewsButton: UIButton!
    @IBOutlet weak var sharedNewsButton: UIButton!
    @IBOutlet weak var countLikeLabel: UILabel!
    @IBOutlet weak var countCommentLabel: UILabel!
    @IBOutlet weak var countSharedLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func config(countLikes: Int, countComments: Int, countShared: Int) {
        
        self.countLikeLabel.text = String(countLikes)
        self.countCommentLabel.text = String(countComments)
        self.countSharedLabel.text = String(countShared)
    }
    
}
