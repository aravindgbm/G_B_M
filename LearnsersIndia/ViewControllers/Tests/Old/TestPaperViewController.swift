//
//  TestPaperViewController.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 11/04/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit
import Alamofire

class TestPaperViewController: UIViewController {
    
    @IBOutlet weak var solutionAnswerLabel: UILabel!
    @IBOutlet weak var heightContrantsScrolling: NSLayoutConstraint!
    @IBOutlet weak var solutionHeadingLabel: UILabel!
  
    
    @IBOutlet weak var optionview: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var option1Label: UILabel!
    @IBOutlet weak var option2Label: UILabel!
    @IBOutlet weak var option3Label: UILabel!
    @IBOutlet weak var option4Label: UILabel!
    @IBOutlet weak var option1Button: UIButton!
    @IBOutlet weak var option2Button: UIButton!
    @IBOutlet weak var option3Button: UIButton!
    @IBOutlet weak var option4Button: UIButton!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    
    
    
    let url = "https://appapi.learnersindia.com/get-testpaper-questions"
    var selectedChapterId = Int()
    var response_dataArray = [NSDictionary]()
    var questionArray = [String]()
    var option1Array = [String]()
    var option2Array = [String]()
    var option3Array = [String]()
    var option4Array = [String]()
    var showingOptionArray = [String]()
    var solutionArray = [String]()
    var test_question_idArray = [Int]()
    var correct_answerArray = [Int]()
    var markArray = [Int]()
    var test_total_marks = Int()
    var currentQuestionNumber = 0
    var selectedanswer = -1
    var onceSelected = false
    var nextPressed = false
    var correctAnswerCount = 0
    var skipedAnswerCount = 0
    var totalQuestionCount = 0
    var wrongAnswerCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.option1Button.tag = 1
        self.option2Button.tag = 2
        self.option3Button.tag = 3
        self.option4Button.tag = 4
        
