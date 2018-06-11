//
//  LIProfileTableViewCell.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 11/06/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class LIProfileTableViewCell: UITableViewCell {
    var profileItem:LIProfileItem?
   
    @IBOutlet weak var profileItemTitleLabel: UILabel!
    @IBOutlet weak var profileItemImageView: UIImageView!
    
    @IBOutlet weak var separatorView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func refreshCellWith(_ item:LIProfileItem?){
        self.profileItem = item
        self.profileItemImageView.image = self.profileItem?.itemIcon
        self.profileItemTitleLabel.text = self.profileItem?.itemTitle
        self.separatorView.isHidden = self.profileItem?.profileItemType == LIProfileItemType.LIProfileItemTypeLogout
        self.profileItemTitleLabel.textColor = self.profileItem?.profileItemType == LIProfileItemType.LIProfileItemTypeLogout ? UIColor(hexString: LIColors.LogoutLabelTextColor) : UIColor.black
        
    }
}
