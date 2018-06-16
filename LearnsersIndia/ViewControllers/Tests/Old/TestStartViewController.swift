//
//  TestStartViewController.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 11/04/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class TestStartViewController: UIViewController {
    
    var selectedChapterId = Int()
    var selectedChapterName = String()
    
    @IBOutlet weak var chapternameLabel: UILabel!
    @IBOutlet weak var noOfQuestnsLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.chapternameLabel.text = selectedChapterName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButton(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
        // self.dismiss(animated: true, completion: nil)
    }

    
    @IBAction func startButton(_ sender: Any)
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "TestPaperViewController") as! TestPaperViewController
        vc.selectedChapterId = self.selectedChapterId
        self.navigationController?.pushViewController(vc, animated: true)
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
