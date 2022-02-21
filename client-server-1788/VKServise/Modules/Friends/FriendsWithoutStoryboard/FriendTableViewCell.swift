//
//  FriendTableViewCell.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 18.02.2022.
//

import UIKit

class FriendTableViewCell: UITableViewCell {
    
    static let indetifier = "TextCell"
    
    private let myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Placeholderimage")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let myLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .orange
        contentView.addSubview(myImageView)
        contentView.addSubview(myLabel)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configerCell()
    }

//    MARK: - сборка настройки размеров и констрейнтов для лейба и картинки 
 func configerCell() {
    
        let instets: CGFloat = 12
        let imageSize = contentView.frame.size.height - (instets / 2)
    
        self.setLabelFrame(label: self.myLabel, instets: instets, indent: imageSize)
        
        //        myLabel.frame = CGRect(
        //            x: imageSize + instets + instets,
        //            y: 0,
        //            width: contentView.frame.size.width - instets*3 - imageSize,
        //            height: contentView.frame.size.height)
        
        myImageView.frame = CGRect(
            x: instets / 2,
            y: (contentView.frame.size.height - imageSize) / 2,
            width: imageSize,
            height: imageSize)
        
        myImageView.layer.cornerRadius = myImageView.frame.width / 2
        myImageView.layer.shadowRadius = 5
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 5, height: 8)
        
        myImageView.clipsToBounds = true
    }

//    MARK: - сборка ячейки с лейбом
    func config(text: String) {
        
        self.myLabel.text = text
        self.myLabel.textAlignment = .left
        self.myLabel.numberOfLines = 0
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.myLabel.translatesAutoresizingMaskIntoConstraints = false
    
        //        self.setLabelFrame(label: myLabel, instets: 10)
    }
}
