//
//  SideMenuViewController.swift
//  LearnsersIndia
//
//  Created by Appzoc-Macmini on 26/03/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit
import Alamofire



class ProfileViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var premiumLabel: StandardLabel!
    @IBOutlet weak var boardLabel: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var subscriptionLabel: UILabel!
    
    var profileUrl = "https://appapi.learnersindia.com/get-user-profile"
    var studentID = Int()
    var classID = Int()
    var sylabussID = Int()
    var reg_timestamp = Int()
    var name = String()
    var email_id = String()
    var phone = String()
    var gender = String()
    var dob = String()
    var address = String()
    var city = String()
    var state = String()
    var country = String()
    var className = String()
    var boardName = String()
    var profile = String()



    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        
    }

    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
//        ActivityIndicator.setUpActivityIndicator(baseView: self.view)
//        self.userProfileWebCall(urlString: profileUrl) { (_) in
//            
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }
    

    
    @IBAction func premiumButton(_ sender: Any)
    {
      
    }
    
    @IBAction func editButton(_ sender: Any)
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "EditProfileViewController") as! EditProfileViewController
        vc.name = self.name
        vc.email_id = self.email_id
        vc.phone = self.phone
//        vc.gender = self.gender
//        vc.dob = self.dob
//        vc.address = self.address
//        vc.city = self.city
//        vc.state = self.state
//        vc.country = self.country
        
        self.navigationController?.pushViewController(vc, animated: true)
        //(vc, animated: true, completion: nil)
//        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func changePasswordButton(_ sender: Any)
    {
        /*
         {
         "response_type": "success",
         "response_code": "100",
         "response_text": "New password has been set"
         }
 */
        
        
        
    }
    
    @IBAction func logoutButton(_ sender: Any)
    {
        let refreshAlert = UIAlertController(title: "Logout", message: "Are you sure about logging out?", preferredStyle: UIAlertControllerStyle.alert)
        refreshAlert.addAction(UIAlertAction(title: "NO", style: UIAlertActionStyle.default, handler: nil))
        refreshAlert.addAction(UIAlertAction(title: "YES", style: .default, handler: { (action: UIAlertAction!) in
          
            UserDefaults.standard.set(false, forKey: "LoggedIn")
            
            self.view.window!.rootViewController?.dismiss(animated: false, completion: {
                print("dismiss////////////////////////")
               
           

            })
         
                

           
            
            
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "TutorialScreenViewController") as! TutorialScreenViewController
//            self.navigationController?.pushViewController(vc, animated: true)
            
        }))
        present(refreshAlert, animated: true, completion: nil)
        
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



extension ProfileViewController
{
 

    func userProfileWebCall(urlString: String, completion: @escaping(Bool) -> Void)
    {
        print(UserDefaults.standard.string(forKey: "tocken") as! String)
        
        let paramters = ["usertype":"student",     //selectedUserType,
            "tocken": UserDefaults.standard.string(forKey: "tocken") as! String]
        
        Alamofire.request(urlString, method: .get, parameters: paramters, headers: nil).responseJSON { (response) in
            
            ActivityIndicator.dismissActivityView()
            switch(response.result)
            {
            case .success(_):
                if response.result.value != nil
                {
                    if let responseDic:NSDictionary = response.result.value as? NSDictionary
                    {
                        print(responseDic)
                        if responseDic.object(forKey: "response_type") as! String == "error"
                        {
                            let message = responseDic.object(forKey: "response_text") as! String
                            let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                        else
                        {
                            print("///////////////")
                            ActivityIndicator.dismissActivityView()
                            
                            let userData = responseDic.object(forKey: "user_data") as! NSDictionary
//                            self.studentID = userData.object(forKey: "std_id") as! Int
                            self.name = userData.object(forKey: "full_name") as! String
                            self.email_id = userData.object(forKey: "email_id") as! String
                            self.phone = userData.object(forKey: "phoneno") as! String
                            self.className = userData.object(forKey: "gradename") as! String
                            self.boardName = userData.object(forKey: "boardname") as! String
                            

                            print(self.name)
                            print(self.className)
                            print(self.boardName)
                            
  //                          self.studentIdLabel.text = String(self.studentID)
                            self.nameLabel.text = self.name
                            self.classLabel.text = self.className
                            self.boardLabel.text = self.boardName

                            
                            
                        }
                    }
                }
                
                break
                
            case .failure(_):
                print("Post call Failed \(response.result.error as Any)")
                completion(false)
                break
            }
            ActivityIndicator.dismissActivityView()
        }
    }
    
    

    
    

    
    
    
    
    
}


/*
 {
 "response_type": "success",
 "response_code": "100",
 "response_text": "Login successful",
 "user_data": {
 "std_id": 13,
 "full_name": "Manu Mohan",
 "email_id": "jipinm@gmail.com",
 "phoneno": "8129836080",
 "cls_id": 10,
 "syl_id": 1,
 "profile_pic": null,
 "gender": null,
 "address": null,
 "city": null,
 "state": null,
 "country": null,
 "dob": null,
 "reg_timestamp": 1522304443,
 "gradename": "Class 10",
 "boardname": "CBSE"
 }
 }
 
 */




