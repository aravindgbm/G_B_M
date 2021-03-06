//
//  SplashViewController.swift
//  LearnsersIndia
//
//  Created by Appzoc-Macmini on 13/03/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
         setupTimer()
    }
    
    func setupTimer()
    {
        // Timer
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { (_) in
            
            
            // Check new user or existing user
            if UserDefaults.standard.object(forKey: "LoggedIn") == nil
            {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "TutorialScreenViewController") as! TutorialScreenViewController
                self.present(vc, animated: true, completion: nil)
            }
            else if UserDefaults.standard.bool(forKey: "LoggedIn") == true
            {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                self.present(vc, animated: true, completion: nil)
            }
            else if UserDefaults.standard.bool(forKey: "LoggedIn") == false
            {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "TutorialScreenViewController") as! TutorialScreenViewController
                self.present(vc, animated: true, completion: nil)
            }
        
            }
            
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

