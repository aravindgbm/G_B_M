//
//  LIFeedVideosCollectionViewCell.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 09/06/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class LIFeedVideosCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgVideoThumbnail: UIImageView!
    @IBOutlet weak var videoTitleLabel: UILabel!
    var videoObject:LIVideoModel?
    
    func refreshCellWith(_ video:LIVideoModel?) {
        self.videoObject = video
        self.videoTitleLabel.text = self.videoObject?.videoTitle
        self.imgVideoThumbnail.setImageWith(self.videoObject?.videoThumbnailUrl, and: nil)
    }
}
