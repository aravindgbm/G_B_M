//
//  LIPaymentPackageModel.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 25/06/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class LIPaymentPackageModel: NSObject {
    var packageId:Int?
    var packageTitle:String?
    var packageDescription:String?
    var packageINROfferAmount:Int?
    var packageINRAmount:Int?
    var packageUSDOfferAmount:Int?
    var packageUSDAmount:Int?
    var packageKWDOfferAmount:Int?
    var packageKWDAmount:Int?
    var packageAEDOfferAmount:Int?
    var packageAEDAmount:Int?
    var packageImageUrl:String?
    
    override init() {
        super.init()
    }
    convenience init?(_ response:[String:Any]) {
        self.init()
        if let id = response["package_id"] as? Int {
            self.packageId = id
            self.packageTitle = response["package_title"]  as? String
            self.packageDescription = response["package_desc"] as? String
            self.packageINROfferAmount = response["package_price_offer"] as? Int
            self.packageINRAmount = response["package_price"] as? Int
            self.packageUSDOfferAmount = response["package_price_usd_offer"] as? Int
            self.packageUSDAmount = response["package_price_usd"] as? Int
            self.packageKWDOfferAmount = response["package_price_kwd_offer"] as? Int
            self.packageKWDAmount = response["package_price_kwd"] as? Int
            self.packageAEDOfferAmount = response["package_price_aed_offer"] as? Int
            self.packageAEDAmount = response["package_price_aed"] as? Int
            self.packageImageUrl = LIImageBaseUrlString + (response["package_image"] as? String ?? "")
        }
        else {
            return nil
        }
    }
}
