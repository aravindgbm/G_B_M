//
//  ExcerciseTableViewCell.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 10/04/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class ExcerciseTableViewCell: UITableViewCell {

    @IBOutlet weak var topicNameLabel: UILabel!
    
    @IBOutlet weak var tableview: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
