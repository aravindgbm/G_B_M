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
    var udf6:String?
    var udf7:String?
    var udf8:String?
    var udf9:String?
    var udf10:String?
    
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
            
            else {
                self.udf1 = ""
            }
            
            if let _ = response["udf2"] as? String {
                self.udf2 = response["udf2"] as? String
            }
            else if let udf = response["udf2"] as? Int {
                self.udf2 = String(udf)
            }
            else {
                self.udf2 = ""
            }
            
            if let _ = response["udf3"] as? String {
               self.udf3 = response["udf3"] as? String
            }
            else if let udf = response["udf3"] as? Int {
                self.udf3 = String(udf)
            }
            
            else {
                self.udf3 = ""
            }
            
            if let _ = response["udf4"] as? String{
                 self.udf4 = response["udf4"] as? String
            }
            else if let udf = response["udf4"] as? Int {
                self.udf4 = String(udf)
            }
            
            else {
                self.udf4 = ""
            }
            
            if let _ = response["udf5"] as? String{
                self.udf5 = response["udf5"] as? String
            }
            else if let udf = response["udf5"] as? Int {
                self.udf5 = String(udf)
            }
            else {
                self.udf5 = ""
            }
            
            
            if let _ = response["udf6"] as? String{
                self.udf6 = response["udf6"] as? String
            }
            else if let udf = response["udf6"] as? Int {
                self.udf6 = String(udf)
            }
                
            else {
                self.udf6 = ""
            }
            
            
            if let _ = response["udf7"] as? String{
                self.udf7 = response["udf7"] as? String
            }
            else if let udf = response["udf7"] as? Int {
                self.udf7 = String(udf)
            }
                
            else {
                self.udf7 = ""
            }
            
            
            if let _ = response["udf8"] as? String{
                self.udf8 = response["udf8"] as? String
            }
            else if let udf = response["udf8"] as? Int {
                self.udf8 = String(udf)
            }
                
            else {
                self.udf8 = ""
            }
            
            
            if let _ = response["udf9"] as? String{
                self.udf9 = response["udf9"] as? String
            }
            else if let udf = response["udf9"] as? Int {
                self.udf9 = String(udf)
            }
                
            else {
                self.udf9 = ""
            }
            
            if let _ = response["udf10"] as? String{
                self.udf10 = response["udf10"] as? String
            }
            else if let udf = response["udf10"] as? Int {
                self.udf10 = String(udf)
            }
                
            else {
                self.udf10 = ""
            }
            
        }
        else {
            return nil
        }
    }
}


