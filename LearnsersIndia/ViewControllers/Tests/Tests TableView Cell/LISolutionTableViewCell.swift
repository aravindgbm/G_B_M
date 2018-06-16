//
//  LISolutionTableViewCell.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 16/06/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class LISolutionTableViewCell: UITableViewCell {

    @IBOutlet weak var solutionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func refreshCellWith(_ solution:NSAttributedString?){
        self.solutionLabel.attributedText = solution
    }
}
