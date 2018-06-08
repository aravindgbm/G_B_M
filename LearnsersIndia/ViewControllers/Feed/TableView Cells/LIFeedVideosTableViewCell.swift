//
//  LIFeedVideosTableViewCell.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 09/06/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class LIFeedVideosTableViewCell: UITableViewCell {

    @IBOutlet weak var feedVideosCollectionView: UICollectionView!
    @IBOutlet weak var videosHeaderTitle: UILabel!
    @IBOutlet weak var containerView: UIView!
    let collectionViewCellWidth = 200
    let collectionViewCellHeight = 150
    let feedVideosCollectionViewCellIdentifier = "feedVideosCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        feedVideosCollectionView.reloadData()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
//    feedVideosCollectionViewCell

}

extension LIFeedVideosTableViewCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: feedVideosCollectionViewCellIdentifier, for: indexPath) as? LIFeedVideosCollectionViewCell
        return cell!
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = CGSize(width: collectionViewCellWidth, height: collectionViewCellHeight)
        return cellSize
    }
    
}
