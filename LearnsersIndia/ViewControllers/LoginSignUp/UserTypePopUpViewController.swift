//
//  UserTypePopUpViewController.swift
//  LearnsersIndia
//
//  Created by Appzoc-Macmini on 14/03/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit
import DropDown

var selectedUserTypeID = ""
var selectedUserType = ""
var usertype = "student"//currently setting to student for Phase 1 TODO: change this for phase 2

protocol navigateProtocol
{
    func loginNavigateFunction()
    func boardNavigateFunction()
    func signUPNavigateFunction()
}

class UserTypePopUpViewController: UIViewController {
    
    @IBOutlet var label: UILabel!
    @IBOutlet var dropView: UIView!
    
    let tripDropDown = DropDown()
    var userTypeArray = ["Student","Teacher","Parent"]
    var usertypearray = ["student","teacher","parent"]
    var userTypeIDArray = ["1","2","3"]
    var delegate : navigateProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        

        
    }
    override func viewWillAppear(_ animated: Bool)
    {
        setUpDropDown()
        tripDropDown.selectRow(0)
        selectedUserTypeID = userTypeIDArray[0]
        selectedUserType = userTypeArray[0]
        self.label.text = tripDropDown.selectedItem
        usertype = self.usertypearray[0]
        
        UserDefaults.standard.set(selectedUserTypeID, forKey: "selectedUserTypeID")
        UserDefaults.standard.set(selectedUserType, forKey: "selectedUserType")
        UserDefaults.standard.set(usertype, forKey: "usertype")
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     
     
     if login or sign up
     
     */
    
    
    @IBAction func submitButton(_ sender: Any)
    {
        if loginORSign == "login"
        {
            self.dismiss(animated: false, completion: {
                self.delegate?.loginNavigateFunction()
            })
        }
        else if loginORSign == "sign"
        {
            if selectedUserTypeID == "1"
            {
                self.dismiss(animated: false, completion: {
                self.delegate?.boardNavigateFunction()
                })
            }
            else
            {
                self.dismiss(animated: false, completion: {
                self.delegate?.signUPNavigateFunction()
                })
            }
        }
    }
    
    
    @IBAction func showDropDownAction(_ sender: UIButton)
    {
        if tripDropDown.isHidden{
            tripDropDown.show()
        }else{
            tripDropDown.hide()
        }
    }
    
    func setUpDropDown()
    {
        tripDropDown.anchorView = dropView
        tripDropDown.dataSource = userTypeArray
        tripDropDown.selectionAction = { index, item in
            self.label.text = item
            selectedUserTypeID = self.userTypeIDArray[index]
            selectedUserType = item
            usertype = self.usertypearray[index]
        }
        self.label.text = tripDropDown.selectedItem
        
    }
    
    @IBAction func CloseButton(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

