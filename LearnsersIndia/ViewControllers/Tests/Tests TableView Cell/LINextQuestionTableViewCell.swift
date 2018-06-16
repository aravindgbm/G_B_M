//
//  LINextQuestionTableViewCell.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 16/06/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

protocol nextQuestionCellDelegate:class {
    func navigateToNextScreen()
}

class LINextQuestionTableViewCell: UITableViewCell {

    @IBOutlet weak var nextButton: UIButton!
    weak var delegate:nextQuestionCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func nextButtonTapped(_ sender: Any) {
        delegate?.navigateToNextScreen()
    }
    
}
