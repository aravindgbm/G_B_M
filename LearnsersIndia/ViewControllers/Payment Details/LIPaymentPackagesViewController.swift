//
//  LIPaymentDetailsViewController.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 25/06/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class LIPaymentPackagesViewController: UIViewController {

    @IBOutlet weak var paymentCollectionView: UICollectionView!
    var paymentPackagesArray:[LIPaymentPackageModel]?
    static let paymentCellIdentifier = "paymentPackageCell"
    var selectedPackage:LIPaymentPackageModel?
    var payuObject:LIPayuModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callPaymentPackagesApi()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func backButtonTapped(_ sender: Any) {
        
    }
    
    func updateTransactionParameters(){
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension LIPaymentPackagesViewController:paymentPackageCellDelegate {
    func startPaymentProcessForPackage(_ package: LIPaymentPackageModel?) {
        self.selectedPackage = package
        self.callGeneratePayuHashApi()
    }
}

extension LIPaymentPackagesViewController {
    func callPaymentPackagesApi(){
        ActivityIndicator.setUpActivityIndicator(baseView: self.view)
       
        LIUserStudentAPIsHandler.callPackagesAPIWith(nil, shouldAddToken: false, success: { (response) in
            ActivityIndicator.dismissActivityView()
            if let _ = response {
                self.paymentPackagesArray = response
                self.paymentCollectionView.reloadData()
            }
            else {
                
                LIUtilities.showErrorAlertControllerWith(LIConstants.tryAgainMessage, onViewController: self)
            }
        }, failure: { (responseMessage) in
            LIUtilities.showErrorAlertControllerWith(responseMessage, onViewController: self)
            ActivityIndicator.dismissActivityView()
        }) { (error) in
                LIUtilities.showErrorAlertControllerWith(error?.localizedDescription, onViewController:self)
            ActivityIndicator.dismissActivityView()
        }
    }
    
    func callGeneratePayuHashApi(){
        
        let parameters:[String:Any] = ["package_id":self.selectedPackage?.packageId as Any]
        ActivityIndicator.setUpActivityIndicator(baseView: self.view)
    
        LIUserStudentAPIsHandler.callGeneratePayuHashAPIWith(parameters, shouldAddToken: true, success: { (response) in
            ActivityIndicator.dismissActivityView()
            if let _ = response {
                self.payuObject = response
                self.updateTransactionParameters()
            }
            else {
                
                LIUtilities.showErrorAlertControllerWith(LIConstants.tryAgainMessage, onViewController: self)
            }
        }, failure: { (responseMessage) in
            ActivityIndicator.dismissActivityView()
            LIUtilities.showErrorAlertControllerWith(responseMessage, onViewController: self)
        }) { (error) in
            ActivityIndicator.dismissActivityView()
            LIUtilities.showErrorAlertControllerWith(error?.localizedDescription, onViewController:self)
        }
        
    }
}

extension LIPaymentPackagesViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.paymentPackagesArray?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LIPaymentPackagesViewController.paymentCellIdentifier, for: indexPath) as? LIPaymentPackageCollectionViewCell
        cell?.refreshCellWith(self.paymentPackagesArray?[indexPath.row])
        cell?.delegate = self
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: screenSize.width - 40, height: self.paymentCollectionView.frame.size.height)
        return size
    }
}
