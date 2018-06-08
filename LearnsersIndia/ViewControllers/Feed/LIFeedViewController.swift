//
//  LIFeedViewController.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 06/06/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Class 8"
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
