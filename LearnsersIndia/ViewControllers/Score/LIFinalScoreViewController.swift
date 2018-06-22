//
//  LIFinalScoreViewController.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 22/06/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit
import FLAnimatedImage

class LIFinalScoreViewController: UIViewController {

    @IBOutlet weak var rightAnswerCountLabel: UILabel!
    @IBOutlet weak var wrongAnswerCountLabel: UILabel!
    
    @IBOutlet weak var skippedQuestionCountLabel: UILabel!
    
    @IBOutlet weak var imageView: FLAnimatedImageView!
    @IBOutlet weak var finalScoreLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpViews()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func finishButtonTapped(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    //MARK: - SetUp Views
    
    func setUpViews(){
         self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.rightAnswerCountLabel.text = String(LITestQuestionsDataManager.sharedInstance.rightAnswerCount)
        self.wrongAnswerCountLabel.text = String(LITestQuestionsDataManager.sharedInstance.wrongAnswerCount)
        self.skippedQuestionCountLabel.text = String(LITestQuestionsDataManager.sharedInstance.skippedQuestionCount)
        self.finalScoreLabel.text = LIConstants.finalScore + String(LITestQuestionsDataManager.sharedInstance.totalMark)
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
