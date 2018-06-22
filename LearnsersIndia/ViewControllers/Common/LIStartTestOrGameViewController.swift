//
//  LIStartTestOrGameViewController.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 16/06/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class LIStartTestOrGameViewController: UIViewController {

    @IBOutlet weak var instructionsHeadingLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var chapterNameLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    var testQuestionsArray:[LITestModel]?
    var isForGame:Bool = true
    var chapterObject:LIChapterModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func startButtonTapped(_ sender: Any) {
        
        if self.isForGame {
            
        }
        else {
            self.callGetTestQuestionsApi()
        }
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        if self.isForGame {
            LIUtilities.showQuitGameALertOnViewController(self)
        }
        else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    // MARK:- SetUpView
    
    func setUpView(){
        self.title = self.isForGame ? LIConstants.titleGame : LIConstants.titleTest
        self.chapterNameLabel.isHidden = self.isForGame
        self.logoImageView.isHidden = !self.isForGame
        self.instructionsHeadingLabel.text = self.isForGame ? LIConstants.instructionGame : LIConstants.instructionTest
        LIUtilities.setBorderColor(.white, For: self.startButton)
    }
    

    // MARK: - Navigation
    
    func navigateToTestViewController(){
        let storyBoard = UIStoryboard.init(name: LIStoryboards.Home, bundle: nil)
        let testsVC = storyBoard.instantiateViewController(withIdentifier: LIViewControllerIdentifier.TestsViewController) as? LITestsViewController
        testsVC?.testObject = self.testQuestionsArray?.first
        testsVC?.isLastQuestion = false
        self.navigationController?.pushViewController(testsVC!, animated: true)
//        if let orderNumber = self.testQuestionsArray?.first?.orderNumber {
//            let (testObject,islastQuestion) = LITestQuestionsDataManager.sharedInstance.getNextQuestionAndEndStatusWithCurrentOrder(orderNumber)
//            testsVC?.testObject = testObject
//            testsVC?.isLastQuestion = islastQuestion
//            self.navigationController?.pushViewController(testsVC!, animated: true)
//        }
        
    }
    
     
     /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension LIStartTestOrGameViewController{
    func callGetTestQuestionsApi(){
        ActivityIndicator.setUpActivityIndicator(baseView: self.view)
        let parameters:[String:Any] = ["syl_id":chapterObject?.sylabusId ?? 0,
                                       "class_id":chapterObject?.classId ?? 0,
                                       "sub_id":chapterObject?.subjectId ?? 1,
                                       "chap_id":chapterObject?.chapterId ?? 0]
        LIUserStudentAPIsHandler.callGetTestQuestionsAPIWith(parameters, shouldAddToken: true, success: { (response) in
            
            ActivityIndicator.dismissActivityView()
            if let  _ = response {
                self.testQuestionsArray = [LITestModel]()
                self.testQuestionsArray = response?.sorted(by:{ $0.orderNumber! < $1.orderNumber!})
                LITestQuestionsDataManager.sharedInstance.testQuestionsArray = self.testQuestionsArray
                LITestQuestionsDataManager.sharedInstance.resetMarks()
                self.navigateToTestViewController()
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
