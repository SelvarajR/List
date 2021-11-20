//
//  ListCell.swift
//  Listview
//
//  Created by Selvaraj R on 18/11/21.
//

import UIKit
import SnapKit

class ListCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let myFont: UIFont = UIFont.init(name: constant.fontName, size: 13)!
        
        /* Initializing Cell elements */
        avatar = UIImageView.init()
        avatar.layer.borderWidth = 1
        avatar.layer.borderColor = UIColor.lightGray.cgColor
        contentView.addSubview(avatar)
        
        title = UILabel.init()
        title.font = myFont
        contentView.addSubview(title)
        
        descriptionText = UILabel.init()
        descriptionText.font = myFont
        descriptionText.textColor = .gray
        descriptionText.lineBreakMode = .byWordWrapping
        descriptionText.sizeToFit()
        descriptionText.numberOfLines = 0
        descriptionText.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(descriptionText)
        
        self.setConstrains()
    }
    
    func setConstrains() {
        avatar.snp.makeConstraints({ (make) in
            make.size.equalTo(CGSize(width: 50, height: 50))
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
        })
        
        title.snp.makeConstraints({ (make) in
            make.top.equalTo(avatar.snp.top)
            make.left.equalTo(avatar.snp.right).offset(10)
            make.right.equalToSuperview()
                    })

        descriptionText.snp.makeConstraints({ (make) in
            make.top.equalTo(title.snp.bottom).offset(10)
            make.left.equalTo(avatar.snp.right).offset(10)
            make.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
                    })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var title: UILabel!
    var descriptionText: UILabel!
    var avatar: UIImageView!
    private let constant = Constants()
}
