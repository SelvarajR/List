//
//  ListCell.swift
//  Listview
//
//  Created by Selvaraj R on 18/11/21.
//

import UIKit

class ListCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let marginGuide = contentView.layoutMarginsGuide
        
        /* Initializing Cell elements */
        title = UILabel.init()
        title.textColor = .blue
        contentView.addSubview(title)
        
        descriptionText = UILabel.init()
        descriptionText.textColor = .gray
        contentView.addSubview(descriptionText)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        title.topAnchor.constraint(equalTo: marginGuide.topAnchor, constant: 1).isActive = true
        title.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        title.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        title.numberOfLines = 1
        
        descriptionText.translatesAutoresizingMaskIntoConstraints = false
        descriptionText.topAnchor.constraint(equalTo: title.topAnchor, constant: 20).isActive = true
        descriptionText.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        descriptionText.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        descriptionText.numberOfLines = 2
        
        
        contentView.addConstraints(title.constraints)
        
        contentView.addConstraints(descriptionText.constraints)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var title: UILabel!
    var descriptionText: UILabel!
    
}
