//
//  LIGameAnswerOptionsTableViewCell.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 23/06/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class LIGameAnswerOptionsTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var optionLabel: UILabel!
    var optionObject:LIAnswerOptionModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func refreshCellWith(_ option:LIAnswerOptionModel?, isQuestionAnswered:Bool, isSelectedOption:Bool, and isExtraLifeTaken:Bool) {
        self.optionObject = option
        self.optionLabel.attributedText = option?.optionString
        if isQuestionAnswered {
            if self.optionObject?.isCorrectOption ?? false{
                self.containerView.backgroundColor = UIColor.green
            }
            if isSelectedOption {
                if !(self.optionObject?.isCorrectOption ?? false) {
                    self.containerView.backgroundColor = UIColor.orange
                }
            }
            else if (!isSelectedOption && isExtraLifeTaken) {
                if self.optionObject?.isCorrectOption ?? false{
                    self.containerView.backgroundColor = UIColor.white
                }
            }
        }
        else {
             self.containerView.backgroundColor = UIColor.white
        }
    }

}
