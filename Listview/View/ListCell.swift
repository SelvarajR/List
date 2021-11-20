//
//  ListCell.swift
//  Listview
//
//  Created by Selvaraj R on 18/11/21.
//

import UIKit
import SnapKit
import Kingfisher

class ListCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let myFont: UIFont = UIFont.init(name: constant.fontName, size: 15)!
        
        /* Initializing Cell elements */
        avatar = UIImageView.init()
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
            make.size.equalTo(CGSize(width: 100, height: 100))
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
            make.bottom.lessThanOrEqualToSuperview().offset(-10)
        })
        
        title.snp.makeConstraints({ (make) in
            make.top.equalTo(avatar.snp.top)
            make.left.equalTo(avatar.snp.right).offset(10)
            make.right.equalToSuperview().offset(-10)
                    })

        descriptionText.snp.makeConstraints({ (make) in
            make.top.equalTo(title.snp.bottom).offset(10)
            make.left.equalTo(avatar.snp.right).offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.lessThanOrEqualToSuperview().offset(-10)
                    })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var cellViewModel: ListCellViewModel? {
        didSet {
            title.text = cellViewModel?.cell_title
            descriptionText.text = cellViewModel?.cell_desc
            avatar.kf.setImage(with: URL(string: cellViewModel?.cell_imag ?? ""), placeholder: UIImage(named: constant.placeHolderImage))
        }
    }
    
    private let constant = Constants()
    var title: UILabel!
    var descriptionText: UILabel!
    var avatar: UIImageView!
    
}
