//
//  SignUpViewController.swift
//  LearnsersIndia
//
//  Created by Appzoc-Macmini on 13/03/18.
//  Copyright © 2018 macbook. All rights reserved.
//


//escape character
// invalid token
// feed page data format like andhroid dmy, View answer only on more than one count
//
//

import UIKit
import Alamofire
import TextFieldEffects
import DropDown
import MRCountryPicker


var user_id = Int()
var tocken = String()
var otp = Int()
var mobile = Int()
var email = ""


class SignUpViewController: UIViewController,navigateProtocol,MRCountryPickerDelegate {
    
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
    
    
    
    
    let url = "https://appapi.learnersindia.com/signup"
    
  
    @IBOutlet weak var countryAlphabetLabel: UILabel!
    @IBOutlet weak var retypePasswordTextfeild: HoshiTextField!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var syllabusLabel: UILabel!
    @IBOutlet var countryCodeLabel: UILabel!
    @IBOutlet var flagImageview: UIImageView!
    @IBOutlet var dropview: UIView!
    @IBOutlet var passwordImage: UIImageView!
    @IBOutlet var passwordTextFeild: HoshiTextField!
    @IBOutlet var nameTextFeild: HoshiTextField!
    @IBOutlet var emailTextFeild: HoshiTextField!
    @IBOutlet var mobileTextFeild: HoshiTextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var countryPicker: MRCountryPicker!
    var iconClick : Bool!
    let dropDown = DropDown()
    var imageArray = ["India","kuwait"]
    var labelArray = ["+91","+914"]
    var selectedCountryCode = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
  
        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        iconClick = true  // show password
        
        setUPDropDown()   // drop down
        
