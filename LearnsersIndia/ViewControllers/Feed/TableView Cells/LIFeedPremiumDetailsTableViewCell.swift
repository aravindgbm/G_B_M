//
//  LIFeedPremiumDetailsTableViewCell.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 07/06/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class LIFeedPremiumDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var premiumDetailsLabel: UILabel!
    @IBOutlet weak var tryPremiumButton: UIButton!
    let paidUserlabelText = "You are a premium member"
    let unpaidUserlabelText = "Unlock the rest of the list with premium"
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.containerView.dropShadowOnAllSideWithSize(CGSize(width: screenSize.width - 40, height: self.containerView.frame.size.height))
        // Initialization code
    }
    func refreshCell() {
        let isPaidUser = LIAccountManager.sharedInstance.getLoggedInUser()?.isPaidUser
        self.tryPremiumButton.isHidden = isPaidUser ?? false
        self.premiumDetailsLabel.text = isPaidUser != nil && isPaidUser == true ? self.paidUserlabelText : self.unpaidUserlabelText
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func tryPremiumButtonTapped(_ sender: Any) {
    }
    
}
