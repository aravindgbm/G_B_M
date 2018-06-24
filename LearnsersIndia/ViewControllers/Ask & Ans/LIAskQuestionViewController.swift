//
//  LIAskQuestionViewController.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 24/06/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class LIAskQuestionViewController: UIViewController {


    @IBOutlet weak var askQuestionTextView: UITextView!
    static let minLetterCountForQuestion = 5
  
    static let questionTitle = "Mathematics" // Api values need to be changed to dynamic after the
    static let chapterId = 1                 // backend is ready
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpViews()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- SetUp Views
    
    func setUpViews(){
        self.askQuestionTextView.placeholder = LIConstants.askQuestionPlaceholder
        self.title = LIConstants.askQuestionPlaceholder
    }
    
    func validateQuestion() -> Bool {
     
        if (self.askQuestionTextView.text.trimmingCharacters(in: .whitespacesAndNewlines).count < LIAskQuestionViewController.minLetterCountForQuestion) {
            return false
        }
        return true
    }
    // MARK:- IBActions
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        if self.validateQuestion() {
            self.callAskQuestionApi()
        }
        else {
            LIUtilities.showOkAlertControllerWith(nil, message: LIConstants.enterValidQuestionMessage, onViewController: self)
        }
    }
    // MARK: - Navigation
    func navigateToHomeScreen(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    /*

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension LIAskQuestionViewController {
    func callAskQuestionApi(){
        //TODO: change hardcoded values
        ActivityIndicator.setUpActivityIndicator(baseView: self.view)
        let loggedInUser = LIAccountManager.sharedInstance.getLoggedInUser()
        let parameters:[String:Any] = ["syl_id":loggedInUser?.syllabusId ?? 0,
                                       "class_id":loggedInUser?.classId ?? 0,
                                       "sub_id":loggedInUser?.subjectId ?? 1,
                                       "chap_id":LIAskQuestionViewController.chapterId,
                                       "q_title":LIAskQuestionViewController.questionTitle,
                                       "q_details":self.askQuestionTextView.text]
        LIUserStudentAPIsHandler.callAskQuestionAPIWith(parameters, shouldAddToken: true, success: { (success) in
            ActivityIndicator.dismissActivityView()
            if success {
                LIUtilities.showOkAlertControllerWith(LIConstants.successAlertTitle, message: LIConstants.questionPostedMessage, onViewController: self, with: { (action) in
                    self.navigateToHomeScreen()
                })
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
