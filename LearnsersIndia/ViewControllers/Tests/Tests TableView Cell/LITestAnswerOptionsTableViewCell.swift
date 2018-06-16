//
//  LITestAnswerOptionsTableViewCell.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 16/06/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class LITestAnswerOptionsTableViewCell: UITableViewCell {
    @IBOutlet weak var optionStatusImageView: UIImageView!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var optionLabel: UILabel!
    var isSelectedOption:Bool?
    var optionObject:LIAnswerOptionModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func refreshCellWith(_ option:LIAnswerOptionModel?,and isQuestionAnswered:Bool){
        self.optionObject = option
        self.optionLabel.attributedText = self.optionObject?.optionString
        self.optionStatusImageView.image = self.optionObject?.isCorrectOption ?? false ? #imageLiteral(resourceName: "answer_correct") : nil
        self.optionStatusImageView.isHidden = !isQuestionAnswered
        if let selected = self.isSelectedOption {
            if selected {
                self.optionStatusImageView.image = self.optionObject?.isCorrectOption ?? false ? #imageLiteral(resourceName: "answer_correct") : #imageLiteral(resourceName: "answer_wrong")
                self.optionStatusImageView.isHidden = false
            }
        }
    }
    
    

}
