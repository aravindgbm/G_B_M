//
//  ChangePasswordViewController.swift
//  LearnsersIndia
//
//  Created by Appzoc-Macmini on 03/04/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit
import TextFieldEffects
import Alamofire

class ChangePasswordViewController: UIViewController {
    
    @IBOutlet var oldTextfeild: HoshiTextField!
    @IBOutlet var confirmPassword: HoshiTextField!
    @IBOutlet var newTextfeild: HoshiTextField!
    
    var url = "https://appapi.learnersindia.com/change-password"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SaveButton(_ sender: Any)
    {
       ActivityIndicator.setUpActivityIndicator(baseView: self.view)
        self.Post_Password(urlString: url) { (_) in
            
        }
    }
    
    @IBAction func CancelButton(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
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

extension ChangePasswordViewController
{
    func Post_Password(urlString: String, completion: @escaping(Bool) -> Void)
    {
        let paramters = ["usertype":usertype,
                         "tocken":UserDefaults.standard.string(forKey: "tocken"),
                         "old_passcode":oldTextfeild.text ?? "",
                         "new_passcode":newTextfeild.text ?? ""] as [String : Any]
        
        Alamofire.request(urlString, method: .post, parameters: paramters, headers: nil).responseJSON { (response) in
            
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
                            ActivityIndicator.dismissActivityView()
                            self.dismiss(animated: true, completion: nil)
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



