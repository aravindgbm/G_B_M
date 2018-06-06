//
//  FeedViewController.swift
//  LearnsersIndia
//
//  Created by macbook on 30/03/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit
import Alamofire
import AVFoundation
import AVKit


class FeedViewController: UIViewController {
    
    @IBOutlet weak var bottomViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var topViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var subView1HeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var subView2HeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var syllabusLabel: UILabel!
    @IBOutlet weak var tableview: UITableView!
    
    var url = "https://appapi.learnersindia.com/get-free-videos"
    var questionURL = "https://appapi.learnersindia.com/reccomented-questions"
    var rowCount = 0
    var itemCount = 0
    var video_dataArray = [NSDictionary]()
    var question_dataArray = [NSDictionary]()
    // video, title, chapter_name and topic_name
    var videoArray = [String]()
    var titleArray = [String]()
    var chapterNameArray = [String]()
    var topicNameArray = [String]()
    var validUrlArray = [URL]()
    var thumnailArray = [String]()
    var studentArray = [String]()
    var profilePicArray = [String]()
    var htmlquestionArray = [String]()
    var questionArray = [String]()
    var answerCount = [Int]()
    var timeStampArray = [String]()
    var profileArray = [String]()
    var subjectArray = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
//        self.subView1HeightConstraint.constant = self.view.frame.size.height/1.68
//        syllabusLabel.text = selectedBorad + " - " + selectedClass
//        //classLabel.text = selectedClass
//
//        adjustingHeight() // height of view
//        ActivityIndicator.setUpActivityIndicator(baseView: self.view)
//        self.GetRecommededVideo(urlString: url) { (_) in
//
//        }
//
//        self.GetRecommededQuestions(urlString: questionURL){ (_) in
//
//        }
        
    }
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        LIAccountManager.sharedInstance.removeLoggedInUserAndToken()
        AppDelegate.getAppDelegateInstance().navigateToTutorialScreen()
    }
    
    func adjustingHeight()
    {
        
        if itemCount == 0
        {
            DispatchQueue.main.async
                {
                    self.collectionview.isHidden = true
                    self.subView2HeightConstraint.constant = self.view.frame.size.height/3.86
            }
        }
        else
        {
            DispatchQueue.main.async
                {
                    self.collectionview.isHidden = false
                    self.subView2HeightConstraint.constant = self.view.frame.size.height/2.5
            }
        }
        
        
        
        if rowCount == 0
        {
            DispatchQueue.main.async
                {
                    self.tableview.isHidden = true
                    self.bottomViewHeightConstraint.constant = self.view.frame.size.height/3.86
            }
            
        }
        else
        {
            DispatchQueue.main.async
                {
                    self.tableview.isHidden = false
                    // After getting data reload tableview and height
                    let height = self.view.frame.size.height
                    let rowheight = height/3.86
                    self.tableViewHeightConstraint.constant = rowheight * CGFloat(self.rowCount)
                    print(self.tableViewHeightConstraint.constant)
                    self.bottomViewHeightConstraint.constant = self.tableViewHeightConstraint.constant + 50
                    print(self.bottomViewHeightConstraint.constant)
                    self.view!.layoutIfNeeded()
                    self.view!.setNeedsUpdateConstraints()
            }
            
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func askButton(_ sender: Any)
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AskViewController") as! AskViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func ViewButton(_ sender: Any)
    {
        
        
    }
    
    @IBAction func testButton(_ sender: Any)
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "GetChapterViewController") as! GetChapterViewController
        vc.type = 3
        print(vc.type)
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func videoButton(_ sender: Any)
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "GetChapterViewController") as! GetChapterViewController
        vc.type = 1
        self.navigationController?.pushViewController(vc, animated: true)
        // self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func exerciseButton(_ sender: Any)
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "GetChapterViewController") as! GetChapterViewController
        vc.type = 2
        print(vc.type)
        self.navigationController?.pushViewController(vc, animated: false)
        
        // self.present(vc, animated: true, completion: nil)
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

