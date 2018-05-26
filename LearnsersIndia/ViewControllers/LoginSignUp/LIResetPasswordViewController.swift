//
//  LIResetPasswordViewController.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 26/05/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit
import TextFieldEffects

class LIResetPasswordViewController: UIViewController {

    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var txtRetypePassword: HoshiTextField!
    @IBOutlet weak var txtPassword: HoshiTextField!
    @IBOutlet weak var passwordShowHideImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpSubviews()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showPasswordButtonTapped(_ sender: Any) {
        self.txtPassword.isSecureTextEntry = !self.txtPassword.isSecureTextEntry
        self.passwordShowHideImageView.image = self.txtPassword.isSecureTextEntry ? #imageLiteral(resourceName: "eyeclosed") : #imageLiteral(resourceName: "eyeopen")
        
    }
    @IBAction func submitButtonTapped(_ sender: Any) {
        if self.validateData() {
            self.callResetPasswordAPI()
        }
    }
    
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setUpSubviews(){
        LIUtilities.setBorderColor(.white, For: self.submitButton)
    }
    func validateData() -> Bool{
//        if !((txtPassword.text?.count)! > 0) || !((txtRetypePassword.text?.count)! > 0){
//            LIUtilities.showErrorAlertControllerWith("Please enter ", onViewController: <#T##UIViewController#>)
//            return false
//        }
        if ((txtPassword.text?.count)! < 7) {
            LIUtilities.showErrorAlertControllerWith("Password must have more than 6 characters", onViewController: self)
            return false
        }
        else if (txtRetypePassword.text !=  txtPassword.text) {
            LIUtilities.showErrorAlertControllerWith("Both passwords does not match", onViewController: self)
            return false
        }
        
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

extension LIResetPasswordViewController {
    
    func callResetPasswordAPI() {
        ActivityIndicator.setUpActivityIndicator(baseView: self.view)
        let parameter:[String:Any] = [LIAPIRequestKeys.token:LIAccountManager.sharedInstance.getAccesToken()!,
                                      "new_passcode":"password"]
        LIAuthenticationAPIsHandler.callResetForPasswordAPIWith(parameter as [String:AnyObject] , success: { (response) in
            ActivityIndicator.dismissActivityView()
            if response == true {
                self.showAlertAndNavigateToTutorialScreen()
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
    
    func showAlertAndNavigateToTutorialScreen() {
        let alertTitle:String = LIConstants.successAlertTitle
        let alertMessage:String = "Password resetting has been completed successfully"
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
           AppDelegate.getAppDelegateInstance().navigateToTutorialScreen()
        }
        //        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }

}
