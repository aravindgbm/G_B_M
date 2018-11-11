//
//  LIChaptersViewController.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 13/06/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class LIChaptersViewController: UIViewController {
    static let chaptersCell = "chaptersCell"
    @IBOutlet weak var chaptersTableView: UITableView!
    var chapterType:LIChapterType = LIChapterType.LIChapterTypeVideos
    var chaptersArray:[LIChapterModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chaptersTableView.estimatedRowHeight = 100.0
        chaptersTableView.rowHeight = UITableViewAutomaticDimension
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.callGetChaptersApi()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
     // MARK: - Navigation
    
    func navigateToVideosViewControllerWith(_ chapter:LIChapterModel?){
        let storyBoard = UIStoryboard.init(name: LIStoryboards.Home, bundle: nil)
        let videosVC = storyBoard.instantiateViewController(withIdentifier: LIViewControllerIdentifier.VideosViewController) as? LIVideosViewController
        videosVC?.chapterObject = chapter
        self.navigationController?.pushViewController(videosVC!, animated: true)
    }
    
    func navigateToExercisesViewControllerWith(_ chapter:LIChapterModel?){
        let storyBoard = UIStoryboard.init(name: LIStoryboards.Home, bundle: nil)
        let exercisesVC = storyBoard.instantiateViewController(withIdentifier: LIViewControllerIdentifier.ExercisesViewController) as? LIExercisesViewController
        exercisesVC?.chapterObject = chapter
        self.navigationController?.pushViewController(exercisesVC!, animated: true)
    }
    
    func navigateToStartTestViewControllerWith(_ chapter:LIChapterModel?){
        let storyBoard = UIStoryboard.init(name: LIStoryboards.Home, bundle: nil)
        let startTestVC = storyBoard.instantiateViewController(withIdentifier: LIViewControllerIdentifier.StartTestOrGameViewController) as? LIStartTestOrGameViewController
        startTestVC?.chapterObject = chapter
        startTestVC?.isForGame = false
        self.navigationController?.pushViewController(startTestVC!, animated: true)
    }
  
/*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension LIChaptersViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chaptersArray?.count ?? 0
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LIChaptersViewController.chaptersCell, for: indexPath) as? LIChaptersTableViewCell
        cell?.refreshCellWith(self.chaptersArray?[indexPath.row])
//        cell?.contentView.layoutIfNeeded()
        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chapter = self.chaptersArray?[indexPath.row]
        switch self.chapterType {
        case .LIChapterTypeVideos:
            self.navigateToVideosViewControllerWith(chapter)
            break
        case .LIChapterTypeExercises:
            self.navigateToExercisesViewControllerWith(chapter)
            break
        case .LIChapterTypeTests:
            self.navigateToStartTestViewControllerWith(chapter)
            break
        }
    }
}

extension LIChaptersViewController {
    func callGetChaptersApi() {
        ActivityIndicator.setUpActivityIndicator(baseView: self.view)
        let loggedInUser = LIAccountManager.sharedInstance.getLoggedInUser()
        let paramters = ["syl_id":loggedInUser?.syllabusId ?? 0 ,   //selectedBoardID,
            "class_id":loggedInUser?.classId ?? 0,
            "sub_id":loggedInUser?.subjectId,
            "med_id":loggedInUser?.mediumId ?? 1] as [String : Any]
        LIUserStudentAPIsHandler.callGetChaptersAPIWith(paramters, shouldAddToken: true, success: { (response) in
            ActivityIndicator.dismissActivityView()
            if let _ = response {
                self.chaptersArray = response
                self.chaptersTableView.reloadData()
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
