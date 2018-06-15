//
//  LIExercisesViewController.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 15/06/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class LIExercisesViewController: UIViewController {
    static let exerciseCell = "exerciseCell"
    @IBOutlet weak var exerciseTableView: UITableView!
    var chapterObject:LIChapterModel?
    var exercisesArray:[LIExerciseModel]?
    var expandedCells = [Int]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpViews()
       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:- Set up views
    func setUpViews(){
        self.title = chapterObject?.chapterName
        self.exerciseTableView.estimatedRowHeight = 250.0
        self.exerciseTableView.rowHeight = UITableViewAutomaticDimension
        self.exerciseTableView.tableFooterView = UIView(frame: .zero)
        self.callGetExercisesApi()
    }
    // MARK:- IBActions
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

extension LIExercisesViewController {
    func callGetExercisesApi(){
        let parameters:[String:Any] = ["syl_id":chapterObject?.sylabusId ?? 0,
                                       "class_id":chapterObject?.classId ?? 0,
                                       "sub_id":chapterObject?.subjectId ?? 1,
                                       "chap_id":chapterObject?.chapterId ?? 0]
        ActivityIndicator.setUpActivityIndicator(baseView: self.view)
        LIUserStudentAPIsHandler.callGetExercisesAPIWith(parameters, shouldAddToken: true, success: { (response) in
            ActivityIndicator.dismissActivityView()
            if let _ = response{
                self.exercisesArray = response?.first?.exercisesArray
                self.exerciseTableView.reloadData()
                LIUtilities.setBorderColor(.gray, with: 0.5, For: self.exerciseTableView)
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

extension LIExercisesViewController:exerciseTableViewCellDelegate{
    func expandCell(_ cell: LIExerciseTableViewCell) {
        if let indexPath = self.exerciseTableView.indexPath(for: cell){
            self.expandedCells.append(indexPath.row)
            self.exerciseTableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}

extension LIExercisesViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.exercisesArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LIExercisesViewController.exerciseCell, for: indexPath) as? LIExerciseTableViewCell
        cell?.isExpanded = self.expandedCells.contains(indexPath.row)
        cell?.refreshCellWithExercise(self.exercisesArray?[indexPath.row], and: indexPath.row)
        cell?.delegate = self
        return cell!
    }
}