extension FeedViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        print("item count is \(itemCount)")
        return itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        print(thumnailArray.count)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularVideosCollectionViewCell", for: indexPath) as! PopularVideosCollectionViewCell
        
        print(thumnailArray.count)
        
        if thumnailArray.count > 0
        {
            Alamofire.request(thumnailArray[indexPath.row]).responseData { (response) in
                if response.error == nil {
                    print(response.result)
                    
                    // Show the downloaded image:
                    if let data = response.data
                    {
                        cell.imageview.image = UIImage(data: data)
                    }
                }
 
                cell.label.text = self.titleArray[indexPath.row].unescaped
                

            }
        }
        else
        {
            //self.extractUrlFromVimoe()
        }
        
        
        return cell
    }
    
    
    func htmlString(str:String) -> NSMutableAttributedString
    {
        let htmlString: String = str
        let data = htmlString.data(using: String.Encoding.unicode)! // mind "!"
        let attrStr = try? NSMutableAttributedString( // do catch
            data: data,
            options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil)
    
        return attrStr!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let width = self.collectionview.frame.size.width
        let height = self.subView2HeightConstraint.constant
        print("Table height is \(height)")
        return CGSize(width: width/1.3, height: self.view.frame.size.height/2.9)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let videourl = self.videoArray[indexPath.row]
        print(videourl)
        
        let deleteChar = CharacterSet(charactersIn: "https://vimeo.com/")
        let str1 = videourl.trimmingCharacters(in: deleteChar)
        print(str1)
        let crtUrl = "https://api.vimeo.com/videos/" + str1
        print(crtUrl)
        
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "PlayVideoViewController") as! PlayVideoViewController
        vc.url = crtUrl
        self.navigationController?.pushViewController(vc, animated: true)
        //  self.present(vc, animated: true, completion: nil)
        
    }
    
    
    
    
    
}


extension FeedViewController : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        print(rowCount)
        return rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecomentedQuestionsTableViewCell", for: indexPath)  as! RecomentedQuestionsTableViewCell
        if answerCount[indexPath.row] == 0
        {
            cell.answerCountLabel.text = "No Answer"
            cell.morebuttn.isHidden = true
            cell.moreLabel.isHidden = true
        }
        else
        {
            cell.answerCountLabel.text = String(answerCount[indexPath.row]) + " Answer"
            cell.morebuttn.isHidden = false
            cell.moreLabel.isHidden = false
        }
        
        if let namee = self.studentArray[indexPath.row] as? String
        {
            cell.nameLabel.text = namee
        }
        else
        {
            cell.nameLabel.text = ""
        }
        
        
        
        // Image
        
        let htmlString: String = htmlquestionArray[indexPath.row]
        let data = htmlString.data(using: String.Encoding.unicode)! // mind "!"
        let attrStr = try? NSAttributedString( // do catch
            data: data,
            options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil)
        cell.questionsLabel.attributedText = attrStr
        
        //self.questionArray[indexPath.row]
        
        if profileArray[indexPath.row] == ""
        {
            cell.profileImageView.image = UIImage(named: "profile")
        }
        else
        {
            Alamofire.request("https://learnersindia.com/"+profileArray[indexPath.row]).responseData { (response) in
                if response.error == nil {
                    print(response.result)
                    
                    // Show the downloaded image:
                    if let data = response.data
                    {
                        cell.profileImageView.image = UIImage(data: data)
                    }
                    
                    
                }
        }

                }
        
        
        // Subject date
        
        let date = NSDate(timeIntervalSince1970: TimeInterval(self.timeStampArray[indexPath.row])!)
        
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "MM/dd/yyyy"
        
        let dateString = dayTimePeriodFormatter.string(from: date as Date)
        
        
        let finalString = "Asked in "+self.subjectArray[indexPath.row]+" on "+dateString
        
        cell.subtitleLabel.text = finalString
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        let height = self.view.frame.size.height
        let rowheight = height/3.86
        return rowheight
    }
    
    
}


