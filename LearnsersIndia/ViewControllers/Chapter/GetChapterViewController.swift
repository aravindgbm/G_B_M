//
//  GetChapterViewController.swift
//  LearnsersIndia
//
//  Created by Appzoc-Macmini on 22/03/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit
import Alamofire

class GetChapterViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    
    let url = "https://appapi.learnersindia.com/get-chapters"
    var chapters_dataArray = [NSDictionary]()
    var chapterArray = [String]()
    var chp_idArray = [Int]()
    var type = 0
    
    /*
 
     "chp_id": 19,
     "syl_id": 1,
     "cls_id": 9,
     "sub_id": 1,
     "chapter": "Chapter 1 / Number Systems",
     "boardname": "CBSE",
     "gradename": "Class 9",
     "subjectname": "Maths"
     
 */
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool)
    {
        video_dataArray.removeAll()
        topic_nameArray.removeAll()
        topic_idArray.removeAll()
        
//        ActivityIndicator.setUpActivityIndicator(baseView: self.view)
//        self.Get_ChapterWebCall(urlString: url) { (_) in
//            
//        }
        self.callGetChapterApi()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButton(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
      // self.dismiss(animated: true, completion: nil)
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


extension GetChapterViewController
{

    
    func callGetChapterApi() {
        let paramters = ["tocken":tocken,
                         "syl_id":selectedBoardID,
                         "class_id":selectedCls_id,
                         "sub_id":"1"] as [String : AnyObject]
        LIAPIClient.sharedInstance.callRequest(paramters, httpMethod: .post, shouldAddParams: true, urlString: "get-chapters", shouldAddHeaderParams: false, successBlock: { (reponse) in
             if let responseDict = reponse {
                
                if let chaptersArray = responseDict["chapters_data"] as? [NSDictionary] {
                    self.chapters_dataArray = chaptersArray
                    
                    for i in self.chapters_dataArray
                    {
                        if let dic = i as? NSDictionary
                        {
                            self.chp_idArray.append(i.object(forKey: "chp_id") as? Int ?? -1)
                            self.chapterArray.append(i.object(forKey: "chapter") as? String ?? "")
                        }
                    }
                    
                    self.tableview.reloadData()
                }
            }
            
        }, failureBlock: { (reponse) in
            if let responseDict = reponse {
                if let message = responseDict["response_text"] as? String {
                    let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
          
        }) { (error) in
            
        }
    }
    
    
    
    func Get_ChapterWebCall(urlString: String, completion: @escaping(Bool) -> Void)
    {
        print(tocken)
        print(selectedBoardID)
        print(selectedCls_id)
        
        let paramters = ["tocken":tocken,
                         "syl_id":selectedBoardID,
                         "class_id":selectedCls_id,
                         "sub_id":"1"] as [String : Any]
 
        Alamofire.request(urlString, method: .post, parameters: paramters, headers: nil).responseJSON { (response) in
 
            ActivityIndicator.dismissActivityView()
            switch(response.result)
            {
            case .success(_):
                if response.result.value != nil
                {
                    if let responseDic:NSDictionary = response.result.value as? NSDictionary
                    {
                        print(responseDic)
                        if responseDic.object(forKey: "response_type") as! String == "error"
                        {
                            let message = responseDic.object(forKey: "response_text") as! String
                            let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                        else
                        {
                            self.chapters_dataArray = responseDic.object(forKey: "chapters_data") as! Array
                            for i in self.chapters_dataArray
                            {
                               if let dic = i as? NSDictionary
                               {
                                self.chp_idArray.append(i.object(forKey: "chp_id") as? Int ?? -1)
                                self.chapterArray.append(i.object(forKey: "chapter") as? String ?? "")
                                }
                            }
                            
                            self.tableview.reloadData()
                            
                            
                        }
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
}




extension GetChapterViewController : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return chapters_dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GetChapterTableViewCell", for: indexPath) as! GetChapterTableViewCell
        
        if let chapterName = self.chapterArray[indexPath.row] as? String
        {
            cell.label.text = chapterName
        }
        else
        {
            cell.label.text = ""
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        let height = self.view.frame.size.height
        let rowheight = height/8.47
        return rowheight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        print(type)
        
        if type == 1
        {
            let vc = storyboard?.instantiateViewController(withIdentifier: "SessionVideoViewController") as! SessionVideoViewController
            vc.selectedChapterId = self.chp_idArray[indexPath.row]
            vc.selectedChapterName = self.chapterArray[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
            
           // self.present(vc, animated: false, completion: nil)
        }
        else if type == 2
        {
            let vc = storyboard?.instantiateViewController(withIdentifier: "SampleExcerciseViewController") as! SampleExcerciseViewController
            vc.selectedChapterId = self.chp_idArray[indexPath.row]
            vc.selectedChapterName = self.chapterArray[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
            
           // self.present(vc, animated: false, completion: nil)
        }
        else if type == 3
        {
            let vc = storyboard?.instantiateViewController(withIdentifier: "TestStartViewController") as! TestStartViewController
            vc.selectedChapterId = self.chp_idArray[indexPath.row]
            vc.selectedChapterName = self.chapterArray[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
            
            // self.present(vc, animated: false, completion: nil)
        }

    }
    
    
}
