//
//  LITestQuestionTableViewCell.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 16/06/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class LITestQuestionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var testQuestionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func refreshCellWithQuestion(_ question:NSAttributedString?) {
        self.testQuestionLabel.attributedText = question
    }

}