extension String
{
    var unescaped: String
    {
        let entities = ["\0", "\t", "\n", "\r", "\"", "\'", "\\", "\n\r"]
        var current = self
        for entity in entities
        {
            let descriptionCharacters = entity.debugDescription.characters.dropFirst().dropLast()
            let description = String(descriptionCharacters)
            current = current.replacingOccurrences(of: description, with: entity)
        }
        
        return current
    }
}

extension FeedViewController // Recomentted videos
{

    
    
    func GetRecommededVideo(urlString: String, completion: @escaping(Bool) -> Void)
    {
        let paramters = ["syl_id":"1",   //selectedBoardID,
            "class_id":"10",     //selectedCls_id,
            "sub_id":"1"] as [String : Any]
        
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
                            
                            
                            self.video_dataArray = responseDic.object(forKey: "video_data") as! [NSDictionary]
                            self.itemCount = self.video_dataArray.count
                            for i in self.video_dataArray
                            {
                                // video, title, chapter_name and topic_name
                                let dic : NSDictionary = i
                                self.videoArray.append(dic.object(forKey: "ved_url") as? String ?? "")
                                self.titleArray.append(dic.object(forKey: "ved_title") as? String ?? "")
                                self.chapterNameArray.append(dic.object(forKey: "chapter") as? String ?? "")
                                self.topicNameArray.append(dic.object(forKey: "topicname") as? String ?? "")
                                self.thumnailArray.append(dic.object(forKey: "video_image") as? String ?? "")
                            }
                            //self.getThumbnail()
                            //self.extractUrlFromVimoe()

                            DispatchQueue.main.asyncAfter(deadline: .now() + 7)
                            {
                                self.collectionview.reloadData()
                                self.adjustingHeight()
                                
                            }
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


extension FeedViewController
{
    
    func GetRecommededQuestions(urlString: String, completion: @escaping(Bool) -> Void)
    {
        let paramters = ["syl_id":"1",   //selectedBoardID,
            "class_id":"10",     //selectedCls_id,
            "sub_id":"1"] as [String : Any]
        
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
                            ActivityIndicator.dismissActivityView()
                            
                            self.question_dataArray = responseDic.object(forKey: "questions_data") as! [NSDictionary]
                            self.rowCount = self.question_dataArray.count
                            for i in self.question_dataArray
                            {
                                // video, title, chapter_name and topic_name
                                let dic : NSDictionary = i
                                self.studentArray.append(dic.object(forKey: "student") as? String ?? "")
                                //                                self.profilePicArray.append(dic.object(forKey: "profile_pic") as! String)
                                self.htmlquestionArray.append(dic.object(forKey: "qst_title") as? String ?? "")
                                
                                
                                if let countt = dic.object(forKey: "Total_answers") as? Int
                                {
                                    self.answerCount.append(countt)
                                    
                                }
                                else
                                {
                                    self.answerCount.append(0)
                                }
                                
                                
                                
                                self.timeStampArray.append(dic.object(forKey: "qst_timestamp") as? String ?? "")
                                self.subjectArray.append(dic.object(forKey: "subjectname") as? String ?? "")
                                self.profileArray.append(dic.object(forKey: "profile_pic") as? String ?? "")
                                
                                
                            }
                            // self.convertHTMLtoText()
                            self.tableview.reloadData()
                            self.adjustingHeight()
                            
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
    
    
    
    func convertHTMLtoText()
    {
        for i in htmlquestionArray
        {
            let htmlString = i
            print(htmlString)
            // works even without <html><body> </body></html> tags, BTW
            let data = htmlString.data(using: .utf8)! // mind "!"
            let attrStr = try? NSAttributedString( // do catch
                data: data,
                options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
                documentAttributes: nil)
            
            print(attrStr)
            //   self.questionArray.append(attrStr!)
            
            
            
            //    print(i.convertHtml())
            
        }
        
        
        
        self.tableview.reloadData()
        self.adjustingHeight()
        
    }
    
}



//extension String{
//    func convertHtml() -> NSAttributedString{
//        guard let data = data(using: .utf8) else { return NSAttributedString() }
//        do{
//            return try NSAttributedString(data: data, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue], documentAttributes: nil)
//
//            return try NSAtt
//        }catch{
//            return NSAttributedString()
//        }
//    }
//}









