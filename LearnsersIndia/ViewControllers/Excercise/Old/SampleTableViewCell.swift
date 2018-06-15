//
//  SampleTableViewCell.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 10/04/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class SampleTableViewCell: UITableViewCell {

    @IBOutlet weak var questnNoLabel: UILabel!
    @IBOutlet weak var solutionLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var viewSolutionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
