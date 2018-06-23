//
//  LIAPIConstants.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 20/05/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class LIAPIConstants: NSObject {
static let sharedInstance = LIAPIConstants()
}
public let HTTP_STATUS_OK              = 200
public let HTTP_STATUS_UNASSIGNED      = 299
public let HTTP_STATUS_UNAUTHORIZED    = 401
public let HTTP_STATUS_BAD_REQUEST     = 400
//public let LIBaseUrlString = "https://appapi.learnersindia.com/"
public let LIBaseUrlString = "http://apistaging.learnersindia.com/"
public let LIImageBaseUrlString = "https://www.learnersindia.com/"

struct LIAPIURL{
    static let signUpURL = "signup"
    static let signInURL = "signin"
    static let forgotPasswordURL = ""
    static let logOutURL = ""
    static let getBoardURL = "get-board"
    static let getClassURL = "get-class"
    static let validateOTP = "validate-otp-student-signup"
    static let resendOTP = "resend-otp-student-signup"
    static let sendOTPForPasswordRecoveryURL = "send-otp-student-password-recovery"
    static let validateOTPForPasswordRecoveryURL = "validate-otp-student-password-recovery"
    static let resetPasswordURL = "reset-password-student"
    static let getDemoVideosURL = "get-free-videos"
    static let getRecommendedQuestionsURL = "reccomented-questions"
    static let checkPaidStatus = "check-paid-status"
    static let getUserProfile = "get-user-profile"
    static let getChaptersUrl = "get-chapters"
    static let getVideosUrl = "get-videos"
    static let getExercisesUrl = "get-exercises"
    static let getTestQuestionsUrl = "get-testpaper-questions"
    static let getGameLevelUrl = "get-game-level"
    static let getGameQuestionUrl = "get-game-question"
}

struct LIAPIResponseKeys {
    static let responseCode = "response_code"
    static let responseData = "response_data"
    static let responseType = "response_type"
    static let responseText = "response_text"
    static let videoData = "video_data"
    static let questionsData = "questions_data"
    static let userData = "user_data"
    static let chaptersData = "chapters_data"
    static let exercisesData = "exercises_data"
    static let questionData = "question_data"
}
struct LIAPIRequestKeys {
    static let token = "tocken"
}
