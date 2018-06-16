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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
