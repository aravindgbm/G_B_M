//
//  LIQuestionsTableViewCell.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 12/06/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class LIQuestionsTableViewCell: UITableViewCell {
    @IBOutlet weak var userProfilePic: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var answerCountDetailsLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionTimestampLabel: UILabel!
    var questionModel:LIQuestionsModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func refreshCellWith(_ question:LIQuestionsModel?){
        self.questionModel = question
        self.userNameLabel.text = self.questionModel?.studentName
        self.questionLabel.attributedText = self.questionModel?.questionTitle
        self.userProfilePic.setImageWith(self.questionModel?.studentProfilPicUrl, and: nil)
        self.userNameLabel.text = self.questionModel?.studentName
        self.questionTimestampLabel.text = LIUtilities.getQuestionAskedTextWith(self.questionModel?.subjectName, timestamp: self.questionModel?.questionTimeStamp)
        self.moreButton.isHidden = self.questionModel?.totalAnswerCount != nil && (self.questionModel?.totalAnswerCount)! > 0 ? false : true
    }
    @IBAction func moreButtonTapped(_ sender: Any) {
        
    }
    
}
