//
//  TestsViewController.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 11/04/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit
import Alamofire

class TestsViewController: UIViewController
{

    @IBOutlet weak var tableView: UITableView!
    
    var chp_idArray = [Int]()
    var chapterArray = [String]()
    var test_totalQuestionsArray = [Int]()
    
    var url = "https://appapi.learnersindia.com/get-testpapers"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    @IBAction func backButton(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
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

extension TestsViewController : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return chapterArray.count
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
            let vc = storyboard?.instantiateViewController(withIdentifier: "TestStartViewController") as! TestStartViewController
            vc.selectedChapterId = self.chp_idArray[indexPath.row]
            vc.selectedChapterName = self.chapterArray[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
    }
            

    
}





extension TestsViewController
{
    
    
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
//                            self.chapters_dataArray = responseDic.object(forKey: "response_data") as! Array
//                            for i in self.chapters_dataArray
//                            {
//                                if let dic = i as? NSDictionary
//                                {
//                                    self.chp_idArray.append(i.object(forKey: "chp_id") as? Int ?? -1)
//                                    self.chapterArray.append(i.object(forKey: "chapter") as? String ?? "")
//                                }
//                            }
//                            
//                            self.tableview.reloadData()
                            
                            
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
