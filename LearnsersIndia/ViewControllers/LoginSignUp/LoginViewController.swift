//
//  LoginViewController.swift
//  LearnsersIndia
//
//  Created by Appzoc-Macmini on 13/03/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit
import TextFieldEffects
import Alamofire



class LoginViewController: UIViewController,UITextFieldDelegate,navigateProtocol
{

    func loginNavigateFunction()
    {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//        self.present(vc, animated: true, completion: nil)
         self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func boardNavigateFunction()
    {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "YourBoardViewController") as! YourBoardViewController
//        self.present(vc, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func signUPNavigateFunction()
    {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
//        self.present(vc, animated: true, completion: nil)
         self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    @IBOutlet var passwordImage: UIImageView!
    @IBOutlet var passwordTextField: HoshiTextField!
    @IBOutlet var emailTextField: HoshiTextField!
    
    var username = ""
    var password = ""
    var iconClick : Bool!
    var url = "https://appapi.learnersindia.com/signin"

    
    override func viewDidLoad() {
        super.viewDidLoad()


        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        // textfeid delegate
        setUpTextFields()
        // show password
        iconClick = true
        
//        UserDefaults.standard.set(selectedUserTypeID, forKey: "selectedUserTypeID")
//        UserDefaults.standard.set(selectedUserType, forKey: "selectedUserType")
//        UserDefaults.standard.set("student", forKey: "usertype")
        
        
    }

    @IBAction func loginButtonAction(_ sender: StandardButton)
    {
        if emailTextField.text == ""
        {
            let alert = UIAlertController(title: "Error", message: "Invalid Username", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
           if passwordTextField.text == ""
           {
            let alert = UIAlertController(title: "Error", message: "Invalid Password", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
           }
            else
           {
            
            ActivityIndicator.setUpActivityIndicator(baseView: self.view)
            self.Post_Call_YourBoard(urlString: url) { (_) in
                
            }
            
            }
        }
    }
    
    @IBAction func signUpButton(_ sender: Any)
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "UserTypePopUpViewController") as! UserTypePopUpViewController
        loginORSign = "sign"
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func backButton(_ sender: Any)
    {
//        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func showPasswordButton(_ sender: Any)
    {
        if(iconClick == true) {
            passwordImage.image = UIImage(named:"eyeopen")
            passwordTextField.isSecureTextEntry = false
            iconClick = false
        } else {
            passwordImage.image = UIImage(named:"eyeclosed")
            passwordTextField.isSecureTextEntry = true
            iconClick = true
        }
    }
    
    
    @IBAction func forgotPasswordButton(_ sender: Any)
    {
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpTextFields()
    {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        // Textfeild up properties
        
        if textField == emailTextField
        {
            
            emailTextField.placeholderLabel.font = UIFont.systemFont(ofSize: 11)
            emailTextField.placeholderColor = R_UIColor.midColor
        }
        else
        {
            
            passwordTextField.placeholderLabel.font = UIFont.systemFont(ofSize: 11)
            passwordTextField.placeholderColor = R_UIColor.midColor
        }
    }
    
    
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        // Textfeild Down properties
        
        if textField == emailTextField
        {
            if textField.text == ""
            {
                emailTextField.placeholderLabel.font = UIFont.systemFont(ofSize: 15)
            }
            else
            {
                emailTextField.placeholderLabel.font = UIFont.systemFont(ofSize: 11)
            }
            emailTextField.placeholderColor = .lightGray
            emailTextField.borderInactiveColor = .gray
            username = textField.text!
        }
        if textField == passwordTextField
        {
            if textField.text == ""
            {
                passwordTextField.placeholderLabel.font = UIFont.systemFont(ofSize: 15)
            }
            else
            {
                passwordTextField.placeholderLabel.font = UIFont.systemFont(ofSize: 11)
            }
            password = textField.text!
            passwordTextField.placeholderColor = .lightGray
            passwordTextField.borderInactiveColor = .gray
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool // called when 'return' key pressed. return false to ignore.
    {
        textField.resignFirstResponder()
        return true
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

extension LoginViewController
{
    func Post_Call_YourBoard(urlString: String, completion: @escaping(Bool) -> Void)
    {
        let paramters = ["usertype":"student",
                         "loginid":emailTextField.text ?? "",
                         "password":passwordTextField.text ?? ""] as [String : Any]
        
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
                            
                            let dic = responseDic.object(forKey: "user_data") as! NSDictionary

      
                            tocken = dic.object(forKey: "tocken") as! String
                            selectedBoardID = dic.object(forKey: "syl_id") as! Int
                            selectedCls_id = dic.object(forKey: "cls_id") as! Int
                            selectedBorad = dic.object(forKey: "boardname") as! String
                            selectedClass = dic.object(forKey: "gradename") as! String

                            UserDefaults.standard.set(tocken, forKey: "tocken")
                            UserDefaults.standard.set(dic.object(forKey: "syl_id") as! Int,forKey: "selectedBoardID")
                            UserDefaults.standard.set(dic.object(forKey: "cls_id") as! Int,forKey: "selectedCls_id")
                            UserDefaults.standard.set(dic.object(forKey: "boardname") as! String,forKey: "boardname")
                            UserDefaults.standard.set(dic.object(forKey: "gradename") as! String,forKey: "gradename")
                            
                            
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                            self.present(vc, animated: true, completion: nil)
                            
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
