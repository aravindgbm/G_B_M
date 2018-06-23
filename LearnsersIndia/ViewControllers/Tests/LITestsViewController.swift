//
//  LITestsViewController.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 16/06/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class LITestsViewController: UIViewController {
    
    
    
    struct LITestTableViewCellIdentifiers{
        static let Question = "questionCell"
        static let Options = "optionsCell"
        static let NextQuestion = "nextQuestionCell"
        static let Solution = "solutionCell"
    }
    
    enum LITestTableViewCellType:Int{
        case LITestTableViewCellTypeQuestion
        case LITestTableViewCellTypeOptions
        case LITestTableViewCellTypeNextQuestion
        case LITestTableViewCellTypeSolution

    }
    
    enum TestTableViewCellStaticRowCount:Int {
        case TestTableViewCellStaticRowCountWithoutSolution = 2
        case TestTableViewCellStaticRowCountWithSolution = 3
    }
    
    @IBOutlet weak var testTableView: UITableView!
    @IBOutlet weak var marksLabel: UILabel!
    var testObject:LITestModel?
    var isQuestionAnswered:Bool = false
    var isLastQuestion:Bool = false
    var testTableViewCellType:LITestTableViewCellType?
    var selectedOptionRowIndex:Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        if let viewControllers = self.navigationController?.viewControllers  {
            for viewController in viewControllers{
                if viewController is LIStartTestOrGameViewController {
                    self.navigationController?.popToViewController(viewController, animated: true)
                }
            }
        }
        else {
          self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    
    //MARK: - SetUp Views
    
    func setUpView(){
        ActivityIndicator.setUpActivityIndicator(baseView: self.view)
        self.testObject?.convertHTMLStringsToAttributedStrings()
        ActivityIndicator.dismissActivityView()
        self.testTableView.estimatedRowHeight = 200.0
        self.testTableView.rowHeight = UITableViewAutomaticDimension
        if let marks = self.testObject?.markString {
            self.marksLabel.text = LIConstants.markText + marks
        }
   
//            test?.updateNextQuestionValue(self.testObject.)
//            LITestTableViewCellType.
        self.testTableView.delegate = self
        self.testTableView.dataSource = self
        self.testTableView.reloadData()
    }
    
    func updateMarksWithOption(_ option:LIAnswerOptionModel?){
         LITestQuestionsDataManager.sharedInstance.updateMarkWithSelectedOption(option, and: self.testObject?.markString)
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

extension LITestsViewController:nextQuestionCellDelegate {
    func navigateToNextScreen() {
        if let orderNumber = self.testObject?.orderNumber {
            let (testObject,islastQuestion) = LITestQuestionsDataManager.sharedInstance.getNextQuestionAndEndStatusWithCurrentOrder(orderNumber, and: self.isQuestionAnswered )
            
            if !islastQuestion && testObject != nil {
                let storyBoard = UIStoryboard.init(name: LIStoryboards.Home, bundle: nil)
                let testsVC = storyBoard.instantiateViewController(withIdentifier: LIViewControllerIdentifier.TestsViewController) as? LITestsViewController
                testsVC?.testObject = testObject
                testsVC?.isLastQuestion = islastQuestion
                self.navigationController?.pushViewController(testsVC!, animated: true)
            }
            else {
                let storyBoard = UIStoryboard.init(name: LIStoryboards.Home, bundle: nil)
                let finalScoreVC = storyBoard.instantiateViewController(withIdentifier: LIViewControllerIdentifier.FinalScoreViewController) as? LIFinalScoreViewController
                finalScoreVC?.isFromGame = false
                self.navigationController?.pushViewController(finalScoreVC!, animated: true)
            }
        }
    }
}

extension LITestsViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let optionsArrayCount = self.testObject?.optionsArray?.count ?? 0
        if self.isQuestionAnswered {
            return optionsArrayCount + TestTableViewCellStaticRowCount.TestTableViewCellStaticRowCountWithSolution.rawValue
        }
        else {
            return optionsArrayCount + TestTableViewCellStaticRowCount.TestTableViewCellStaticRowCountWithoutSolution.rawValue
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let optionsArrayCount = self.testObject?.optionsArray?.count ?? 0
        switch indexPath.row {
        case LITestTableViewCellType.LITestTableViewCellTypeQuestion.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: LITestTableViewCellIdentifiers.Question, for: indexPath) as? LITestQuestionTableViewCell
            cell?.refreshCellWithQuestion(self.testObject?.testQuestionString)
            return cell!
            
        case LITestTableViewCellType.LITestTableViewCellTypeOptions.rawValue + optionsArrayCount:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: LITestTableViewCellIdentifiers.NextQuestion, for: indexPath) as? LINextQuestionTableViewCell
            cell?.delegate = self
            return cell!
            
        case LITestTableViewCellType.LITestTableViewCellTypeNextQuestion.rawValue + optionsArrayCount:
            let cell = tableView.dequeueReusableCell(withIdentifier: LITestTableViewCellIdentifiers.Solution, for: indexPath) as? LISolutionTableViewCell
            cell?.refreshCellWith(self.testObject?.solutionString)
            return cell!
            
        default:
            if indexPath.row > LITestTableViewCellType.LITestTableViewCellTypeQuestion.rawValue && indexPath.row < LITestTableViewCellType.LITestTableViewCellTypeOptions.rawValue + optionsArrayCount {
                let cell = tableView.dequeueReusableCell(withIdentifier: LITestTableViewCellIdentifiers.Options, for: indexPath) as? LITestAnswerOptionsTableViewCell
                let optionIndex = indexPath.row - LITestTableViewCellType.LITestTableViewCellTypeOptions.rawValue
                if self.isQuestionAnswered && self.selectedOptionRowIndex == indexPath.row {
                   cell?.isSelectedOption = true
                }
                cell?.refreshCellWith(self.testObject?.optionsArray?[optionIndex], and: isQuestionAnswered)
                return cell!
            }
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let optionsArrayCount = self.testObject?.optionsArray?.count ?? 0
        if indexPath.row > LITestTableViewCellType.LITestTableViewCellTypeQuestion.rawValue && indexPath.row < LITestTableViewCellType.LITestTableViewCellTypeOptions.rawValue + optionsArrayCount && !self.isQuestionAnswered{
            self.isQuestionAnswered = true
            let optionIndex = indexPath.row - LITestTableViewCellType.LITestTableViewCellTypeOptions.rawValue
            if let count = self.testObject?.optionsArray?.count{
                if optionIndex < count {
                    self.updateMarksWithOption(self.testObject?.optionsArray?[optionIndex])
                }
            }
            self.selectedOptionRowIndex = indexPath.row
            tableView.reloadData()
        }
    }
}
