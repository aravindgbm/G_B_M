//
//  LIFeedRecommendedQuestionsTableViewCell.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 09/06/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class LIFeedRecommendedQuestionsTableViewCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    let feedQuestionsCellIdentifier = "feedQuestionsCell"
    let containerViewPadding:CGFloat = 40
    override func awakeFromNib() {
        super.awakeFromNib()
        self.containerView.dropShadowOn(true, bottom: false, with: CGSize(width: screenSize.width - containerViewPadding, height: 63))
        // Initialization code
    }
  
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
