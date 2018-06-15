//
//  LIChaptersTableViewCell.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 13/06/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class LIChaptersTableViewCell: UITableViewCell {
    @IBOutlet weak var chapterNameLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    //    @IBOutlet weak var chapterIconImageView: UIImageView!
    var chapterObject:LIChapterModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func refreshCellWith(_ chapter:LIChapterModel?){
        self.chapterObject = chapter
        self.chapterNameLabel.text = self.chapterObject?.chapterName
        LIUtilities.setBorderColor(.gray, with: 0.5, For: self.containerView)
        
    }
    

}