        self.nextPressed = true
        ActivityIndicator.setUpActivityIndicator(baseView: self.view)
        self.Get_TestPaperWebCall(urlString: url) { (_) in
        
        }

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextButton(_ sender: Any)
    {
        if self.currentQuestionNumber < self.questionArray.count-1
        {
            self.image1.image = nil
            self.image2.image = nil
            self.image3.image = nil
            self.image4.image = nil
            
            self.currentQuestionNumber = self.currentQuestionNumber + 1
            self.solutionHeadingLabel.text = ""
            self.solutionAnswerLabel.text = ""
            self.show()
        }
        else
        {
            let vc = storyboard?.instantiateViewController(withIdentifier: "TestFinalViewController") as! TestFinalViewController
            vc.totalScore = self.correctAnswerCount
            vc.totalQuestionCount = self.totalQuestionCount
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    
    
    @IBAction func option1ButtonAction(_ sender: Any)
    {
        self.showcontent()
        
        if option1Button.tag == correct_answerArray[self.currentQuestionNumber]
        {
            self.image1.image = UIImage(named: "correct")
            self.correctAnswerCount = self.correctAnswerCount + 1
        }
        else
        {
            self.image1.image = UIImage(named: "wrong")
            self.wrongAnswerCount = self.wrongAnswerCount + 1
            
            if option2Button.tag == correct_answerArray[self.currentQuestionNumber]
            {
                self.image2.image = UIImage(named: "correct")
            }
            else if option3Button.tag == correct_answerArray[self.currentQuestionNumber]
            {
                self.image3.image = UIImage(named: "correct")
            }
            else if option4Button.tag == correct_answerArray[self.currentQuestionNumber]
            {
                self.image4.image = UIImage(named: "correct")
            }
            
        }
        
    }
    
    @IBAction func option2ButtonAction(_ sender: Any)
    {
        self.showcontent()
        
        if option2Button.tag == correct_answerArray[self.currentQuestionNumber]
        {
            self.image2.image = UIImage(named: "correct")
            self.correctAnswerCount = self.correctAnswerCount + 1
        }
        else
        {
            self.image2.image = UIImage(named: "wrong")
            self.wrongAnswerCount = self.wrongAnswerCount + 1
            
            if option1Button.tag == correct_answerArray[self.currentQuestionNumber]
            {
                self.image1.image = UIImage(named: "correct")
            }
            else if option3Button.tag == correct_answerArray[self.currentQuestionNumber]
            {
                self.image3.image = UIImage(named: "correct")
            }
            else if option4Button.tag == correct_answerArray[self.currentQuestionNumber]
            {
                self.image4.image = UIImage(named: "correct")
            }
        }
        
    }
    
    @IBAction func option3ButtonAction(_ sender: Any)
    {
        self.showcontent()
        
        if option3Button.tag == correct_answerArray[self.currentQuestionNumber]
        {
            self.image3.image = UIImage(named: "correct")
            self.correctAnswerCount = self.correctAnswerCount + 1
        }
        else
        {
            self.image3.image = UIImage(named: "wrong")
            self.wrongAnswerCount = self.wrongAnswerCount + 1
            
            if option1Button.tag == correct_answerArray[self.currentQuestionNumber]
            {
                self.image1.image = UIImage(named: "correct")
            }
            else if option2Button.tag == correct_answerArray[self.currentQuestionNumber]
            {
                self.image2.image = UIImage(named: "correct")
            }
            else if option4Button.tag == correct_answerArray[self.currentQuestionNumber]
            {
                self.image4.image = UIImage(named: "correct")
            }
        }
    }
    
    
    @IBAction func option4ButtonAction(_ sender: Any)
    {
        self.showcontent()
        
        if option4Button.tag == correct_answerArray[self.currentQuestionNumber]
        {
            self.image4.image = UIImage(named: "correct")
            self.correctAnswerCount = self.correctAnswerCount + 1
        }
        else
        {
            self.image4.image = UIImage(named: "wrong")
            self.wrongAnswerCount = self.wrongAnswerCount + 1
            
            if option2Button.tag == correct_answerArray[self.currentQuestionNumber]
            {
                self.image2.image = UIImage(named: "correct")
            }
            else if option3Button.tag == correct_answerArray[self.currentQuestionNumber]
            {
                self.image3.image = UIImage(named: "correct")
            }
            else if option1Button.tag == correct_answerArray[self.currentQuestionNumber]
            {
                self.image1.image = UIImage(named: "correct")
            }
        }
    }
    
    
    
    
     func showcontent()
    {
        DispatchQueue.main.async
        {
            self.solutionHeadingLabel.text = "Solution"
            self.solutionAnswerLabel.attributedText = self.htmlString(str: self.solutionArray[self.currentQuestionNumber])
        }

    }
    
    func show()
    {
        self.questionLabel.attributedText = htmlString(str: self.questionArray[currentQuestionNumber])
        self.option1Label.attributedText = htmlString(str: self.option1Array[currentQuestionNumber])
        self.option2Label.attributedText = htmlString(str: self.option2Array[currentQuestionNumber])
        self.option3Label.attributedText = htmlString(str: self.option3Array[currentQuestionNumber])
        self.option4Label.attributedText = htmlString(str: self.option4Array[currentQuestionNumber])
        
        DispatchQueue.main.async
        {
            self.option1Button.frame = self.option1Label.frame
            self.option2Button.frame = self.option2Label.frame
            self.option3Button.frame = self.option3Label.frame
            self.option4Button.frame = self.option4Label.frame
            
            self.image1.frame = CGRect(x: self.option1Label.frame.size.width + 5, y: self.option1Label.frame.origin.y, width: 30, height: 30)
            self.image2.frame = CGRect(x: self.option2Label.frame.size.width + 5, y: self.option2Label.frame.origin.y, width: 30, height: 30)
            self.image3.frame = CGRect(x: self.option3Label.frame.size.width + 5, y: self.option3Label.frame.origin.y, width: 30, height: 30)
            self.image4.frame = CGRect(x: self.option4Label.frame.size.width + 5, y: self.option4Label.frame.origin.y, width: 30, height: 30)
            
            self.view1.frame = CGRect(x: 0, y: self.option1Label.frame.origin.y+self.option1Label.frame.size.height+3, width: self.optionview.frame.size.width, height: 1)
            self.view2.frame = CGRect(x: 0, y: self.option2Label.frame.origin.y+self.option2Label.frame.size.height+3, width: self.optionview.frame.size.width, height: 1)
            self.view3.frame = CGRect(x: 0, y: self.option3Label.frame.origin.y+self.option3Label.frame.size.height+3, width: self.optionview.frame.size.width, height: 1)
            //self.view4.frame = CGRect(x: 0, y: self.option1Label.frame.origin.y+self.option1Label.frame.size.height+3, width: self.optionview.frame.size.width, height: 1)
            
            
            
            /*
             self.option1Button.frame.size.height = self.option1Label.frame.size.height
             self.option2Button.frame.size.height = self.option2Label.frame.size.height
             self.option3Button.frame.size.height = self.option3Label.frame.size.height
             self.option4Button.frame.size.height = self.option4Label.frame.size.height
             
             
             self.image1.frame = CGRect(x: self.option1Label.frame.size.width + 20, y: self.option1Label.frame.origin.y+(self.option1Label.frame.size.height/2), width: 30, height: 30)
             self.image2.frame = CGRect(x: self.option2Label.frame.size.width + 20, y: self.option2Label.frame.origin.y+(self.option2Label.frame.size.height/2), width: 30, height: 30)
             self.image3.frame = CGRect(x: self.option3Label.frame.size.width + 20, y: self.option3Label.frame.origin.y+(self.option3Label.frame.size.height/2), width: 30, height: 30)
             self.image4.frame = CGRect(x: self.option4Label.frame.size.width + 20, y: self.option4Label.frame.origin.y+(self.option4Label.frame.size.height/2), width: 30, height: 30)
 
            */
        }
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

extension TestPaperViewController : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        print(showingOptionArray.count)
       return showingOptionArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TestPaperTableViewCell", for: indexPath) as! TestPaperTableViewCell
        
        if nextPressed
        {
          //self.nextPressed = false
          cell.label.text = self.showingOptionArray[indexPath.row]
          cell.imageview.image = nil
          self.solutionHeadingLabel.frame.size.height = 0
          self.solutionAnswerLabel.frame.size.height = 0
        }
        if onceSelected
        {
            if selectedanswer+1 == self.correct_answerArray[indexPath.row]
            {
                cell.imageview.image = UIImage(named: "correct")
            }
            else
            {
                if selectedanswer == indexPath.row
                {
                    cell.imageview.image = UIImage(named: "wrong")
                    if selectedanswer+1 == indexPath.row
                    {
                       cell.imageview.image = UIImage(named: "correct")
                    }
                }
            }
            
            
            self.solutionHeadingLabel.frame.size.height = 50
            let maxLabelWidth: CGFloat = self.solutionAnswerLabel.frame.size.width
            let neededSize = self.solutionAnswerLabel.sizeThatFits(CGSize(width: maxLabelWidth, height: CGFloat.greatestFiniteMagnitude))
            self.solutionAnswerLabel.frame.size.height = neededSize.height
            self.solutionAnswerLabel.text = self.solutionArray[indexPath.row]
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if onceSelected == false
        {
            self.onceSelected = true
            let cell = tableView.cellForRow(at: indexPath) as! TestPaperTableViewCell
            self.selectedanswer = indexPath.row
        }
    }
    
    
}

extension TestPaperViewController
{
    
    
    func Get_TestPaperWebCall(urlString: String, completion: @escaping(Bool) -> Void)
    {
        print(tocken)
        print(selectedBoardID)
        print(selectedCls_id)
        
        let paramters = ["tocken":tocken,
                         "syl_id":selectedBoardID,
                         "class_id":selectedCls_id,
                         "sub_id":"1",
                         "chap_id": selectedChapterId] as [String : Any]
        
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
                            
                            self.response_dataArray = responseDic.object(forKey: "response_data") as? Array ?? []
                            
                            if self.response_dataArray.count > 0
                            {
                                self.totalQuestionCount = self.response_dataArray.count
                                
                                for i in self.response_dataArray
                                {
                                    if let dic = i as? NSDictionary
                                    {
                                        self.test_question_idArray.append(i.object(forKey: "test_question_id") as? Int ?? -1)
                                        self.questionArray.append(i.object(forKey: "test_question") as? String ?? "")
                                        self.option1Array.append(i.object(forKey: "option1") as? String ?? "")
                                        self.option2Array.append(i.object(forKey: "option2") as? String ?? "")
                                        self.option3Array.append(i.object(forKey: "option3") as? String ?? "")
                                        self.option4Array.append(i.object(forKey: "option4") as? String ?? "")
                                        self.correct_answerArray.append(i.object(forKey: "correct_answer") as? Int ?? -1)
                                        self.solutionArray.append(i.object(forKey: "answer_solution") as? String ?? "")
                                        self.markArray.append(i.object(forKey: "mark") as? Int ?? -1)
                                    }
                                }
                                
                                
                                self.show()
                            }
                            

                            
                            
                            //                            self.chapters_dataArray = responseDic.object(forKey: "chapters_data") as! Array
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
                            //
                            //
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

