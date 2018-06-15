//
//  LIConstants.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 20/05/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

//class LIConstants: NSObject {
//    static let sharedInstance = LIConstants()
//}
struct LIConstants {
    static let errorAlertTitle = "Error"
    static let tryAgainMessage = "Try again later"
    static let unPaidUserStatus = "unpaid"
    static let paidUserStatus = "paid"
    static let successAlertTitle = "Success"
    static let logoutAlertTitle = "Logout"
    static let logoutAlertMessage = "Are you sure you want to logout?"
    static let demoVideoTitleText = "Demo Videos"
    static let contactNumber = "04714015515"
    static let titleSorry = "Sorry"
    static let paidVideoAlertMessage = "Unlock this video by upgrading to premium"
    static let exerciseHeader = "Question "

}

struct LIViewControllerIdentifier {
    static let EnterOTPViewController = "LIEnterOTPViewController"
    static let ForgotPasswordViewController = "LIForgotPasswordViewController"
//    static let HomeNavigationController = "LIHomeNavigationController"
    static let HomeTabBarController = "LIHomeTabBarController"
    static let LoginNavigationController = "LILoginNavigationController"
    static let ResetPasswordViewController = "LIResetPasswordViewController"
    static let FeedViewController = "LIFeedViewController"
    static let ProfileViewController  = "LIProfileViewController"
    static let QuestionsViewController = "LIQuestionsViewController"
    static let ChaptersViewController = "LIChaptersViewController"
    static let VideosViewController = "LIVideosViewController"
    static let ExercisesViewController = "LIExercisesViewController"
}

struct LIStoryboards {
    static let Main = "Main"
    static let Home = "Home"
}

struct LIColors {
    static let ThemeColor = "#0596CF"
    static let LogoutLabelTextColor = "#b6927b"
    static let exerciseEvenIndexBgColor = "#fff3e0"
    static let exerciseOddIndexBgColor = "#8F8F8F"
    static let lighterAlpha:CGFloat = 0.08
}

struct LIUserTypes {
    static let Student = "student"
}
struct LIProfileItemTitles {
    static let Profile = "Profile"
    static let Questions = "My Questions"
    static let Videos = "My Videos"
    static let CallUs = "Call Us"
    static let Logout = "Logout"
}

struct LIProfileItemIcons {
    static let Profile = #imageLiteral(resourceName: "editProfileIcon")
    static let Questions = #imageLiteral(resourceName: "questionIconProfile")
    static let Videos = #imageLiteral(resourceName: "videoIconProfile")
    static let CallUs = #imageLiteral(resourceName: "callIconProfile")
    static let Logout = #imageLiteral(resourceName: "logoutIconProfile")
    static let Email = #imageLiteral(resourceName: "emailIconProfile")
    static let Address = #imageLiteral(resourceName: "addressIconProfile")
    static let DateOfBirth = #imageLiteral(resourceName: "dobIconProfile")
}
enum LIProfileItemType {
    case LIProfileItemTypeEditProfile
    case LIProfileItemTypeQuestions
    case LIProfileItemTypeVideos
    case LIProfileItemTypeCallUs
    case LIProfileItemTypeLogout
    case LIProfileItemTypePhoneNumber
    case LIProfileItemTypeEmail
    case LIProfileItemTypeAddress
    case LIProfileItemTypeDateOfBirth
}
let screenSize = UIScreen.main.bounds.size


enum LIChapterType {
    case LIChapterTypeVideos
    case LIChapterTypeExercises
    case LIChapterTypeTests
}


