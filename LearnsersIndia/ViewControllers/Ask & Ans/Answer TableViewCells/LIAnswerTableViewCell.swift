//
//  LIAnswerTableViewCell.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 24/06/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class LIAnswerTableViewCell: UITableViewCell {

    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var answerTimeStampLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    var answerObject:LIAnswerModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func refreshCellWith(_ answer:LIAnswerModel?){
        self.answerObject = answer
        self.userProfileImageView.setImageWith(self.answerObject?.userProfilPicUrl, and: #imageLiteral(resourceName: "character_white_bg"))
        self.userNameLabel.text = self.answerObject?.userName
        self.answerLabel.text = self.answerObject?.answer
        self.answerTimeStampLabel.text = LIUtilities.getAnsweredTextWith(self.answerObject?.answerTimeStamp)
    }
}
