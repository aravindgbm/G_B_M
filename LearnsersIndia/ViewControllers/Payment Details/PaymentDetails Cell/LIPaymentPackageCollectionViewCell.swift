//
//  LIPaymentDetailsCollectionViewCell.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 25/06/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

protocol paymentPackageCellDelegate:class {
    func startPaymentProcessForPackage(_ package:LIPaymentPackageModel?)
}

class LIPaymentPackageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var packageImageView: UIImageView!
    @IBOutlet weak var packageAmountINRLabel: UILabel!
    @IBOutlet weak var packageAmountAEDLabel: UILabel!
    @IBOutlet weak var packageAmountKWDLabel: UILabel!
    @IBOutlet weak var packageAmountUSDLabel: UILabel!
    @IBOutlet weak var packageTitleLabel: UILabel!
    weak var delegate:paymentPackageCellDelegate?
    
    var paymentPackageObject:LIPaymentPackageModel?
    func refreshCellWith(_ package:LIPaymentPackageModel?){
        self.paymentPackageObject = package
        self.packageImageView.setImageWith(self.paymentPackageObject?.packageImageUrl, and: nil)
        self.packageTitleLabel.text = self.paymentPackageObject?.packageTitle
        self.packageAmountINRLabel.attributedText = LIUtilities.getPackageAmountStringWith(self.paymentPackageObject?.packageINRAmount, and: self.paymentPackageObject?.packageINROfferAmount, and: LIPackageDenominationType.AED)
        
        self.packageAmountAEDLabel.attributedText = LIUtilities.getPackageAmountStringWith(self.paymentPackageObject?.packageAEDAmount, and: self.paymentPackageObject?.packageAEDOfferAmount, and: LIPackageDenominationType.AED)
       
        self.packageAmountKWDLabel.attributedText = LIUtilities.getPackageAmountStringWith(self.paymentPackageObject?.packageKWDAmount, and: self.paymentPackageObject?.packageKWDOfferAmount, and: LIPackageDenominationType.AED)
        self.packageAmountUSDLabel.attributedText = LIUtilities.getPackageAmountStringWith(self.paymentPackageObject?.packageUSDAmount, and: self.paymentPackageObject?.packageUSDOfferAmount, and: LIPackageDenominationType.AED)
        
    }
    
    @IBAction func checkOutButtonTapped(_ sender: Any) {
        self.delegate?.startPaymentProcessForPackage(self.paymentPackageObject)
    }
}
