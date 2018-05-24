//
//  YourGradeViewController.swift
//  LearnsersIndia
//
//  Created by Appzoc-Macmini on 13/03/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit
import Alamofire

var selectedCls_id = Int()
var selectedClass = String()

class YourGradeViewController: UIViewController,navigateProtocol {
    
    func loginNavigateFunction()
    {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//        self.present(vc, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func boardNavigateFunction()
    {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "YourBoardViewController") as! YourBoardViewController
//        self.present(vc, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func signUPNavigateFunction()
    {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
//        self.present(vc, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    

    @IBOutlet var tableview: UITableView!
    
    var url = "https://appapi.learnersindia.com/get-class"
    var cls_idArray = [Int]()
    var classArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
//        Post_Call_YourBoard(urlString: url, paramters: ["":""]) { (isFinished) in
//
//        }
        self.callGetClassApi()
        // Do any additional setup after loading the view.

    }
    
    override func viewWillAppear(_ animated: Bool)
    {
       
       
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func backButton(_ sender: Any)
    {
//       self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func loginButton(_ sender: Any)
    {
//        let vc = storyboard?.instantiateViewController(withIdentifier: "UserTypePopUpViewController") as! UserTypePopUpViewController
//        loginORSign = "login"
//        vc.delegate = self
//        self.navigationController?.present(vc, animated: true, completion: nil)
        //TODO: uncomment the above code and remove the bottom code for phase 2
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func callGetClassApi(){
        ActivityIndicator.setUpActivityIndicator(baseView: self.view)

        LIAuthenticationAPIsHandler.callGetClassAPIWith(nil, success: { (response) in
            ActivityIndicator.dismissActivityView()
            if let responseArray = response as NSArray? {
                 self.arrangeValues(array: responseArray)
            }
        }, failure: { (responseMessage) in
            ActivityIndicator.dismissActivityView()
            LIUtilities.showErrorAlertControllerWith(responseMessage, onViewController: self)
        }) { (error) in
            ActivityIndicator.dismissActivityView()
            LIUtilities.showErrorAlertControllerWith(error?.localizedDescription, onViewController: self)
        }
    }
    
//    func Post_Call_YourBoard(urlString: String, paramters: [String: Any], completion: @escaping(Bool) -> Void)
//    {
//        print(" Post Call Url \(urlString) \n Parameters \(paramters)")
//
//        ActivityIndicator.setUpActivityIndicator(baseView: self.view)
//        Alamofire.request(urlString, method: .get, parameters: paramters, headers: nil).responseJSON { (response) in
//
//            switch(response.result)
//            {
//            case .success(_):
//
//                if response.result.value != nil
//                {
//                    if let responseArray:NSArray = response.result.value as? NSArray
//                    {
//                        print(responseArray)
//                        self.arrangeValues(array: responseArray)
//
//                    }
//                }
//
//                break
//
//            case .failure(_):
//                print("Post call Failed \(response.result.error as Any)")
//                completion(false)
//                break
//
//
//            }
//            ActivityIndicator.dismissActivityView()
//        }
//    }
    
    
    func arrangeValues(array:NSArray)
    {
        classArray = [String]()
        cls_idArray = [Int]()
        for i in array
        {
            let dic = i as! NSDictionary
            cls_idArray.append(dic.object(forKey: "cls_id") as? Int ?? -1)
            classArray.append(dic.object(forKey: "grade") as? String ?? "")
        }
        tableview.reloadData()
    }
    
    
}

extension YourGradeViewController : UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return classArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YourBoardTableViewCell_1", for: indexPath) as! YourBoardTableViewCell
        
        cell.label.text = classArray[indexPath.row]

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        selectedCls_id = cls_idArray[indexPath.row]
        selectedClass = classArray[indexPath.row]
        UserDefaults.standard.set(selectedCls_id, forKey: "selectedCls_id")
        let vc = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
//        self.present(vc, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return tableview.frame.size.height/6.8
    }
    
}

