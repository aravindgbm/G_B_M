//
//  LIFeedQuestionsTableViewCell.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 09/06/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class LIFeedQuestionsTableViewCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var answerDetailsLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    var delegate:questionsTableViewCellDelegate?
    var questionModel:LIQuestionsModel?
    let containerViewPadding:CGFloat = 40
    override func awakeFromNib() {
        super.awakeFromNib()
        self.containerView.dropShadowOn(false, bottom: false, with: CGSize(width: screenSize.width - containerViewPadding, height: self.containerView.frame.size.height - 5))
        // Initialization code
    }
    func refreshCellWith(_ question:LIQuestionsModel?){
        self.questionModel = question
        self.questionLabel.attributedText = self.questionModel?.questionTitle
        self.userImage.setImageWith(self.questionModel?.studentProfilPicUrl, and: nil)
        self.userNameLabel.text = self.questionModel?.studentName
        self.timeStampLabel.text = LIUtilities.getQuestionAskedTextWith(self.questionModel?.subjectName, timestamp: self.questionModel?.questionTimeStamp)
        self.moreButton.isHidden = self.questionModel?.totalAnswerCount != nil && (self.questionModel?.totalAnswerCount)! > 0 ? false : true
        self.answerDetailsLabel.text = LIUtilities.getAnswerCountLabelTextWith(self.questionModel?.totalAnswerCount)
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func moreButtonTapped(_ sender: Any) {
        self.delegate?.showAnswerForQuestion(self.questionModel)
    }

}
