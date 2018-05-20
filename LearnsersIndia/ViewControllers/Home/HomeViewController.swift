//
//  HomeViewController.swift
//  LearnsersIndia
//
//  Created by Appzoc-Macmini on 15/03/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController {
    
    @IBOutlet var bottomImage5: UIImageView!
    @IBOutlet var bottomImage4: UIImageView!
    @IBOutlet var bottomImage3: UIImageView!
    @IBOutlet var bottomImage2: UIImageView!
    @IBOutlet var bottomImage1: UIImageView!
    @IBOutlet var tab5BottomView: UIView!
    @IBOutlet var tab4BottomView: UIView!
    @IBOutlet var tab3BottomView: UIView!
    @IBOutlet var tab2BottomView: UIView!
    @IBOutlet var tab1BottomView: UIView!
    @IBOutlet var bottomView: UIView!
    @IBOutlet var tab1Container: UIView!

    @IBOutlet var tab3Container: UIView!

    @IBOutlet var tab5Container: UIView!
    @IBOutlet var bottomButton1: UIButton!
    @IBOutlet var bottomButton2: UIButton!
    @IBOutlet var bottomButton3: UIButton!
    @IBOutlet var bottomButton4: UIButton!
    @IBOutlet var bottomButton5: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        UserDefaults.standard.set(true, forKey: "TutorialScreen")
        UserDefaults.standard.set(true, forKey: "LoggedIn")
        // Set up tab bar for first time
        setUpTabBarFirst()
        
        tocken = UserDefaults.standard.string(forKey: "tocken") as! String
        selectedBoardID = UserDefaults.standard.integer(forKey: "selectedBoardID") as! Int
        selectedCls_id = UserDefaults.standard.integer(forKey: "selectedCls_id") as! Int
        selectedBorad = UserDefaults.standard.string(forKey: "boardname") as! String
        selectedClass = UserDefaults.standard.string(forKey: "gradename") as! String
        
    }
    
    func setUpTabBarFirst()
    {
        // Handling tabs
        self.tab1Container.isHidden = true

        self.tab3Container.isHidden = false

        self.tab5Container.isHidden = true
        
//        //Handling button images
//        self.bottomImage1.image = UIImage(named:"wytPractise")
//
//        self.bottomImage3.image = UIImage(named:"iconAsk")
//
//        self.bottomImage5.image = UIImage(named:"wytProfile")
        
//        // Handling background views
//        self.tab1BottomView.backgroundColor = UIColor.lightGray
//
//        self.tab3BottomView.backgroundColor = UIColor.black
//
//        self.tab5BottomView.backgroundColor = UIColor.lightGray

    }
    

    
    @IBAction func bottomButton1(_ sender: UIButton)
    {
        // Handling tabs
        self.tab1Container.isHidden = false

        self.tab3Container.isHidden = true

        self.tab5Container.isHidden = true
        
//        //Handling button images
//        self.bottomImage1.image = UIImage(named:"iconPractise")
//
//        self.bottomImage3.image = UIImage(named:"wytAsk")
//
//        self.bottomImage5.image = UIImage(named:"wytProfile")
        
//        // Handling background views
//        self.tab1BottomView.backgroundColor = UIColor.black
//
//        self.tab3BottomView.backgroundColor = UIColor.lightGray
//
//        self.tab5BottomView.backgroundColor = UIColor.lightGray
    }
    
  
    
    @IBAction func bottomButton3(_ sender: UIButton)
    {
self.setUpTabBarFirst()
    }
    
 
    
    @IBAction func bottomButton5(_ sender: UIButton)
    {
        // Handling tabs
        self.tab1Container.isHidden = true

        self.tab3Container.isHidden = true

        self.tab5Container.isHidden = false
        
//        //Handling button images
//        self.bottomImage1.image = UIImage(named:"wytPractise")
//
//        self.bottomImage3.image = UIImage(named:"wytAsk")
//
//        self.bottomImage5.image = UIImage(named:"iconProfile")
//        
//        // Handling background views
//        self.tab1BottomView.backgroundColor = UIColor.lightGray
//
//        self.tab3BottomView.backgroundColor = UIColor.lightGray
//
//        self.tab5BottomView.backgroundColor = UIColor.black
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

extension HomeViewController
{
    
    
}



