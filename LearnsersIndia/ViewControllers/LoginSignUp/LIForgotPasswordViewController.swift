//
//  LIForgotPasswordViewController.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 26/05/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit
import MRCountryPicker

class LIForgotPasswordViewController: UIViewController,MRCountryPickerDelegate {

    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var countryPhoneCodeLabel: UILabel!
    @IBOutlet weak var countryCodeLabel: UILabel!
    @IBOutlet weak var countryPicker: MRCountryPicker!
    @IBOutlet weak var submitButton: UIButton!
    var selectedCountryCode = ""
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
