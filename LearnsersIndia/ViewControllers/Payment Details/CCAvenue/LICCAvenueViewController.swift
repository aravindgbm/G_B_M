//
//  LICCAvenueViewController.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 22/07/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit
protocol CCAvenuePaymentDelegate:class {
    func sendCCAvenueResponse(_ response:[String:Any])

}
class LICCAvenueViewController: UIViewController {
    var CCAvenueObject:LICCAvenueModel?
    static var statusCode = 0
    weak var delegate:CCAvenuePaymentDelegate?
    var request = NSMutableURLRequest()
    lazy var viewWeb: UIWebView = {
        let webView = UIWebView()
        webView.frame = self.view.bounds
        webView.backgroundColor = .white
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.delegate = self
        webView.scalesPageToFit = true
        webView.contentMode = UIViewContentMode.scaleAspectFill
        return webView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupWebView()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        self.getRsaKey { (success, response) in
//            if success {
//                if let responseData = response as? Data {
//                    self.encyptCardDetails(data: responseData)
//                }
//                else {
//
//                    LIUtilities.showErrorAlertControllerWith(LIConstants.tryAgainMessage, onViewController: self)
//                }
//            }
//            else{
//                LIUtilities.showErrorAlertControllerWith(response as? String, onViewController: self)
//            }
//        }
        self.encyptCardDetailsWithRSA()
//        self.callPaymentInitiateApi()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ActivityIndicator.setUpActivityIndicator(baseView: self.view)
    }
    private func setupWebView(){
        
        //setup webview
        view.addSubview(viewWeb)
        if #available(iOS 11.0, *) {
            viewWeb.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            viewWeb.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        } else {
            // Fallback on earlier versions
            viewWeb.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            viewWeb.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
        
        viewWeb.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        
        viewWeb.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        _ = [viewWeb .setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1000), for: UILayoutConstraintAxis.vertical)]
    }
    
    
    // MARK: - IBActions
    @IBAction func backButtonTapped(_ sender: Any) {
        ActivityIndicator.dismissActivityView()
        self.showPaymentQuitAlert()
    }
    func showPaymentQuitAlert(){
        let alert = UIAlertController(title: "", message: LIConstants.transactionQuitAlertMessage, preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(yesAction)
        let noAction = UIAlertAction(title: "No", style: .default, handler: nil)
        alert.addAction(noAction)
   
        self.present(alert, animated: true, completion: nil)
    
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

extension LICCAvenueViewController {
    
    private func getRsaKey(completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()){
        
        let serialQueue = DispatchQueue(label: "serialQueue", qos: .userInitiated)
        
        serialQueue.sync {
            self.CCAvenueObject?.rsaKeyDataStr = "access_code=\(self.CCAvenueObject?.accessCode ?? "")&order_id=\(self.CCAvenueObject?.orderId ?? "")"
            //            let requestData = self.rsaKeyDataStr.data(using: String.Encoding.utf8, allowLossyConversion: true)
            
            let requestData = self.CCAvenueObject?.rsaKeyDataStr.data(using: String.Encoding.utf8)
            if let _ = self.CCAvenueObject {
                guard let urlFromString = URL(string: (self.CCAvenueObject?.rsaKeyUrl)!) else{
                    return
                }
                var urlRequest = URLRequest(url: urlFromString)
                urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content-type")
                urlRequest.httpMethod = "POST"
                urlRequest.httpBody = requestData
                
                let session = URLSession(configuration: URLSessionConfiguration.default)
                print("session",session)
                
                
                session.dataTask(with: urlRequest as URLRequest) {
                    (data, response, error) -> Void in
                    
                    if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode{
                        
                        guard let data = data else{
                            print("No value for data")
                            completion(false, "Not proper data for RSA Key" as AnyObject?)
                            return
                        }
                        print("data :: ",data)
                        completion(true, data as AnyObject?)
                    }
                    else{
                        completion(false, "Unable to generate RSA Key please check" as AnyObject?)
                    }
                    }.resume()
            }
            else {
                return
            }
        }
    }
    
    private func encyptCardDetails(data: Data){
        guard let rsaKeytemp = String(bytes: data, encoding: String.Encoding.ascii) else{
            print("No value for rsaKeyTemp")
            return
        }
        self.CCAvenueObject?.rsaKey = rsaKeytemp
        if let _ = self.CCAvenueObject {
            self.CCAvenueObject?.rsaKey =  self.CCAvenueObject!.rsaKey.trimmingCharacters(in: CharacterSet.newlines)
            self.CCAvenueObject?.rsaKey =  "-----BEGIN PUBLIC KEY-----\n\(self.CCAvenueObject!.rsaKey)\n-----END PUBLIC KEY-----\n"
            print("rsaKey :: ", self.CCAvenueObject!.rsaKey)
            
            let myRequestString = "amount=\( self.CCAvenueObject!.amount)&currency=\( self.CCAvenueObject!.currency)"
            
            let ccTool = CCTool()
            var encVal = ccTool.encryptRSA(myRequestString, key: self.CCAvenueObject?.rsaKey)
            
            encVal = CFURLCreateStringByAddingPercentEscapes(
                nil,
                encVal! as CFString,
                nil,
                "!*'();:@&=+$,/?%#[]" as CFString,
                CFStringBuiltInEncodings.UTF8.rawValue) as String?
            LICCAvenueViewController.statusCode = 0
            
            //Preparing for webview call
            if LICCAvenueViewController.statusCode == 0{
                let urlAsString = "https://secure.ccavenue.com/transaction/initTrans"
                let encryptedStr = "merchant_id=\(self.CCAvenueObject!.merchantId)&order_id=\(self.CCAvenueObject!.orderId)&redirect_url=\(self.CCAvenueObject!.redirectUrl)&cancel_url=\(self.CCAvenueObject!.cancelUrl)&enc_val=\(encVal!)&access_code=\(self.CCAvenueObject!.accessCode)"
                
                print("encValue :: \(encVal ?? "No val for encVal")")
                
                print("encryptedStr :: ",encryptedStr)
                let myRequestData = encryptedStr.data(using: String.Encoding.utf8)
                // request = NSMutableURLRequest(url: URL(string: urlAsString)!)
                
                request = NSMutableURLRequest(url: URL(string: urlAsString)! as URL, cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 30)
                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content-type")
                request.setValue(urlAsString, forHTTPHeaderField: "Referer")
                request.httpMethod = "POST"
                request.httpBody = myRequestData
                print("\n\n\nwebview :: ",request.url as Any)
                print("\n\n\nwebview :: ",request.description as Any)
                print("\n\n\nwebview :: ",request.httpBody?.description as Any)
                print("\n\n\nwebview :: ",request.allHTTPHeaderFields! as Any)
                
                let session = URLSession(configuration: URLSessionConfiguration.default)
                print("session",session)
                
                session.dataTask(with: request as URLRequest) {
                    (data, response, error) -> Void in
                    
                    if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode{
                        
                        guard let data = data else{
                            print("No value for data")
                            return
                        }
                        DispatchQueue.main.async {
                            self.viewWeb.loadRequest(self.request as URLRequest)
                        }
                        print("data :: ",data)
                    }
                    else{
                        print("into else")
                        //                        self.displayAlert(msg: "Unable to load webpage currently, Please try again later.")
                        LIUtilities.showErrorAlertControllerWith(LIConstants.tryAgainMessage, onViewController: self)
                    }
                    }.resume()
                
                //                print(viewWeb.isLoading)
            }
            else{
                print("Unable to create requestURL")
                LIUtilities.showErrorAlertControllerWith(LIConstants.tryAgainMessage, onViewController: self)
            }
        }
        else {
            LIUtilities.showErrorAlertControllerWith(LIConstants.tryAgainMessage, onViewController: self)
        }
        
    }
    
    func callPaymentInitiateApi(){
//        let urlAsString = "https://secure.ccavenue.com/transaction/initTrans"
        
        if  let urlAsString = self.CCAvenueObject?.postUrl {
            //        print("encValue :: \(encVal ?? "No val for encVal")")
            //
            //        print("encryptedStr :: ",encryptedStr)
            
            let myRequestData = self.CCAvenueObject?.encryptedRequest.data(using: String.Encoding.utf8)
            // request = NSMutableURLRequest(url: URL(string: urlAsString)!)
            
            request = NSMutableURLRequest(url: URL(string: urlAsString)! as URL, cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 30)
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content-type")
            request.setValue(urlAsString, forHTTPHeaderField: "Referer")
            request.httpMethod = "POST"
            request.httpBody = myRequestData
            print("\n\n\nwebview :: ",request.url as Any)
            print("\n\n\nwebview :: ",request.description as Any)
            print("\n\n\nwebview :: ",request.httpBody?.description as Any)
            print("\n\n\nwebview :: ",request.allHTTPHeaderFields! as Any)
            
            let session = URLSession(configuration: URLSessionConfiguration.default)
            print("session",session)
            
            session.dataTask(with: request as URLRequest) {
                (data, response, error) -> Void in
                
                if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode{
                    
                    guard let data = data else{
                        print("No value for data")
                        return
                    }
                    DispatchQueue.main.async {
                        self.viewWeb.loadRequest(self.request as URLRequest)
                    }
                    print("data :: ",data)
                }
                else{
                    print("into else")
                    //                        self.displayAlert(msg: "Unable to load webpage currently, Please try again later.")
                    LIUtilities.showErrorAlertControllerWith(LIConstants.tryAgainMessage, onViewController: self)
                }
                }.resume()
        }
        
        else {
            LIUtilities.showErrorAlertControllerWith(LIConstants.tryAgainMessage, onViewController: self)
        }
        
    }
    
    private func encyptCardDetailsWithRSA(){
        
        guard let _ = self.CCAvenueObject, let _ = self.CCAvenueObject?.rsaKey
            else {
                LIUtilities.showErrorAlertControllerWith(LIConstants.tryAgainMessage, onViewController: self)
                return
        }
            self.CCAvenueObject?.rsaKey =  self.CCAvenueObject!.rsaKey.trimmingCharacters(in: CharacterSet.newlines)
            self.CCAvenueObject?.rsaKey =  "-----BEGIN PUBLIC KEY-----\n\(self.CCAvenueObject!.rsaKey)\n-----END PUBLIC KEY-----\n"
            print("rsaKey :: ", self.CCAvenueObject!.rsaKey)
            
            let myRequestString = "amount=\( self.CCAvenueObject!.amount)&currency=\( self.CCAvenueObject!.currency)"
            
            let ccTool = CCTool()
            var encVal = ccTool.encryptRSA(myRequestString, key: self.CCAvenueObject?.rsaKey)
            
            encVal = CFURLCreateStringByAddingPercentEscapes(
                nil,
                encVal! as CFString,
                nil,
                "!*'();:@&=+$,/?%#[]" as CFString,
                CFStringBuiltInEncodings.UTF8.rawValue) as String?
            LICCAvenueViewController.statusCode = 0
            
            //Preparing for webview call
            if LICCAvenueViewController.statusCode == 0{
                let urlAsString = "https://secure.ccavenue.com/transaction/initTrans"
                let encryptedStr = "merchant_id=\(self.CCAvenueObject!.merchantId)&order_id=\(self.CCAvenueObject!.orderId)&redirect_url=\(self.CCAvenueObject!.redirectUrl)&cancel_url=\(self.CCAvenueObject!.cancelUrl)&enc_val=\(encVal!)&access_code=\(self.CCAvenueObject!.accessCode)"
                
                print("encValue :: \(encVal ?? "No val for encVal")")
                
                print("encryptedStr :: ",encryptedStr)
                let myRequestData = encryptedStr.data(using: String.Encoding.utf8)
                // request = NSMutableURLRequest(url: URL(string: urlAsString)!)
                
                request = NSMutableURLRequest(url: URL(string: urlAsString)! as URL, cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 30)
                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content-type")
                request.setValue(urlAsString, forHTTPHeaderField: "Referer")
                request.httpMethod = "POST"
                request.httpBody = myRequestData
                print("\n\n\nwebview :: ",request.url as Any)
                print("\n\n\nwebview :: ",request.description as Any)
                print("\n\n\nwebview :: ",request.httpBody?.description as Any)
                print("\n\n\nwebview :: ",request.allHTTPHeaderFields! as Any)
                
                let session = URLSession(configuration: URLSessionConfiguration.default)
                print("session",session)
                
                session.dataTask(with: request as URLRequest) {
                    (data, response, error) -> Void in
                    
                    if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode{
                        
                        guard let data = data else{
                            print("No value for data")
                            return
                        }
                        DispatchQueue.main.async {
                            self.viewWeb.loadRequest(self.request as URLRequest)
                        }
                        print("data :: ",data)
                    }
                    else{
                        print("into else")
                        //                        self.displayAlert(msg: "Unable to load webpage currently, Please try again later.")
                        LIUtilities.showErrorAlertControllerWith(LIConstants.tryAgainMessage, onViewController: self)
                    }
                    }.resume()
                
                //                print(viewWeb.isLoading)
            }
            else{
                print("Unable to create requestURL")
                LIUtilities.showErrorAlertControllerWith(LIConstants.tryAgainMessage, onViewController: self)
            }
        
    }
    
}




extension LICCAvenueViewController: UIWebViewDelegate {
    //MARK: WebviewDelegate Methods
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        print("webViewDidStartLoad",webView.request!)
        print(viewWeb.isLoading)
        //        print(request?.httpBodyStream as Any)
        //        print(request?.httpBody as Any)
        
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print("Failed to load  webview")
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
       ActivityIndicator.dismissActivityView()
        
        //covert the response url to the string and check for that the response url contains the redirect/cancel url if true then chceck for the transaction status and pass the response to the result controller(ie. CCResultViewController)
        let string = (webView.request?.url?.absoluteString)!
        print("String :: \(string)")
        if let _ = self.CCAvenueObject {
            if(string.contains(self.CCAvenueObject!.redirectUrl)) //("http://122.182.6.216/merchant/ccavResponseHandler.jsp"))//
            {
                print(viewWeb.isLoading)
                guard let htmlTemp:NSString = webView.stringByEvaluatingJavaScript(from: "document.documentElement.outerHTML") as NSString? else{
                    print("failed to evaluate javaScript")
                    return
                }
                
                let html = htmlTemp
                print("html :: ",html)
                var transStatus = "Not Known"
                
                if ((html ).range(of: "tracking_id").location != NSNotFound) && ((html ).range(of: "bin_country").location != NSNotFound) {
                    if ((html ).range(of: "Aborted").location != NSNotFound) || ((html ).range(of: "Cancel").location != NSNotFound) {
                        transStatus = "Transaction Cancelled"
                        //                    let controller: CCResultViewController = CCResultViewController()
                        //                    controller.transStatus = transStatus
                        //                    self.present(controller, animated: true, completion: nil)
                    }
                    else if ((html ).range(of: "Success").location != NSNotFound) {
                        transStatus = "Transaction Successful"
                        //                    let controller: CCResultViewController = CCResultViewController()
                        //                    controller.transStatus = transStatus
                        //                    self.present(controller, animated: true, completion: { _ in })
                    }
                    else if ((html ).range(of: "Fail").location != NSNotFound) {
                        transStatus = "Transaction Failed"
                        //                    let controller: CCResultViewController = CCResultViewController()
                        //                    controller.transStatus = transStatus
                        //                    self.present(controller, animated: true, completion: { _ in })
                    }
                }
                else{
                    print("html does not contain any related data")
                    LIUtilities.showErrorAlertControllerWith(LIConstants.tryAgainMessage, onViewController: self)
                    //                displayAlert(msg: "html does not contain any related data for this transaction.")
                }
            }
            
        }
        else {
            LIUtilities.showErrorAlertControllerWith(LIConstants.tryAgainMessage, onViewController: self)
        }
    }
}
