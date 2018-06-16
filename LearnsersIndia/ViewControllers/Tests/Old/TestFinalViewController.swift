//
//  TestFinalViewController.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 11/04/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class TestFinalViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    var totalScore = 0
    var totalQuestionCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.scoreLabel.text = "\(totalScore) Out Of \(totalQuestionCount)"
        
    }
    @IBAction func finishButton(_ sender: Any)
    {
       backTwo()
    }
    
    func backTwo()
    {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
