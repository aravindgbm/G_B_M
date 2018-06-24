//
//  UserState.swift
//  AutoGradeVTS
//
//  Created by Appzoc on 03/02/18.
//  Copyright © 2018 Appzoc. All rights reserved.
//

import Foundation


class UserState {
    static let shared = UserState()
    private init(){}
    
    var user:UserData?
}
