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
    static let titleTest = "Tests"
    static let titleGame = "Games"
    static let instructionGame = "How to Play"
    static let instructionTest = "Instructions for the Test"
    static let quitGameAlertTitle = "Exit Game"
    static let quitGameAlertMessage = "Do you really want to quit the game"
    static let markText = "Marks: "
    static let finalScore = "Your Score: "
    static let extraLifeMessage = "You have taken your extra life"
    static let timeRemaining = "Time Remaining: "
    static let askQuestionPlaceholder = "Ask Question"
    static let enterValidQuestionMessage = "Please enter a valid Question"
    static let questionPostedMessage = "Your question has been posted"
    static let noAnswerString = "No Answers"
    static let multipleAnswerString = " Answers"
    static let singleAnswerString = " Answer"
    static let paidUserlabelText = "You are a premium member"
    static let unpaidUserlabelText = "Unlock the rest of the list with premium"
    static let premiumUpradeSucessMessage = "You account has been upgraded to premium membership"
    static let transactionQuitAlertMessage = "Are you sure you want to cancel the transaction ?"

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
    static let StartTestOrGameViewController = "LIStartTestOrGameViewController"
    static let TestsViewController = "LITestsViewController"
    static let FinalScoreViewController = "LIFinalScoreViewController"
    static let GameViewController = "LIGameViewController"
    static let AskQuestionViewController = "LIAskQuestionViewController"
    static let AnswerViewController = "LIAnswerViewController"
    static let PaymentPackagesViewController = "LIPaymentPackagesViewController"
    static let CCAvenueViewController = "LICCAvenueViewController"
}

struct LIStoryboards {
    static let Main = "Main"
    static let Home = "Home"
}

struct LINibs {
    static let ShowLevel = "LIShowLevelView"
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

struct LINotifications {
    static let RefreshPaidStatus = "RefreshPaidStatus"
}
struct LIProfileItemTitles {
    static let Profile = "Profile"
    static let Questions = "My Questions"
    static let Videos = "My Videos"
    static let CallUs = "Call Us"
    static let Logout = "Logout"
}

struct LIPackageDenominationType {
    static let USD = "USD - "
    static let KWD = "KWD - "
    static let AED = "AED - "
    static let INR = "INR - "
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

enum LIAnswerOptionId:Int {
    case option1 = 1
    case option2
    case option3
    case option4
}


