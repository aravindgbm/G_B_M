//
//  LIQuestionsViewController.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 12/06/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class LIQuestionsViewController: UIViewController {
    var questionArray:[LIQuestionsModel]?
    
//    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var questionsTableView: UITableView!
    static let questionCellIdentifier = "questionsCell"
    var isFromProfileScreen:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpViews()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.callGetRecommendedQuestionsApi()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        if self.isFromProfileScreen {
            let backBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back"), style: .plain, target: self, action:  #selector(backButtonTapped(_:)))
            self.tabBarController?.tabBar.isHidden = true
            self.navigationItem.leftBarButtonItem = backBarButtonItem
        }
        else {
            self.tabBarController?.tabBar.isHidden = false
            self.navigationController?.navigationItem.leftBarButtonItem = nil
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(LIQuestionsViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
        //        refreshControl.tintColor = UIColor.red
        
        return refreshControl
    }()
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.callGetRecommendedQuestionsApi()
        refreshControl.endRefreshing()
    }
    
    func setUpViews(){
        self.questionsTableView.estimatedRowHeight = 100.0
        self.questionsTableView.rowHeight = UITableViewAutomaticDimension
        self.questionsTableView.tableFooterView = UIView(frame: .zero)
        self.questionsTableView.addSubview(refreshControl)
    }
    //MARK:- IBactions
    @IBAction func addQuestionButtonTapped(_ sender: Any) {
        let storyBoard = UIStoryboard.init(name: LIStoryboards.Home, bundle: nil)
        let askQuestionVC = storyBoard.instantiateViewController(withIdentifier: LIViewControllerIdentifier.AskQuestionViewController) as? LIAskQuestionViewController
        self.navigationController?.pushViewController(askQuestionVC!, animated: true)
    }
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
 
     // MARK: - Navigation
    
    func navigateToAnswerScreenWith(_ question:LIQuestionsModel?){
        let storyBoard = UIStoryboard.init(name: LIStoryboards.Home, bundle: nil)
        let answerVC = storyBoard.instantiateViewController(withIdentifier: LIViewControllerIdentifier.AnswerViewController) as? LIAnswerViewController
        answerVC?.questionObject = question
        self.navigationController?.pushViewController(answerVC!, animated: true)
    }
     
        /*
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension LIQuestionsViewController:questionsTableViewCellDelegate {
    func showAnswerForQuestion(_ question: LIQuestionsModel?) {
        self.navigateToAnswerScreenWith(question)
    }
}

extension LIQuestionsViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.questionArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LIQuestionsViewController.questionCellIdentifier, for: indexPath) as? LIQuestionsTableViewCell
        cell?.refreshCellWith(self.questionArray?[indexPath.row])
        cell?.delegate = self
        return cell!
    }
}

extension LIQuestionsViewController {
    
    func callGetRecommendedQuestionsApi() {
        ActivityIndicator.setUpActivityIndicator(baseView: self.view)
        let loggedInUser = LIAccountManager.sharedInstance.getLoggedInUser()
        let paramters = ["syl_id":loggedInUser?.syllabusId ?? 0 ,   //selectedBoardID,
            "class_id":loggedInUser?.classId ?? 0,
            "sub_id":loggedInUser?.subjectId ?? 1] as [String : Any]
        LIUserStudentAPIsHandler.callGetRecommendedQuestionsAPIWith(paramters, shouldAddToken: true, success: { (response) in
            ActivityIndicator.dismissActivityView()
            if let _ = response {
                self.questionArray = response
                self.questionsTableView.reloadData()
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
