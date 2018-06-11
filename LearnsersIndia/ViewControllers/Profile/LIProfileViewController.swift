//
//  LIProfileViewController.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 11/06/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class LIProfileViewController: UIViewController {
    @IBOutlet weak var profileScrollView: UIScrollView!
    @IBOutlet weak var profileImageContainerView: UIView!
    @IBOutlet weak var profileTableView: UITableView!
    @IBOutlet weak var premiumDetailsLabel: UILabel!
    @IBOutlet weak var premiumButton: UIButton!
    
    @IBOutlet weak var userGradeLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    let profileCellIdentifier = "profileCell"
    let paidUserlabelText = "You are a premium member"
    let unpaidUserlabelText = "Unlock the rest of the list with premium"
    var loggedInUser:LIUserModel?
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.profileScrollView.delegate = self
        self.callGetUserProfileApi()
        self.refreshSubViews()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.callGetPaidStatusApi()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    //MARK:- Adjust Views
    func refreshSubViews(){
        LIUtilities.setBorderColor(.white, For: self.profileImageContainerView)
    }
    
    func updateValues(){
        
        self.profileImage.setImageWith(self.loggedInUser?.profilePicUrl, and: #imageLiteral(resourceName: "character_white_bg"))
        self.userNameLabel.text = self.loggedInUser?.fullName
        if let boardName = loggedInUser?.boardName{
            if let gradeName = self.loggedInUser?.gradeName {
                  self.userGradeLabel.text = boardName + "-" + gradeName
            }
            else {
                self.userGradeLabel.text = boardName
            }
        }
        else {
            self.userGradeLabel.text = self.loggedInUser?.gradeName
        }
        self.profileTableView.reloadData()
    }
    
    func updatePremiumStatus(){
        
        let isPaidUser = LIAccountManager.sharedInstance.getLoggedInUser()?.isPaidUser
        self.premiumButton.isHidden = isPaidUser ?? false
        self.premiumDetailsLabel.text = isPaidUser != nil && isPaidUser == true ? self.paidUserlabelText : self.unpaidUserlabelText
    }
    
    //MARK:- IBActions
    @IBAction func premiumButtonTapped(_ sender: Any) {
        
    }
    
}

extension LIProfileViewController:UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: profileCellIdentifier, for: indexPath) as? LIProfileTableViewCell
        return cell!
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        scrollView.bounces = scrollView.contentOffset.y > 100.0
//    }
}

extension LIProfileViewController {
    
    func callGetUserProfileApi(){
        let parameters:[String:Any] = ["usertype":LIUserTypes.Student]
        LIUserStudentAPIsHandler.callGetUserProfileAPIWith(parameters, shouldAddToken: true, success: { (response) in
            if let userObject = response {
                self.loggedInUser = userObject
                self.updateValues()
            }
            else {
                LIUtilities.showErrorAlertControllerWith(LIConstants.tryAgainMessage, onViewController: self)
            }
        }, failure: { (responseMessage) in
            
            //            ActivityIndicator.dismissActivityView()
            LIUtilities.showErrorAlertControllerWith(responseMessage, onViewController: self)
        }) { (error) in

//            ActivityIndicator.dismissActivityView()
            LIUtilities.showErrorAlertControllerWith(error?.localizedDescription, onViewController: self)
        }
    
    }
    
    func callGetPaidStatusApi() {
        
        LIUserStudentAPIsHandler.callGetPaidStatusAPIWith(nil, shouldAddToken: true, success: { () in
            self.updatePremiumStatus()
        }, failure: { (response) in
            
        }) { (error) in
            
        }
    }
}
