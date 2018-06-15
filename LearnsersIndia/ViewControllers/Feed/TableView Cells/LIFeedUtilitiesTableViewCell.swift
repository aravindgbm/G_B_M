//
//  LIFeedUtilitiesTableViewCell.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 06/06/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit
protocol feedUtilitiesTableViewCellDelegate:class {
    func navigateToChaptersViewControlerWith(_ chapterType:LIChapterType)
}
class LIFeedUtilitiesTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    weak var delegate:feedUtilitiesTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.containerView.dropShadowOnAllSideWithSize(CGSize(width: screenSize.width - 40, height: self.containerView.frame.size.height))
        // Initialization code
    }
    @IBAction func videosButtonTapped(_ sender: Any) {
        self.delegate?.navigateToChaptersViewControlerWith(.LIChapterTypeVideos)
    }
  
    
    @IBAction func notificationButtonTapped(_ sender: Any) {
    }
    
    @IBAction func testButtonTapped(_ sender: Any) {
        //TODO:- uncomment this
//         self.delegate?.navigateToChaptersViewControlerWith(.LIChapterTypeTests)
    }
    
    @IBAction func askDoubtButtonTapped(_ sender: Any) {
    }
    @IBAction func exerciseButtonTapped(_ sender: Any) {
        //TODO:- uncomment this
//        self.delegate?.navigateToChaptersViewControlerWith(.LIChapterTypeExercises)
    }
  
    @IBAction func gameButtonTapped(_ sender: Any) {
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
