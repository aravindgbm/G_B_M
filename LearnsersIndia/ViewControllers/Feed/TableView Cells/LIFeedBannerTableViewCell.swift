//
//  LIBannerTableViewCell.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 07/06/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class LIFeedBannerTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.containerView.dropShadowOnAllSideWithSize(CGSize(width: screenSize.width - 40, height: self.containerView.frame.size.height))
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func shareButtonTapped(_ sender: Any) {
    }
    
}
