//
//  LIEnterOTPViewController.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 25/05/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class LIEnterOTPViewController: UIViewController {

    @IBOutlet weak var otpView: VPMOTPView!
    @IBOutlet weak var submitOTPButton: UIButton!
    @IBOutlet weak var resendOTPButton: UIButton!
    @IBOutlet weak var backButton: UIBarButtonItem!
    var enteredOTP = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpSubviews()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    //MARK: - SetUp UI
    func setUpSubviews() {
        LIUtilities.setBorderColor(.white, For: self.submitOTPButton)
        self.setUpOTPView()
    }
    func setUpOTPView() {
        
        otpView.otpFieldsCount = 6
        otpView.otpFieldDefaultBorderColor = UIColor.gray
        otpView.otpFieldEnteredBorderColor = UIColor.white
        otpView.otpFieldErrorBorderColor = UIColor.red
        otpView.cursorColor = UIColor.white
        otpView.otpFieldBorderWidth = 2
        otpView.delegate = self
        otpView.otpFieldDisplayType = .underlinedBottom
        otpView.otpFieldSize = 20
        // Create the UI
        otpView.initalizeUI()
    }
    //MARK: - IBActions
    @IBAction func submitOTPButtonTapped(_ sender: Any) {
        if let otpVerified = LIAccountManager.sharedInstance.getLoggedInUser()?.isOTPVerified {
            if otpVerified == false {
                self.callSubmitOTPAPI()
            }
            else {
                
            }
        }
    }
    
    @IBAction func resendOTPButtonTapped(_ sender: Any) {
        callResendOTPAPI()
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

extension LIEnterOTPViewController: VPMOTPViewDelegate {
    func callResendOTPAPI(){
        ActivityIndicator.setUpActivityIndicator(baseView: self.view)
        let parameter = [LIAPIRequestKeys.token:LIAccountManager.sharedInstance.getAccesToken()!]
        LIAuthenticationAPIsHandler.callResendOTPAPIWith(parameter as [String : AnyObject], success: { (response) in
            ActivityIndicator.dismissActivityView()
            if response == true {
                LIUtilities.showOkAlertControllerWith("Sucess", message: "New OTP has been sent to your registered mobile number", onViewController: self)
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
    func callSubmitOTPAPI(){
        ActivityIndicator.setUpActivityIndicator(baseView: self.view)
        let parameter:[String:Any] = [LIAPIRequestKeys.token:LIAccountManager.sharedInstance.getAccesToken()!,
                          "otp":enteredOTP]
     

        LIAuthenticationAPIsHandler.callValidateOTPAPIWith(parameter as [String:AnyObject], success: { (response) in
            if response == true {
                AppDelegate.getAppDelegateInstance().navigateToHomeScreen()
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
    
    //MARK: - OTPViewDelegate
    func hasEnteredAllOTP(hasEntered: Bool) -> Bool {
//        print("Has entered all OTP? \(hasEntered)")
//        if hasEntered {
//            if let otp = LIAccountManager.sharedInstance.getSavedOTP() {
//                 return enteredOTP == otp
//            }
//            return false
//        }
       return true
    }
    
    func shouldBecomeFirstResponderForOTP(otpFieldIndex index: Int) -> Bool {
        return true
    }
    
    func enteredOTP(otpString: String) {
        enteredOTP = otpString
        print("OTPString: \(otpString)")
    }
    
}
