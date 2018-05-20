//
//  TestPaperTableViewCell.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 11/04/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class TestPaperTableViewCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageview: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
