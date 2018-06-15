//
//  LIExerciseTableViewCell.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 16/06/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit
import WebKit
protocol exerciseTableViewCellDelegate:class {
    func expandCell(_ cell:LIExerciseTableViewCell)
}

class LIExerciseTableViewCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var exerciseLabel: UILabel!
    @IBOutlet weak var exerciseTextView: UITextView!
    
    @IBOutlet weak var viewSolutionButton: UIButton!
//    @IBOutlet weak var exerciseWebvView: WKWebView!
    @IBOutlet weak var exerciseHeadingLabel: UILabel!
    
    var delegate:exerciseTableViewCellDelegate?
    
    var isExpanded:Bool = false
    var exerciseObject:LIExerciseModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func viewSolutionButtonTapped(_ sender: Any) {
//        self.isExpanded = true
        self.viewSolutionButton.isHidden = true
        self.delegate?.expandCell(self)
    }
    func refreshCellWithExercise(_ exercise:LIExerciseModel?, and exerciseIndex:Int){
        self.exerciseObject = exercise
        let bgColor = exerciseIndex % 2 == 0 ? UIColor(hexString: LIColors.exerciseEvenIndexBgColor) : UIColor(hexString: LIColors.exerciseOddIndexBgColor).withAlphaComponent(LIColors.lighterAlpha)
        self.containerView.backgroundColor =  bgColor
        if !self.isExpanded {
//            self.exerciseTextView.attributedText = self.exerciseObject?.exerciseTitle
            self.exerciseLabel.attributedText = self.exerciseObject?.exerciseTitle
            self.viewSolutionButton.isHidden = false
        }
        else {
            let exerciseString = NSMutableAttributedString()
            if let exerciseTitle = self.exerciseObject?.exerciseTitle{
                 exerciseString.append(exerciseTitle)
            }
           
            if let exerciseSolution = self.exerciseObject?.exerciseSolution {
                exerciseString.append(exerciseSolution)
            }
//            self.exerciseWebvView.loadHTMLString(exerciseHTMLString, baseURL: nil)
             self.exerciseLabel.attributedText = exerciseString
            self.viewSolutionButton.isHidden = true
//            self.exerciseTextView.attributedText = exerciseString
        }
        self.exerciseHeadingLabel.text = "\(LIConstants.exerciseHeader)\(exerciseIndex + 1)"
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
