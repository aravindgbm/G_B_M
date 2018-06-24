//
//  LIFinalScoreViewController.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 22/06/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit
import FLAnimatedImage
//import SAConfettiView

class LIFinalScoreViewController: UIViewController {

    @IBOutlet weak var marksContainerView: LIShadowRoundCorneredView!
    @IBOutlet weak var rightAnswerCountLabel: UILabel!
    @IBOutlet weak var wrongAnswerCountLabel: UILabel!
    
    @IBOutlet weak var skippedQuestionCountLabel: UILabel!
    
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var imageView: FLAnimatedImageView!
    @IBOutlet weak var finalScoreLabel: UILabel!
    var isFromGame:Bool = false
    var confettiView: SAConfettiView!
    
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
        self.marksContainerView.isHidden = isFromGame
        if isFromGame {
            self.finalScoreLabel.text = LIConstants.finalScore + String(LIGameManager.sharedInstance.totalScore)
        }
        
        else {
            self.rightAnswerCountLabel.text = String(LITestQuestionsDataManager.sharedInstance.rightAnswerCount)
            self.wrongAnswerCountLabel.text = String(LITestQuestionsDataManager.sharedInstance.wrongAnswerCount)
            self.skippedQuestionCountLabel.text = String(LITestQuestionsDataManager.sharedInstance.skippedQuestionCount)
            self.finalScoreLabel.text = LIConstants.finalScore + String(LITestQuestionsDataManager.sharedInstance.totalMark)
        }
        self.setUpConfetti()
    }
    
    func setUpConfetti(){
        confettiView = SAConfettiView(frame: self.view.bounds)
        
        confettiView.colors = [UIColor(red:0.95, green:0.40, blue:0.27, alpha:1.0),
                               UIColor(red:1.00, green:0.78, blue:0.36, alpha:1.0),
                               UIColor(red:0.48, green:0.78, blue:0.64, alpha:1.0),
                               UIColor(red:0.30, green:0.76, blue:0.85, alpha:1.0),
                               UIColor(red:0.58, green:0.39, blue:0.55, alpha:1.0)]
        
        confettiView.intensity = 1
        
        confettiView.type = .diamond
        
        // For custom image
        // confettiView.type = .Image(UIImage(named: "diamond")!)
        view.addSubview(confettiView)
        confettiView.startConfetti()
        self.view.bringSubview(toFront: self.finishButton)
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
