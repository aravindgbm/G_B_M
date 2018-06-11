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
}

struct LIStoryboards {
    static let Main = "Main"
    static let Home = "Home"
}

struct LIColors {
    static let ThemeColor = "#0596CF"
}

struct LIUserTypes {
    static let Student = "student"
}

let screenSize = UIScreen.main.bounds.size


