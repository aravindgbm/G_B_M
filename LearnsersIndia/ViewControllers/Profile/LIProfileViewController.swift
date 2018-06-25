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
    var profileItemsArray:[LIProfileItem]?
    var editProfileItemsArray:[LIProfileItem]?
    var isEditProfileSreen = false
    let profileCellIdentifier = "profileCell"
    let paidUserlabelText = "You are a premium member"
    let unpaidUserlabelText = "Unlock the rest of the list with premium"
    var loggedInUser:LIUserModel?
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.profileScrollView.delegate = self
        self.callGetUserProfileApi()
        self.refreshSubViews()
        self.initialiseProfileItems()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.callGetPaidStatusApi()
        self.updateNavigationBarAppearance()
    }

    //MARK:- Adjust Views
    func refreshSubViews(){
        LIUtilities.setBorderColor(.white, with: 2.0, For: self.profileImageContainerView)
//        LIUtilities.setBorderColor(.white, For: self.profileImageContainerView)
    }
    
    func updateNavigationBarAppearance() {
        if self.isEditProfileSreen {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.isTranslucent = true
            let backBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back"), style: .plain, target: self, action: #selector(backButtonTapped))
            self.navigationItem.leftBarButtonItem = backBarButtonItem
        }
        else {
            
            self.navigationController?.navigationBar.isTranslucent = false
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
        self.tabBarController?.tabBar.isHidden = false
        self.profileScrollView.scrollsToTop = true
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
    
    //MARK:- Initialise Profile Items
    
    func initialiseProfileItems(){
        if self.profileItemsArray == nil {
            self.profileItemsArray = [LIProfileItem]()
            let profileItemEdit = LIProfileItem(LIProfileItemIcons.Profile, title: LIProfileItemTitles.Profile, type: LIProfileItemType.LIProfileItemTypeEditProfile)
            self.profileItemsArray?.append(profileItemEdit)
            
            let profileItemQuestions = LIProfileItem(LIProfileItemIcons.Questions, title: LIProfileItemTitles.Questions, type: LIProfileItemType.LIProfileItemTypeQuestions)
            self.profileItemsArray?.append(profileItemQuestions)
            
            let profileItemVideos = LIProfileItem(LIProfileItemIcons.Videos, title: LIProfileItemTitles.Videos, type: LIProfileItemType.LIProfileItemTypeVideos)
            self.profileItemsArray?.append(profileItemVideos)
            
            let profileItemCallUs = LIProfileItem(LIProfileItemIcons.CallUs, title: LIProfileItemTitles.CallUs, type: LIProfileItemType.LIProfileItemTypeCallUs)
            self.profileItemsArray?.append(profileItemCallUs)
            
            let profileItemLogout = LIProfileItem(LIProfileItemIcons.Logout, title: LIProfileItemTitles.Logout, type: LIProfileItemType.LIProfileItemTypeLogout)
            self.profileItemsArray?.append(profileItemLogout)
            
            self.profileTableView.reloadData()
        }
    }
    
    func initialiseEditProfileItems(){
        self.editProfileItemsArray = [LIProfileItem]()
        
        let profileItemPhone = LIProfileItem(LIProfileItemIcons.CallUs, title: self.loggedInUser?.phonenumber, type: LIProfileItemType.LIProfileItemTypePhoneNumber)
        self.editProfileItemsArray?.append(profileItemPhone)
        
        let profileItemEmail = LIProfileItem(LIProfileItemIcons.Email, title: self.loggedInUser?.email, type: LIProfileItemType.LIProfileItemTypeEmail)
        self.editProfileItemsArray?.append(profileItemEmail)
        
        let profileItemAddress = LIProfileItem(LIProfileItemIcons.Address, title: self.loggedInUser?.address, type: LIProfileItemType.LIProfileItemTypeAddress)
        self.editProfileItemsArray?.append(profileItemAddress)
        
        let profileItemDob = LIProfileItem(LIProfileItemIcons.DateOfBirth, title: self.loggedInUser?.dateOfBirth, type: LIProfileItemType.LIProfileItemTypeDateOfBirth)
        self.editProfileItemsArray?.append(profileItemDob)
    }
    //MARK:- IBActions
    @IBAction func premiumButtonTapped(_ sender: Any) {
        self.navigateToPaymentPackageViewController()
    }
    //MARK:- Navigations
    
    @objc func backButtonTapped(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func navigateToPaymentPackageViewController() {
        let storyBoard = UIStoryboard.init(name: LIStoryboards.Home, bundle: nil)
        let packagesVC = storyBoard.instantiateViewController(withIdentifier: LIViewControllerIdentifier.PaymentPackagesViewController) as? LIPaymentPackagesViewController
        self.navigationController?.pushViewController(packagesVC!, animated: true)
    }
    
    func navigateToProfileEditScreen(){
        let storyBoard = UIStoryboard.init(name: LIStoryboards.Home, bundle: nil)
        let profileVC = storyBoard.instantiateViewController(withIdentifier: LIViewControllerIdentifier.ProfileViewController) as? LIProfileViewController
        profileVC?.isEditProfileSreen = true
        profileVC?.editProfileItemsArray = self.editProfileItemsArray
        self.navigationController?.pushViewController(profileVC!, animated: true)
    }
    
    func navigateToQuestionsScreen(){
        let storyBoard = UIStoryboard.init(name: LIStoryboards.Home, bundle: nil)
        let questionsVC = storyBoard.instantiateViewController(withIdentifier: LIViewControllerIdentifier.QuestionsViewController) as? LIQuestionsViewController
        questionsVC?.isFromProfileScreen = true
        self.navigationController?.pushViewController(questionsVC!, animated: true)
    }
    
    func navigateToChaptersScreen(){
        let storyBoard = UIStoryboard.init(name: LIStoryboards.Home, bundle: nil)
        let chaptersVC = storyBoard.instantiateViewController(withIdentifier: LIViewControllerIdentifier.ChaptersViewController) as? LIChaptersViewController
        chaptersVC?.chapterType = .LIChapterTypeVideos
        self.navigationController?.pushViewController(chaptersVC!, animated: true)
    }
    
    func openDialer(){
        if let url = URL(string: "tel://\(LIConstants.contactNumber)"), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
        }
        else{
            LIUtilities.showOkAlertControllerWith(nil, message: "Sorry your device doesn't support this feature", onViewController: self)
        }
    }
    
}

extension LIProfileViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isEditProfileSreen {
            return self.editProfileItemsArray?.count ?? 0
        }
        else {
            return self.profileItemsArray?.count ?? 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: profileCellIdentifier, for: indexPath) as? LIProfileTableViewCell
        let profileItem = self.isEditProfileSreen ? self.editProfileItemsArray?[indexPath.row] : self.profileItemsArray?[indexPath.row]
        cell?.refreshCellWith(profileItem)
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.isEditProfileSreen {
            
        }
        else {
            let profileItem = self.profileItemsArray?[indexPath.row]
            switch profileItem?.profileItemType {
            case LIProfileItemType.LIProfileItemTypeEditProfile?:
                self.navigateToProfileEditScreen()
                break
            case LIProfileItemType.LIProfileItemTypeQuestions?:
                self.navigateToQuestionsScreen()
                break
            case LIProfileItemType.LIProfileItemTypeVideos?:
                self.navigateToChaptersScreen()
                break
            case LIProfileItemType.LIProfileItemTypeCallUs?:
                self.openDialer()
                break
            case LIProfileItemType.LIProfileItemTypeLogout?:
                LIUtilities.showLogoutAlertOnViewController(self)
                break
            default:
                break
            }
        }
    }
    

}

extension LIProfileViewController {
    
    func callGetUserProfileApi(){
        let parameters:[String:Any] = ["usertype":LIUserTypes.Student]
        ActivityIndicator.setUpActivityIndicator(baseView: self.view)
        LIUserStudentAPIsHandler.callGetUserProfileAPIWith(parameters, shouldAddToken: true, success: { (response) in
            ActivityIndicator.dismissActivityView()
            if let userObject = response {
                self.loggedInUser = userObject
                self.updateValues()
                self.initialiseEditProfileItems()
                
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
    
    func callGetPaidStatusApi() {
        
        LIUserStudentAPIsHandler.callGetPaidStatusAPIWith(nil, shouldAddToken: true, success: { () in
            self.updatePremiumStatus()
        }, failure: { (response) in
            
        }) { (error) in
            
        }
    }
}
