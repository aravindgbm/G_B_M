//
//  ChapterViewController.swift
//  LearnsersIndia
//
//  Created by macbook on 06/04/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit
import Alamofire

var topic_idArray = [Int]()
var topic_nameArray = [String]()
var video_dataArray = [NSArray]()

class SessionVideoViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var chapterNameLabel: UILabel!
    
    let url = "https://appapi.learnersindia.com/get-videos"
    var selectedChapterId = -1
    var selectedChapterName = ""
    
var crtUrl = ""
   var collectnTitleArray = [String]()
    var collectnvideoUrlArray = [String]()
    var collectnThumnailArray = [String]()
    
    var boardnameArrayofArray = [[String]]()
    var ved_titleArrayofArray = [[String]]()
    var ved_urlArrayofArray = [[String]]()
    
    var selectedUrlVideoArray = [String]()
    
    var jCount = 0
    var tableCount = 0
    var thumnailArray = [String]()
    
//    var boardnameArray = [String]()
//    var ved_titleArray = [String]()
//    var ved_urlArray = [String]()
    
    var collectnCount = [Int]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.chapterNameLabel.text = self.selectedChapterName
        ActivityIndicator.setUpActivityIndicator(baseView: self.view)
        self.GetVideo(urlString: url) { (_) in
            
        }
    }

    @IBAction func backButton(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
     // self.dismiss(animated: true, completion: nil)
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

extension SessionVideoViewController : UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return tableCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        collectnTitleArray.removeAll()
        collectnThumnailArray.removeAll()
        collectnvideoUrlArray.removeAll()
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SessionVideoTableViewCell", for: indexPath) as! SessionVideoTableViewCell
        cell.sessionHeadingLabel.text = topic_nameArray[indexPath.row]

        cell.collectionview.delegate = self
        cell.collectionview.dataSource = self
        
        cell.collectionview.tag = collectnCount[indexPath.row]
        
        
        print(video_dataArray)
        
        let titlname : NSArray = video_dataArray[indexPath.row]
        print(titlname)
        print(titlname.count)
        
        if titlname.count == 0
        {
            print("empty")
        }
        else
        {
            for i in 0...titlname.count-1
            {
                
                
                let dic = titlname[i] as! NSDictionary
                collectnTitleArray.append(dic.object(forKey: "ved_title") as! String)
                collectnvideoUrlArray.append(dic.object(forKey: "ved_url") as! String)
                self.thumnailArray.append(dic.object(forKey: "video_image") as! String)


                
                cell.collectionview.reloadData()
            }

        }
        

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 300
    }

    
}

extension SessionVideoViewController: UICollectionViewDelegate,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return collectionView.tag
        
    }
    
    func htmlString(str:String) -> NSAttributedString
    {
        let htmlString: String = str
        let data = htmlString.data(using: String.Encoding.unicode)! // mind "!"
        let attrStr = try? NSAttributedString( // do catch
            data: data,
            options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil)
        return attrStr!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SessionvideoCollectionViewCell", for: indexPath) as! SessionvideoCollectionViewCell
        
        print(collectnTitleArray[indexPath.row])
        print(collectnTitleArray.count)
        cell.label.text = self.collectnTitleArray[indexPath.row].unescaped
        

                        Alamofire.request(self.thumnailArray[indexPath.row]).responseData { (response) in
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let titlname : NSArray = video_dataArray[indexPath.row]
        print(titlname)
        print(titlname.count)
        
        if titlname.count == 0
        {
            print("empty")
        }
        else
        {
            for i in 0...titlname.count-1
            {
                
                
                let dic = titlname[i] as! NSDictionary

                selectedUrlVideoArray.append(dic.object(forKey: "ved_url") as! String)

                
                print("collectionViewCell selected \(indexPath)")
                print("collectionViewCell selected \(indexPath.row)")
                
                let videourl = self.selectedUrlVideoArray[indexPath.row]
                print(videourl)
                
                let deleteChar = CharacterSet(charactersIn: "https://vimeo.com/")
                let str1 = videourl.trimmingCharacters(in: deleteChar)
                print(str1)
                self.crtUrl = "https://api.vimeo.com/videos/" + str1
                print(crtUrl)
                
                
                

                //self.present(vc, animated: false, completion: nil)
            }
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "PlayVideoViewController") as! PlayVideoViewController
            vc.url = self.crtUrl
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
        
///Users/gbmainframe/Desktop/LearnersIndia/LearnsersIndia/ViewControllers/LoginSignUp/DropdownCell.xib: Internal error. Please file a bug at bugreport.apple.com and attach "/var/folders/tz/nl5qvvxd4tlf9btbql4vph380000gn/T/IB-agent-diagnostics_2018-04-12_11-36-00_248000".
//
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let width = self.view.frame.size.width
        let height : CGFloat = 240
        print("Table height is \(height)")
        return CGSize(width: width/1.3, height: height)
        
    }
    
}


extension SessionVideoViewController
{

    
    
    
    func GetVideo(urlString: String, completion: @escaping(Bool) -> Void)
    {
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
                            
                            self.tableCount = responseData.count
                            print(self.tableCount)
                            
                            for i in responseData
                            {
                                let dic = i as! NSDictionary
                                
                                print(i)
                                print(dic)
                                
                                topic_idArray.append(dic.object(forKey: "topic_id") as! Int)
                                topic_nameArray.append(dic.object(forKey: "topic_name") as! String)
                               
                        
                                
                                
                                
                               if let arrayI = dic.object(forKey: "video_data") as? NSArray
                               {
                                
                                if arrayI.count != 0
                                {
                                    
                                    print(dic.object(forKey: "video_data"))
                                    
                                    print(arrayI)
                                    print(arrayI.count)
                                    self.collectnCount.append(arrayI.count)
                                    
                                    print(arrayI[0])
                                    
                                    
                                    video_dataArray.append(arrayI)
                                    
                                    print(video_dataArray)
                                    print(video_dataArray.count)
                                }
                                else
                                {
                                    video_dataArray.append([])
                                    self.collectnCount.append(0)
                                    
                                }

                              
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
    
   
    func getvideo_data()
    {
        for i in (0...video_dataArray.count-1)
        {
            print(video_dataArray)
            
            for j in video_dataArray[i]
            {
                
                print(j)
                
                if let dic = j as? NSDictionary
                {
                    print(dic.object(forKey: "boardname") as! String)
                    
//                    self.boardnameArray.append(dic.object(forKey: "boardname") as! String)
//                    self.ved_titleArray.append(dic.object(forKey: "ved_title") as! String)
//                    self.ved_urlArray.append(dic.object(forKey: "ved_url") as! String)
                    
                    print(i)
//                    self.boardnameArrayofArray[i][jCount] = dic.object(forKey: "boardname") as! String
//
//                    self.ved_titleArrayofArray[i][j] = .append(dic.object(forKey: "ved_title") as! String)
//
//                    self.ved_urlArrayofArray[i].append(dic.object(forKey: "ved_url") as! String)

                }
                else
                {
                   print("failed")
                }
                
                
                print(self.boardnameArrayofArray)
                print(self.boardnameArrayofArray.count)
                print(i)
                print(j)
                

                
                self.collectnCount.append(video_dataArray[i].count)
                
                jCount = jCount + 1
            }
            
            jCount = 0
  
        }
        
        print(boardnameArrayofArray)
        
    }
    
    
    
} //end





