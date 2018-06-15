//
//  LIVideosViewController.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 13/06/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class LIVideosViewController: UIViewController {
    var chapterObject:LIChapterModel?
    

    @IBOutlet weak var videosTableView: UITableView!
    
//    @IBOutlet weak var title: UINavigationItem!
    var topicsArray:[LITopicModel]?
    static let videoCell = "videosTableViewCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callGetVideosApi()
        self.title = chapterObject?.chapterName
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }

    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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

extension LIVideosViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.topicsArray?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LIVideosViewController.videoCell, for: indexPath) as? LIVideosTableViewCell
        cell?.refreshCellWith(self.topicsArray?[indexPath.row].videoArray, and: self.topicsArray?[indexPath.row].topicName)
//        cell?.refreshCellWith(self.topicsArray?[indexPath.row].videoArray)
        cell?.delegate = self
        return cell!
        
    }
}

extension LIVideosViewController:videosTableViewCellDelegate {
    func playVideoWithObject(_ videoObject: LIVideoModel?) {
        LIUtilities.playVideoWithObject(videoObject, on: self)
    }
}

extension LIVideosViewController {
    func callGetVideosApi(){
        ActivityIndicator.setUpActivityIndicator(baseView: self.view)
        let parameters:[String:Any] = ["syl_id":chapterObject?.sylabusId ?? 0,
                          "class_id":chapterObject?.classId ?? 0,
                          "sub_id":chapterObject?.subjectId ?? 1,
                          "chap_id":chapterObject?.chapterId ?? 0]
        LIUserStudentAPIsHandler.callGetVideosAPIWith(parameters, shouldAddToken: true, success: { (response) in
            ActivityIndicator.dismissActivityView()
            if let _ = response {
                self.topicsArray = response
                self.videosTableView.reloadData()
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

