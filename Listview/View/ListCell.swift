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
        
        /* Initializing Cell elements */
        avatar = UIImageView.init()
        avatar.layer.borderWidth = 1
        avatar.layer.borderColor = UIColor.lightGray.cgColor
        contentView.addSubview(avatar)
        
        title = UILabel.init()
        contentView.addSubview(title)
        
        descriptionText = UILabel.init()
        descriptionText.textColor = .gray
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
                    })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var title: UILabel!
    var descriptionText: UILabel!
    var avatar: UIImageView!
    
}
