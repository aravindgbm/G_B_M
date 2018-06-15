//
//  ExcerciseViewController.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 10/04/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit
import Alamofire

class ExcerciseViewController: UIViewController {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var tableview: UITableView!
    
    var questionArray = [String]()
    var solutionArray = [String]()
    var exercises_dataArray = [NSArray]()
    var selectedIndexpath = Int()
    var url = "https://appapi.learnersindia.com/get-exercises"
    var selectedChapterId = -1
    var selectedChapterName = ""
    
    var excerciseTopicIDArray = [Int]()
    var excerciseTopicNameArray = [String]()
    var sessionCountArray = [Int]()
    
    var responseData = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//
//        let htmlString: String = "<p>\r\n\t  Whether you are viewing a premium-quality 2D picture or seeing incredible 3D depth, images are breathtakingly real in Samsung Full HD. Combine with a 3D TV and 3D active shutter glasses to view the latest Hollywood 3D titles or amplify your viewing experience by upconverting 2D content to immersive 3D.\r\n</p>"
//        let data = htmlString.data(using: String.Encoding.unicode)! // mind "!"
//        let attrStr = try? NSAttributedString( // do catch
//            data: data,
//            options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
//            documentAttributes: nil)
//        // suppose we have an UILabel, but any element with NSAttributedString will do
//        yourlabel.attributedText = attrStr
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.headerLabel.text = self.selectedChapterName
        ActivityIndicator.setUpActivityIndicator(baseView: self.view)
        self.Get_ExcerciseWebCall(urlString: url) { (_) in
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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



extension ExcerciseViewController
{
    func Get_ExcerciseWebCall(urlString: String, completion: @escaping(Bool) -> Void)
    {
        print(tocken)
        print(selectedBoardID)
        print(selectedCls_id)
        
        let paramters = ["tocken":tocken,
                         "syl_id":selectedBoardID,
                         "class_id":selectedCls_id,
                         "sub_id":"1",
                         "chap_id":selectedChapterId] as [String : Any]
        
        Alamofire.request(urlString, method: .get, parameters: paramters, headers: nil).responseJSON { (response) in
            
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
   
                                print("///////////////")
        
                            self.responseData = responseDic.object(forKey: "response_data") as! NSArray
    
                            print(self.responseData.count)
                            print(self.responseData)
                                
                            for i in self.responseData
                                {
                                    let dic = i as! NSDictionary
                                    
                                    print(i)
                                    print(dic)
                                    
                                    self.excerciseTopicIDArray.append(dic.object(forKey: "topic_id") as! Int)
                                    self.excerciseTopicNameArray.append(dic.object(forKey: "topic_name") as! String)
                                    
                                    
                                    
                                    
                                    
                                    if let arrayI = dic.object(forKey: "exercises_data") as? NSArray
                                    {
                                        
                                        if arrayI.count != 0
                                        {
                                            
                                            print(dic.object(forKey: "exercises_data"))
                                            
                                            print(arrayI)
                                            print(arrayI.count)
                                            self.sessionCountArray.append(arrayI.count)
                                            
                                            print(arrayI[0])
                                            
                                            
                                            self.exercises_dataArray.append(arrayI)
                                            
                                            print(self.exercises_dataArray)
                                            print(self.exercises_dataArray.count)
                                        }
                                        else
                                        {
                                            self.exercises_dataArray.append([])
                                            self.sessionCountArray.append(0)
                                            
                                        }
                                        
                                        
                                    }
                                    
                                    
                                    
                                    
                                }
                                
                                self.tableview.reloadData()
                                
                                
                            
                            
                            
                            
                            
                         /*
                            
                            self.exercises_dataArray = responseDic.object(forKey: "exercises_data") as! Array
                            
                            for i in self.exercises_dataArray
                            {
                                if let dic = i as? NSDictionary
                                {
                                    self.questionArray.append(i.object(forKey: "exercise_title") as? String ?? "")
                                    self.solutionArray.append(i.object(forKey: "exercise_solution") as? String ?? "")
                                }
                            }
                            self.tableview.reloadData()
                          */
                            
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


extension ExcerciseViewController : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.exercises_dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        for i in self.responseData
        {
            
  
        }
        
        if selectedIndexpath == indexPath.row
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExcerciseSolutionTableViewCell", for: indexPath) as! ExcerciseSolutionTableViewCell

            
            return cell
            
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExcerciseQuestionTableViewCell", for: indexPath) as! ExcerciseQuestionTableViewCell

            
            return cell
            
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
//        selectedIndexpath = indexPath.row
//        UIView.performWithoutAnimation
//        {
//            self.tableview.reloadData()
//        }
    }
    
}




