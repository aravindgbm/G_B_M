//
//  EditProfileViewController.swift
//  LearnsersIndia
//
//  Created by macbook on 01/04/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var cityAddLabel: UILabel!
    @IBOutlet weak var addressAddLabel: UILabel!
    @IBOutlet weak var dobAddLabel: UILabel!
    @IBOutlet weak var genderAddLabel: UILabel!
    @IBOutlet weak var mobileLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    var name = String()
    var email_id = String()
    var phone = String()
    var gender = String()
    var dob = String()
    var address = String()
    var city = String()
    var state = String()
    var country = String()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.nameLabel.text = self.name
        self.emailLabel.text = self.email_id
        self.mobileLabel.text = self.phone
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func backButton(_ sender: Any)
    {
      //  self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
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
