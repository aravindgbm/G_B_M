//
//  LICCAvenueModel.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 22/07/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class LICCAvenueModel: NSObject {

    var accessCode = String()
    var merchantId = String()
    var orderId = String()
    var amount = String()
    var currency = String()
    var redirectUrl = String()
    var cancelUrl = String()
    var rsaKeyUrl = String()
    var rsaKeyDataStr = String()
    var rsaKey = String()
    var encryptedRequest = String()
    var postUrl = String()
    var merchantParam1 = String()
    var merchantParam2 = String()
    override init() {
        super.init()
    }
    convenience init?(_ response:[String:Any]) {
        self.init()
        guard let accCode = response["access_code"] as? String,let amountDetails = response["amount"] as? String , let redirect_url = response["redirect_url"] as? String,  let currencyDetails = response["currency"] as? String, let cancel_url = response["cancel_url"] as? String, let merchant_id = response["merchant_id"] as? String, let order_id = response["order_id"] as? String, let post_url = response["form_url"] as? String, let rsa = response["RSAkey"] as? String, let merchant_param1 = response["merchant_param1"] as? String, let merchant_param2 = response["merchant_param2"] as? String
            else {
            return nil
        }

//        let encRequest = response["encRequest"] as? String
        self.accessCode = accCode
        self.amount = amountDetails
//        self.encryptedRequest = encRequest
        self.postUrl = post_url
        self.currency = currencyDetails
        self.merchantId = merchant_id
        self.orderId = order_id
        self.cancelUrl = cancel_url
        self.redirectUrl = redirect_url
        self.rsaKeyUrl = LICCAvenueConstants.rsaKeyUrl
        self.rsaKey = rsa
        self.merchantParam1 = merchant_param1
        self.merchantParam2 = merchant_param2
    }
}