//
//  MyFriendsCell.swift
//  client-server-1788
//
//  Created by Nikolai Krusser on 20.02.2022.
//

import UIKit

class MyFriendsCell: UITableViewCell {
    
    let txt = "Apple also mandates retina images at 2x and 3x resolution while Android requires support for 4x (xxxhdpi), 3x (xxhdpi), 2x (xhdpi), 1.5x (hdpi), 1x (mdpi), and 0.75x (ldpi) drawables. Thanks, iOS and Android overlords! Supporting multiple devices and battling these amazingly talented developers is evidently not enough of a challenge. The benevolent platform bosses also want to drown developers in menial work that should be automated natively by iOS and Android platforms."
    
    static let cellIndetifier = "CellLabel"
    
    private let myLabel: UILabel = {
        let label = UILabel()
//        label.textColor = .white
        label.backgroundColor = .green
        label.font = .systemFont(ofSize: 17, weight: .bold)
//        label.numberOfLines = 0
//        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .orange
        //        contentView.addSubview(myImageView)
        
        contentView.addSubview(myLabel)

//        myLabel.numberOfLines = 0
        
//        myLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //        The constrints for myLabel
        //MARK: - МЕТОД ПРИКРЕПЛЯЮЩИЙ ЛЕЙБЛ К ПРЕДСТАВЛЕНИЮ СОДЕРЖИМОГО ЯЧЕЙКИ
        let margins = contentView.layoutMarginsGuide
        NSLayoutConstraint.activate(
            [
                myLabel.topAnchor.constraint(equalTo: margins.topAnchor),
                myLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
                myLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
                myLabel.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
            ])
        
//        myLabel.frame = CGRect(
//            x: 6,
//            y: 6,
//            width: 200,
////            width: contentView.frame.size.width - 12,
//            height: contentView.frame.size.height - 6)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        configerCell()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        myLabel.text = nil
    }
    
    //    MARK: - сборка ячейки с лейбом
        func configer(text: String) {
            
            self.myLabel.text = text
            self.myLabel.textAlignment = .left
            self.myLabel.numberOfLines = 0
            
//            self.translatesAutoresizingMaskIntoConstraints = false
            self.myLabel.translatesAutoresizingMaskIntoConstraints = false
        
            //        self.setLabelFrame(label: myLabel, instets: 10)
        }
    
    //    MARK: - сборка настройки размеров и констрейнтов для лейба и картинки
     func configerCell() {

            let instets: CGFloat = 12
            let imageSize = contentView.frame.size.height - (instets / 2)
        
            self.setLabelFrame(label: self.myLabel, instets: instets, indent: imageSize)
       
     }
}
