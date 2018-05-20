//
//  RecomentedQuestionsTableViewCell.swift
//  LearnsersIndia
//
//  Created by macbook on 31/03/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class RecomentedQuestionsTableViewCell: UITableViewCell {

    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var moreLabel: UILabel!
    @IBOutlet weak var morebuttn: UIButton!
    @IBOutlet weak var profileImageView: StandardImageView!
    @IBOutlet weak var answerCountLabel: UILabel!
    @IBOutlet weak var questionsLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
