//
//  LIFeedUtilitiesTableViewCell.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 06/06/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class LIFeedUtilitiesTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.containerView.showShadow()
        // Initialization code
    }
    @IBAction func videosButtonTapped(_ sender: Any) {
    }
    
    @IBOutlet weak var notificationButtonTapped: UIButton!
    @IBOutlet weak var testButtonTapped: UIButton!
    @IBAction func askDoubtButtonTapped(_ sender: Any) {
    }
    @IBAction func exerciseButtonTapped(_ sender: Any) {
    }
    @IBOutlet weak var gameButtonTapped: UIButton!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
