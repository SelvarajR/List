//
//  ListCell.swift
//  Listview
//
//  Created by Selvaraj R on 18/11/21.
//

import UIKit
import SnapKit
import Kingfisher

/* table cell UI elements declarations */
class ListCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let fontHelvetica = UIFont(name: constant.fontName, size: 15)!
        
        /* Initializing Cell elements */
        avatar = UIImageView()
        contentView.addSubview(avatar)
        
        title = UILabel()
        title.font = fontHelvetica
        contentView.addSubview(title)
        
        descriptionText = UILabel()
        descriptionText.font = fontHelvetica
        descriptionText.textColor = .gray
        descriptionText.lineBreakMode = .byWordWrapping
        descriptionText.sizeToFit()
        descriptionText.numberOfLines = 0
        descriptionText.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(descriptionText)
        
        self.setConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /* Download and cache the images using Kingfisher lib */
    var cellViewModel: ListCellViewModel? {
        didSet {
            title.text = cellViewModel?.cellTitle
            descriptionText.text = cellViewModel?.cellDesc
            avatar.kf.setImage(with: URL(string: cellViewModel?.cellImag ?? ""), placeholder: UIImage(named: constant.placeHolderImage))
        }
    }
    
    private let constant = Constants()
    var title: UILabel!
    var descriptionText: UILabel!
    var avatar: UIImageView!
}

extension ListCell {
    
    /* Constrains to UI elements from SnapKit lib */
    func setConstrains() {
        avatar.snp.makeConstraints({ make in
            make.size.equalTo(CGSize(width: 100, height: 100))
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
            make.bottom.lessThanOrEqualToSuperview().offset(-10)
        })
        title.snp.makeConstraints({ make in
            make.top.equalTo(avatar.snp.top)
            make.left.equalTo(avatar.snp.right).offset(10)
            make.right.equalToSuperview().offset(-10)
        })
        descriptionText.snp.makeConstraints({ make in
            make.top.equalTo(title.snp.bottom).offset(10)
            make.left.equalTo(avatar.snp.right).offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.lessThanOrEqualToSuperview().offset(-10)
        })
    }
}
