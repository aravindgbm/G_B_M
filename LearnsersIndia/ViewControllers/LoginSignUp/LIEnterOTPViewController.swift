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
    var enteredOTP = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: - SetUp UI
    func setUpOTPView() {
        otpView.otpFieldsCount = 5
        otpView.otpFieldDefaultBorderColor = UIColor.gray
        otpView.otpFieldEnteredBorderColor = UIColor.green
        otpView.otpFieldErrorBorderColor = UIColor.red
        otpView.otpFieldBorderWidth = 2
        otpView.delegate = self
        otpView.otpFieldDisplayType = .underlinedBottom
        otpView.otpFieldSize = 20
        
        // Create the UI
        otpView.initalizeUI()
    }
    //MARK: - IBActions
    @IBAction func submitOTPButtonTapped(_ sender: Any) {
    }
    
    @IBAction func resendOTPButtonTapped(_ sender: Any) {
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
    //MARK: - OTPViewDelegate
    func hasEnteredAllOTP(hasEntered: Bool) -> Bool {
        print("Has entered all OTP? \(hasEntered)")
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
