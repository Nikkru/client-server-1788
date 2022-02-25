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
    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        
//        self.setLabelFrame(label: self.textFeedLabel,
//                           instets: 6,
//                           indent: nil)
//        //        The constrints for myLabel
//        //MARK: - МЕТОД ПРИКРЕПЛЯЮЩИЙ ЛЕЙБЛ К ПРЕДСТАВЛЕНИЮ СОДЕРЖИМОГО ЯЧЕЙКИ
//        let margins = contentView.layoutMarginsGuide
//        NSLayoutConstraint.activate(
//            [
//                textFeedLabel.topAnchor.constraint(equalTo: margins.topAnchor),
//                textFeedLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
//                textFeedLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
//                textFeedLabel.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
//            ])
//
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setLabelFrame(label: textFeedLabel, instets: instets, indent: nil)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func config(text: String) {

        self.textFeedLabel.text = text
        self.setLabelFrame(label: textFeedLabel, instets: instets, indent: nil)
    }
}
