//
//  SampleViewController.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 10/04/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit
import Alamofire

class SampleExcerciseViewController: UIViewController
{
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var tableview: UITableView!
    
    var url = "https://appapi.learnersindia.com/get-exercises"
    var questionArray = [String]()
    var solutionArray = [String]()
    var exercises_dataArray = [NSArray]()
    var selectedChapterId = -1
    var selectedChapterName = ""
    var excerciseTopicIDArray = [Int]()
    var excerciseTopicNameArray = [String]()
    var selectedIndexpath = -1
    var heightArray = [CGFloat]()

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        self.tableview.estimatedRowHeight = 600.0;
        self.tableview.rowHeight = UITableViewAutomaticDimension;
        
        self.headerLabel.text = self.selectedChapterName
        ActivityIndicator.setUpActivityIndicator(baseView: self.view)
        self.Get_ExcerciseWebCall(urlString: url) { (_) in
            
        }
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

extension SampleExcerciseViewController : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return questionArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SampleTableViewCell", for: indexPath) as! SampleTableViewCell
        
        let cou = indexPath.row
        cell.questnNoLabel.text = "Question No : " + "\(cou+1)"
        
        let htmlString: String = self.questionArray[indexPath.row]
        
        let stringg = "<b>"+htmlString+"</b>"
        
        
//        let aux = "<span style=\"font-family: Helvetica-Semibold; font-size: 17\">\(htmlString)</span>"
  
//        let modifiedFont = NSString(format:"<span style=\"font-family: Helvetica-Semibold; font-size: 50\">%@</span>", htmlString) as String
        
        /*
         '-apple-system-headline','HelveticaNeue'
         
         
        <html>
        <head>
        <style type=\"text/css\">
        body{font-family: '-apple-system','HelveticaNeue'; font-size:17;}
        </style>
        </head>
        <body></body>
        </html>
        
        */
        
        let data = stringg.data(using: String.Encoding.unicode)! // mind "!"
        let attrStr = try? NSAttributedString( // do catch
            data: data,
            options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil)
        
        
   //     let mutattr = try? NSMutableAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
        
    //    mutattr?.addAttribute(NSAttributedStringKey.font:, value: <#T##Any#>, range: <#T##NSRange#>)
        
        
        cell.questionLabel.attributedText = attrStr
        //cell.questionLabel.font = UIFont(name: "MONTSERRAT-BOLD", size: 17)!
        

        if selectedIndexpath == indexPath.row
        {
            let htmlString1: String = self.solutionArray[indexPath.row]
            
            
            
            let data1 = htmlString1.data(using: String.Encoding.unicode)! // mind "!"
            let attrStr1 = try? NSAttributedString( // do catch
                data: data1,
                options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
                documentAttributes: nil)
 
            cell.solutionLabel.attributedText = attrStr1
            cell.viewSolutionLabel.text = ""
            
        }
        else
        {
            cell.solutionLabel.text = ""
            cell.viewSolutionLabel.text = "View Solution"
        }

            return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        selectedIndexpath = indexPath.row
        UIView.performWithoutAnimation({
            let loc = tableview.contentOffset
            tableview.reloadData()
            tableview.contentOffset = loc
        })
    }
    


    
}

extension SampleExcerciseViewController
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
                            
                            let responseData = responseDic.object(forKey: "response_data") as! NSArray
                            
                            print(responseData.count)
                            print(responseData)
                            
                            for i in responseData
                            {
                                let dic = i as! NSDictionary
                                
                                print(i)
                                print(dic)
                                
//                                self.excerciseTopicIDArray.append(dic.object(forKey: "topic_id") as! Int)
//                                self.excerciseTopicNameArray.append(dic.object(forKey: "topic_name") as! String)

                                if let arrayI = dic.object(forKey: "exercises_data") as? NSArray
                                {
                                    
                                    print(arrayI.count)
                                    print(arrayI)
                                    
                                    if arrayI.count != 0
                                    {
                                        for j in arrayI
                                        {
                                            let exerDic = j as! NSDictionary
                                            self.questionArray.append(exerDic.object(forKey: "exercise_title") as! String)
                                            self.solutionArray.append(exerDic.object(forKey: "exercise_solution") as! String)
                                        }
                                    }
                                    else
                                    {
//                                        self.exercises_dataArray.append([])
//                                        self.sessionCountArray.append(0)
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


//extension UILabel {
//    func setHTMLFromString(htmlText: String) {
//        let modifiedFont = String(format:"<span style=\"font-family: '-apple-system', 'HelveticaNeue'; font-size: \(self.font!.pointSize)\">%@</span>", htmlText)
//
//
//        //process collection values
//        let attrStr = try! NSAttributedString(
//            data: modifiedFont.data(using: .unicode, allowLossyConversion: true)!,
//            options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue],
//            documentAttributes: nil)
//
//
//        self.attributedText = attrStr
//    }
//}
