//
//  YourBoardViewController.swift
//  LearnsersIndia
//
//  Created by macbook on 12/03/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

var selectedBoardID = Int()
var selectedBorad = String()

class YourBoardViewController: UIViewController,navigateProtocol {
    
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
    
    

    @IBOutlet weak var tableview: UITableView!
    
    var url = "https://appapi.learnersindia.com/get-board"
    var iconArray = [String]()
    var syl_idArray = [Int]()
    var syllabusArray = [String]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.callGetBoardAPI()
//        Post_Call_YourBoard(urlString: url, paramters: ["":""]) { (isFinished) in
//            if isFinished
//            {
//                print("Finished")
//                ActivityIndicator.dismissActivityView()
//            }
//        }
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
//        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func loginButton(_ sender: Any)
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "UserTypePopUpViewController") as! UserTypePopUpViewController
        loginORSign = "login"
        vc.delegate = self
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    
//    func Get_WebCall()
//    {
//
//        let params = ["":""]
//        
//        R_Webservice.Get_Call(urlString: url, parameters: params) { (isFinished, jsonResponse) in
//            
//            if isFinished
//            {
//                R_Helper.ActivityIndicatory(uiView: self.view, status: .hide)
//                
//                if jsonResponse?.status == true
//                {
//                    
//                    let array = jsonResponse
//                    
//                    let jsonDictionary = jsonResponse?.object as! NSDictionary
//                    
//                    let jsonData = jsonDictionary["Data"] as! NSDictionary // Contains city id and city name
//                    
//                    self.RedeemableCouponString = jsonData.object(forKey: "RedeemableCoupon") as! String
//                    
//                    self.SubscriptionDic = jsonData.object(forKey: "Subscription") as! NSDictionary
//                    self.status = self.SubscriptionDic.object(forKey: "status") as! Bool
//                    self.isScheduled = self.SubscriptionDic.object(forKey: "scheduled") as! Bool
//                    self.delivery_dateString = self.SubscriptionDic.object(forKey: "delivery_date") as! String
//                    //   self.delivery_dayString = self.SubscriptionDic.object(forKey: "delivery_day") as! String
//                    self.countdown_days = self.SubscriptionDic.object(forKey: "countdown_days") as! Int
//                    
//                    self.water_consuptionDic = jsonData.object(forKey: "water_consuption") as! NSDictionary
//                    self.total_target = self.water_consuptionDic.object(forKey: "total_target") as! Int
//                    self.total_consume = self.water_consuptionDic.object(forKey: "total_consume") as! Int
//                    
//                    
//                    self.assignValuesFromBackend()
//                    
//                }
//            }
//        }
//        
//        
//    }
//    
//    
//    
//    
//
    func callGetBoardAPI() {
//        LIAPIClient.sharedInstance.callRequest(nil, httpMethod: .get, shouldAddParams: false, urlString: <#T##String#>, shouldAddHeaderParams: false, successBlock: { (response) in
//
//        }, failureBlock: { (response) in
//
//        }) { (error) in
//
//        }
        LIAuthenticationAPIsHandler.callGetBoardAPIWith(nil, success: { (reponse) in
            
        }, failure: { (response) in
            
        }) { (error) in
            
        }
    }
    
    func Post_Call_YourBoard(urlString: String, paramters: [String: Any], completion: @escaping(Bool) -> Void)
    {
        print(" Post Call Url \(urlString) \n Parameters \(paramters)")
        
        ActivityIndicator.setUpActivityIndicator(baseView: self.view)
        Alamofire.request(urlString, method: .get, parameters: paramters, headers: nil).responseJSON { (response) in
           
            switch(response.result)
            {
            case .success(_):
                
                if response.result.value != nil
                {
                    if let responseArray:NSArray = response.result.value as? NSArray
                    {
                        print(responseArray)
                        self.arrangeValues(array: responseArray)

                    }
                }
                
                break
                
            case .failure(_):
                print("Post call Failed \(response.result.error as Any)")
                completion(false)
                break
                
             
            }
            
            ActivityIndicator.dismissActivityView()
        }
    }
//    (
//    {
//    icon = "cbse_board.png";
//    "syl_id" = 1;
//    syllabus = CBSE;
//    },
//    {
//    icon = "kerala_board.png";
//    "syl_id" = 3;
//    syllabus = "Kerala State Board";
//    },
//    {
//    icon = "tn_board.png";
//    "syl_id" = 4;
//    syllabus = "Tamil State Board ";
//    }
//    )
//
//
    
    func arrangeValues(array:NSArray)
    {
        iconArray = [String]()
        for i in array
        {
           let dic = i as! NSDictionary
          if let pic = dic.object(forKey: "icon") as? String
          {
            iconArray.append("https://appapi.learnersindia.com/board/"+pic)

          }
            else
          {
            iconArray.append("")
            }
            
            syl_idArray.append(dic.object(forKey: "syl_id") as? Int ?? -1 )
            syllabusArray.append(dic.object(forKey: "syllabus") as? String ?? "")

        }
        self.tableview.reloadData()
        ActivityIndicator.dismissActivityView()
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
extension YourBoardViewController : UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
       return iconArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YourBoardTableViewCell", for: indexPath) as! YourBoardTableViewCell
        
        cell.label.text = syllabusArray[indexPath.row]
        Alamofire.request(iconArray[indexPath.row]).responseData { (response) in
            if response.error == nil {
                print(response.result)
                
                // Show the downloaded image:
                if let data = response.data
                {
                    cell.imageview.image = UIImage(data: data)
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        selectedBoardID = syl_idArray[indexPath.row]
        selectedBorad = syllabusArray[indexPath.row]
        UserDefaults.standard.set(selectedBoardID, forKey: "selectedBoardID")
        let vc = storyboard?.instantiateViewController(withIdentifier: "YourGradeViewController") as! YourGradeViewController
//        self.present(vc, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return tableview.frame.size.height/3.74
    }
}




