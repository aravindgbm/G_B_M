//
//  YourBoardTableViewCell.swift
//  LearnsersIndia
//
//  Created by macbook on 12/03/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class YourBoardTableViewCell: UITableViewCell {
    @IBOutlet var label: UILabel!
    
    @IBOutlet var imageview: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
