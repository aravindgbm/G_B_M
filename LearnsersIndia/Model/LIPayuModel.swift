//
//  LIPayuModel.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 26/06/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class LIPayuModel: NSObject {
    var payuHash:String?
    var payuMerchantId:String?
    var payuKey:String?
    var payuTransactionId:String?
    var amount:String?
    var payuProductName:String?
    var firstName:String?
    var email:String?
    var phone:String?
//    var udf1:Int?
//    var udf2:Int?
//    var udf3:Int?
//    var udf4:Int?
//    var udf5:Int?
    var udf1:String?
    var udf2:String?
    var udf3:String?
    var udf4:String?
    var udf5:String?
    
    override init() {
        super.init()
    }
    convenience init?(_ response:[String:Any]) {
        self.init()
        if let _ = response["result"] as? String {
            self.payuHash = response["result"] as? String
            self.payuMerchantId = response["MerchantId"] as? String
            self.payuKey = response["key"] as? String
            self.payuTransactionId = response ["txnId"] as? String
            self.amount = response["amount"] as? String
            self.payuProductName = response["productName"] as? String
            self.firstName = response["firstName"] as? String
            self.email = response["email"] as? String
            self.phone = response["phone"] as? String
//            self.udf1 = response["udf1"] as? Int
//            self.udf2 = response["udf2"] as? Int
//            self.udf3 = response["udf3"] as? Int
//            self.udf4 = response["udf4"] as? Int
//            self.udf5 = response["udf5"] as? Int
            if let _ = response["udf1"] as? String {
                self.udf1 = response["udf1"] as? String
            }
            else if let udf = response["udf1"] as? Int {
                self.udf1 = String(udf)
            }
            
            if let _ = response["udf2"] as? String {
                self.udf2 = response["udf2"] as? String
            }
            else if let udf = response["udf2"] as? Int {
                self.udf2 = String(udf)
            }
            
            if let _ = response["udf3"] as? String {
               self.udf3 = response["udf3"] as? String
            }
            else if let udf = response["udf3"] as? Int {
                self.udf3 = String(udf)
            }
            
            if let _ = response["udf4"] as? String{
                 self.udf4 = response["udf4"] as? String
            }
            else if let udf = response["udf4"] as? Int {
                self.udf4 = String(udf)
            }
            
            if let _ = response["udf5"] as? String{
                self.udf5 = response["udf5"] as? String
            }
            else if let udf = response["udf5"] as? Int {
                self.udf5 = String(udf)
            }
        }
        else {
            return nil
        }
    }
}


