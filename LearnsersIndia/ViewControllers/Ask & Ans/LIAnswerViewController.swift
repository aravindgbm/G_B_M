//
//  LIAnswerViewController.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 24/06/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class LIAnswerViewController: UIViewController {
    @IBOutlet weak var answerTableView: UITableView!
    var questionObject:LIQuestionsModel?
    var answerArray:[LIAnswerModel]?
    struct LIAnswerTableViewCellIdentifiers {
        static let Question = "questionHeaderCell"
        static let Answer = "answerCell"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callGetAnswerApi()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Set up Views
    
    func setUpViews(){
        self.answerTableView.estimatedRowHeight = 100
        self.answerTableView.rowHeight = UITableViewAutomaticDimension
        self.answerTableView.estimatedSectionHeaderHeight = 50
        self.answerTableView.sectionHeaderHeight = UITableViewAutomaticDimension
        self.answerTableView.delegate = self
        self.answerTableView.dataSource = self
        self.answerTableView.reloadData()
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
extension LIAnswerViewController:UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let _ = self.questionObject {
            return 1
        }
        return 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.answerArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: LIAnswerTableViewCellIdentifiers.Question) as? LIQuestionHeaderTableViewCell
        cell?.refreshCellWith(self.questionObject?.questionTitle)
        return cell
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LIAnswerTableViewCellIdentifiers.Answer, for: indexPath) as? LIAnswerTableViewCell
        cell?.refreshCellWith(self.answerArray?[indexPath.row])
        return cell!
    }
}
extension LIAnswerViewController {
    func callGetAnswerApi(){
        ActivityIndicator.setUpActivityIndicator(baseView: self.view)
        let parameters:[String:Any] = ["qstn_id":self.questionObject?.questionId ?? 0]
        LIUserStudentAPIsHandler.callGetAllAnswersAPIWith(parameters, shouldAddToken: false, success: { (response) in
            ActivityIndicator.dismissActivityView()
            if let _ = response {
                self.answerArray = response
                self.setUpViews()
            }
            else {
                
                LIUtilities.showErrorAlertControllerWith(LIConstants.tryAgainMessage, onViewController: self)
            }
          
   
        }, failure: { (responseMessage) in
            ActivityIndicator.dismissActivityView()
            LIUtilities.showErrorAlertControllerWith(responseMessage, onViewController: self)
        }) { (error) in
            ActivityIndicator.dismissActivityView()
            LIUtilities.showErrorAlertControllerWith(error?.localizedDescription, onViewController:self)
        }
    }
}
