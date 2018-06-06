//
//  LIForgotPasswordViewController.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 26/05/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit
import MRCountryPicker
import TextFieldEffects

class LIForgotPasswordViewController: UIViewController,MRCountryPickerDelegate {

    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var countryPhoneCodeLabel: UILabel!
    @IBOutlet weak var countryCodeLabel: UILabel!
    @IBOutlet weak var countryPicker: MRCountryPicker!
    @IBOutlet weak var submitButton: UIButton!
    var selectedCountryCode = ""
    
    @IBOutlet weak var txtMobileNumber: HoshiTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpSubviews()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showCountryPickerButtonTapped(_ sender: Any) {
        self.countryPicker.isHidden = !self.countryPicker.isHidden
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        if (self.txtMobileNumber.text?.count)! > 0 {
            self.callAPIForSendingOTPForPasswordRecovery()
        }
        else {
            LIUtilities.showErrorAlertControllerWith("Please enter a valid mobile number", onViewController: self)
        }
   
    }
    @IBAction func backButton(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    //MARK: - SetUp Views
    func setUpSubviews() {
        self.setUpCountryPicker()
        LIUtilities.setBorderColor(.white, For: self.submitButton)
    }
    func setUpCountryPicker(){
        self.countryPicker.isHidden = true
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
        self.flagImageView.image = flag
        self.countryPhoneCodeLabel.text = phoneCode
        self.countryCodeLabel.text = countryCode
        self.selectedCountryCode = phoneCode
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

extension LIForgotPasswordViewController {
    func callAPIForSendingOTPForPasswordRecovery(){
        ActivityIndicator.setUpActivityIndicator(baseView: self.view)
        let parameter:[String:Any] = ["mobile":self.txtMobileNumber.text ?? nil]
        
        LIAuthenticationAPIsHandler.callSendOTPForPasswordRecoveryAPIWith(parameter as [String:AnyObject], success: { (response) in
            ActivityIndicator.dismissActivityView()
            if response == true {
//             " New OTP generated for resetting password"
                self.showAlertAndNavigateToOtpEntryScreen()
            }
            else {
                LIUtilities.showErrorAlertControllerWith(LIConstants.tryAgainMessage, onViewController: self)
            }
        }, failure: { (responseMessage) in
            ActivityIndicator.dismissActivityView()
            LIUtilities.showErrorAlertControllerWith(responseMessage, onViewController: self)
        }) { (error) in
            ActivityIndicator.dismissActivityView()
            LIUtilities.showErrorAlertControllerWith(error?.localizedDescription, onViewController: self)
        }
    }
    
    
    func showAlertAndNavigateToOtpEntryScreen () {
        let alertTitle:String = LIConstants.successAlertTitle
        let alertMessage:String = "New OTP has been sent to the mobile number for resetting the password"
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
           let vC = self.storyboard?.instantiateViewController(withIdentifier: LIViewControllerIdentifier.EnterOTPViewController) as! LIEnterOTPViewController
            self.navigationController?.pushViewController(vC, animated: true)
        }
        //        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