        self.selectedCountryCode = labelArray[0]
//        UserDefaults.standard.set(tocken, forKey: "tocken")
        syllabusLabel.text = selectedBorad
        classLabel.text = selectedClass
        self.setUpCountryPicker()
        self.countryPicker.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButton(_ sender: Any)
    {
//        let vc = storyboard?.instantiateViewController(withIdentifier: "UserTypePopUpViewController") as! UserTypePopUpViewController
//        loginORSign = "login"
//        vc.delegate = self
//        self.present(vc, animated: true, completion: nil)
    //TODO: uncomment the above code and remove the bottom code for phase 2
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func backButton(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
//        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUpButton(_ sender: Any)
    {
        let isValid = self.validation()
        
        if isValid == true
        {
            // Web call
//            ActivityIndicator.setUpActivityIndicator(baseView: self.view)
//            Post_Call_YourBoard(urlString: url) { (isFinisged) in
//
//            }
            self.callSignUpAPI()
        }
    }
    
    @IBAction func showPasswordButton(_ sender: Any)
    {
        if(iconClick == true) {
            passwordImage.image = UIImage(named:"eyeopen")
            passwordTextFeild.isSecureTextEntry = false
            iconClick = false
        } else {
            passwordImage.image = UIImage(named:"eyeclosed")
            passwordTextFeild.isSecureTextEntry = true
            iconClick = true
        }
    }
    
    
    
    @IBAction func showDropDownAction(_ sender: UIButton)
    {
        
        
        self.countryPicker.isHidden = !self.countryPicker.isHidden
        if !self.countryPicker.isHidden {
            let dropDownViewFrame = self.dropDown.frame
            self.scrollView.scrollRectToVisible(CGRect(x: dropDownViewFrame.origin.x, y: dropDownViewFrame.origin.y, width: dropDownViewFrame.size.width, height: dropDownViewFrame.size.height), animated: true)
        }
//        if dropDown.isHidden
//        {
//            dropDown.show()
//        }
//        else
//        {
//            dropDown.hide()
//        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func validation() -> Bool
    {
        
        
        // Name Validation
        let name_validation = nameTextFeild.text!.count
        var isNameValid = Bool()
        
        if name_validation > 2
        {
            isNameValid = true
        }
        else
        {
            isNameValid = false
            print("Name Invalid")
            let alert = UIAlertController(title: "Error", message: "Invalid Name", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        
        // Email Validation
        let email_validation = emailTextFeild.text!
        var isEmailValid = Bool()
        
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        isEmailValid = emailPredicate.evaluate(with: email_validation)
        
        if isEmailValid == false
        {
            print("Email Invalid")
            let alert = UIAlertController(title: "Error", message: "Invalid Email ID", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        
        // Mobile Validation
        let mobile_validation = mobileTextFeild.text!.count
        var isMobileValid = Bool()
        
        if mobile_validation > 9
        {
isMobileValid = true
        }
        else
        {
            isMobileValid = false
            print("Mobile Invalid")
            let alert = UIAlertController(title: "Error", message: "Invalid Mobile Number", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
            
            
        
        // Mobile Validation
        let password_validation = passwordTextFeild.text!.count
        var isPasswordValid = Bool()
        
        if password_validation > 6
        {
            if passwordTextFeild.text == retypePasswordTextfeild.text
            {
                isPasswordValid = true
            }
            else
            {
                isPasswordValid = false
                print("Both passwords does not match")
                let alert = UIAlertController(title: "Error", message: "Wrong Password", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
        }
        else
        {
            isPasswordValid = false
            print("Password Invalid")
            let alert = UIAlertController(title: "Error", message: "Password must have more than 6 characters", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        
        
        if (isNameValid && isEmailValid && isMobileValid && isPasswordValid)
        {
            return true
            
        }
        else
        {
            return false
        }
        
    }
    
    func setUpCountryPicker(){
        countryPicker.countryPickerDelegate = self
        countryPicker.showPhoneNumbers = true
        countryPicker.setCountry("IN")
        countryPicker.backgroundColor = UIColor.white
//        countryPicker.setLocale("sl_SI")
//        countryPicker.setCountryByName("Canada")
       
    }
    func countryPhoneCodePicker(_ picker: MRCountryPicker, didSelectCountryWithName name: String, countryCode: String, phoneCode: String, flag: UIImage) {
//        self.countryName.text = name
//        self.countryCode.text = countryCode
//        self.phoneCode.text = phoneCode
//        self.countryFlag.image = flag
        self.flagImageview.image = flag
        self.countryCodeLabel.text = phoneCode
        self.countryAlphabetLabel.text = countryCode
        self.selectedCountryCode = phoneCode
    }
    
    func setUPDropDown()
    {
        dropDown.anchorView = dropview
        dropDown.dataSource = self.labelArray
        /*** IMPORTANT PART FOR CUSTOM CELLS ***/
        dropDown.cellNib = UINib(nibName: "DropdownCell", bundle: nil)
        dropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            guard let cell = cell as? DropdownCell else { return }
            
            // Setup your custom UI components
            cell.optionLabel.text = self.labelArray[index]
            cell.imageview.image = UIImage(named:self.imageArray[index])
        }
        dropDown.selectionAction = { index, item in
            self.countryCodeLabel.text = self.labelArray[index]
            self.flagImageview.image = UIImage(named:self.imageArray[index])
            self.selectedCountryCode = self.labelArray[index]
        }
    }
    
}

extension SignUpViewController
{
    func callSignUpAPI() {
        let paramters:[String : Any] = ["usertype":usertype,
                         "fullname":nameTextFeild.text ?? "",
                         "email":emailTextFeild.text ?? "",
                         "mobile":mobileTextFeild.text ?? "",
                         "password":passwordTextFeild.text ?? "",
                         "board":selectedBoardID,
                         "class":selectedCls_id,
                         "country_tel_code":selectedCountryCode]
        
  
        LIAuthenticationAPIsHandler.callSignUpAPIWith(paramters as [String : AnyObject], success: { (response) in
            ActivityIndicator.dismissActivityView()
            if response == true {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: LIViewControllerIdentifier.EnterOTPViewController) as! LIEnterOTPViewController
                self.navigationController?.present(vc, animated: true, completion: nil)
            }
            else {
                LIUtilities.showErrorAlertControllerWith(LIConstants.tryAgainMessage, onViewController: self)
            }
            
        }, failure: { (responseMessage) in
            LIUtilities.showErrorAlertControllerWith(responseMessage, onViewController: self)
            ActivityIndicator.dismissActivityView()
        }) { (error) in
            ActivityIndicator.dismissActivityView()
            LIUtilities.showErrorAlertControllerWith(error?.localizedDescription, onViewController: self)
        }
        
        
        
    }
    
    func Post_Call_YourBoard(urlString: String, completion: @escaping(Bool) -> Void)
    {
        print(nameTextFeild.text ?? "")
        print(emailTextFeild.text ?? "")
        print(mobileTextFeild.text ?? "")
        print(passwordTextFeild.text ?? "")
        
        
        let paramters = ["usertype":usertype,
                         "fullname":nameTextFeild.text ?? "",
                         "email":emailTextFeild.text ?? "",
                         "mobile":mobileTextFeild.text ?? "",
                         "password":passwordTextFeild.text ?? "",
                         "board":selectedBoardID,
                         "class":selectedCls_id,
                         "country_tel_code":selectedCountryCode] as [String : Any]
        
//            Alamofire.request(urlString, method: .post, parameters: paramters, encoding: URLEncoding.default, headers: <#T##HTTPHeaders?#>)
        
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
                            
                            user_id = responseDic.object(forKey: "user_id") as? Int ?? -1
                            UserDefaults.standard.set(user_id, forKey: "user_id")
                            
                            otp = responseDic.object(forKey: "otp") as? Int ?? -1
                            mobile = responseDic.object(forKey: "mobile") as? Int ?? -1
                            email = responseDic.object(forKey: "email") as? String ?? ""
                            tocken = responseDic.object(forKey: "tocken") as? String ?? ""
                            UserDefaults.standard.set(tocken, forKey: "tocken")
                            
                            
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






