//
//  LIFeedViewController.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 06/06/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit
import AVKit
enum FeedTableviewCellTypes:Int {
    case FeedTableviewCellTypeUtilities
    case FeedTableviewCellTypePremiumDetails
    case FeedTableviewCellTypeBanner
    case FeedTableviewCellTypeVideos
    case FeedTableviewCellTypeRecommendedQuestions
}

struct LIFeedTableViewCellIdentifiers {
    static let FeedUtilitiesCell = "feedUtilitiesCell"
    static let PremiumDetailsCell = "premiumDetailsCell"
    static let FeedBannerCell = "feedBannerCell"
    static let FeedVideoCell = "feedVideosTableViewCell"
    static let FeedRecommendedQuestionsCell = "feedRecommendedQuestionsCell"
    static let FeedQuestionsCell = "feedQuestionsCell"
}


class LIFeedViewController: UIViewController {
    
    @IBOutlet weak var feedTableView: UITableView!
    var demoVideosArray:[LIVideoModel]?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = LIAccountManager.sharedInstance.getLoggedInUser()?.gradeName
        self.feedTableView.estimatedRowHeight = UITableViewAutomaticDimension
        self.feedTableView.rowHeight = UITableViewAutomaticDimension
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.callGetDemoVideosApi()
        feedTableView.reloadData()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension LIFeedViewController {
    func callGetRecommendedQuestionsApi() {
        
    }
    
    func callGetDemoVideosApi(){
        ActivityIndicator.setUpActivityIndicator(baseView: self.view)
        let loggedInUser = LIAccountManager.sharedInstance.getLoggedInUser()
        let paramters = ["syl_id":loggedInUser?.syllabusId ?? 0,   //selectedBoardID,
            "class_id":loggedInUser?.classId ?? 0,
            "sub_id":1] as [String : Any] //"sub_id":1
        LIUserStudentAPIsHandler.callGetDemoVideosAPIWith(paramters, shouldAddToken: true, success: { (response) in
            ActivityIndicator.dismissActivityView()
            if let _ = response {
                self.demoVideosArray = response
                self.feedTableView.reloadData()
            }
            else {
                LIUtilities.showErrorAlertControllerWith(LIConstants.tryAgainMessage, onViewController: self)
            }
        }, failure: { (responseMessage) in
            ActivityIndicator.dismissActivityView()
            LIUtilities.showErrorAlertControllerWith(responseMessage, onViewController: self)
        }) { (error) in
            ActivityIndicator.dismissActivityView()
            LIUtilities.showErrorAlertControllerWith(error?.localizedDescription, onViewController: self)
        }
    }
}

extension LIFeedViewController:feedVideosCellDelegate {
    func playVideoWithUrl(_ videoUrl: URL) {
        let player = AVPlayer(url: videoUrl)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player?.play()
        }
    }
}

extension LIFeedViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case FeedTableviewCellTypes.FeedTableviewCellTypeUtilities.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: LIFeedTableViewCellIdentifiers.FeedUtilitiesCell, for: indexPath) as? LIFeedUtilitiesTableViewCell
            return cell ?? UITableViewCell()
        case FeedTableviewCellTypes.FeedTableviewCellTypePremiumDetails.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: LIFeedTableViewCellIdentifiers.PremiumDetailsCell, for: indexPath) as? LIFeedPremiumDetailsTableViewCell
            cell?.refreshCell()
            return cell ?? UITableViewCell()
        case FeedTableviewCellTypes.FeedTableviewCellTypeBanner.rawValue:
        let cell = tableView.dequeueReusableCell(withIdentifier: LIFeedTableViewCellIdentifiers.FeedBannerCell, for: indexPath) as? LIFeedBannerTableViewCell
            return cell ?? UITableViewCell()
        case FeedTableviewCellTypes.FeedTableviewCellTypeVideos.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: LIFeedTableViewCellIdentifiers.FeedVideoCell, for: indexPath) as? LIFeedVideosTableViewCell
            cell?.refreshCellWith(self.demoVideosArray)
            cell?.delegate = self
            return cell ?? UITableViewCell()
        case FeedTableviewCellTypes.FeedTableviewCellTypeRecommendedQuestions.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: LIFeedTableViewCellIdentifiers.FeedRecommendedQuestionsCell, for: indexPath) as? LIFeedRecommendedQuestionsTableViewCell
            return cell ?? UITableViewCell()
        default:
            if indexPath.row > FeedTableviewCellTypes.FeedTableviewCellTypeRecommendedQuestions.rawValue {
                let cell = tableView.dequeueReusableCell(withIdentifier: LIFeedTableViewCellIdentifiers.FeedQuestionsCell, for: indexPath) as? LIFeedQuestionsTableViewCell
                return cell!
            }
            return UITableViewCell()
        }
      
    }
}
