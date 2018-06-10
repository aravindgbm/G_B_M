//
//  LIFeedVideosTableViewCell.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 09/06/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

protocol feedVideosCellDelegate:class {
    func playVideoWithUrl(_ videoUrl:URL)
}

class LIFeedVideosTableViewCell: UITableViewCell {

    @IBOutlet weak var feedVideosCollectionView: UICollectionView!
    @IBOutlet weak var videosHeaderTitle: UILabel!
    @IBOutlet weak var containerView: UIView!
    let collectionViewCellWidth = 200
    let collectionViewCellHeight = 150
    let feedVideosCollectionViewCellIdentifier = "feedVideosCollectionViewCell"
    var videoArray:[LIVideoModel]?
    weak var delegate:feedVideosCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        feedVideosCollectionView.reloadData()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func refreshCellWith(_ videos:[LIVideoModel]?){
        self.videoArray = videos
        self.feedVideosCollectionView.reloadData()
    }
//    feedVideosCollectionViewCell

}

extension LIFeedVideosTableViewCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    //MARK:- CollectionView Datasource and Delegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.videoArray?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: feedVideosCollectionViewCellIdentifier, for: indexPath) as? LIFeedVideosCollectionViewCell
        cell?.refreshCellWith(self.videoArray?[indexPath.row])
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        if let videoUrlString = self.videoArray?[indexPath.row].videoPrivateUrl{
            if let videoUrl = URL(string: videoUrlString){
                self.delegate?.playVideoWithUrl(videoUrl)
            }
        }
    }
    
    //MARK:- CollectionViewDelegateFlow Layout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = CGSize(width: collectionViewCellWidth, height: collectionViewCellHeight)
        return cellSize
    }
    
}
