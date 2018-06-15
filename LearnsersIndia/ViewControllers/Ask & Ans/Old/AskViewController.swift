//
//  AskViewController.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 12/04/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class AskViewController: UIViewController,UITextViewDelegate {

    @IBOutlet weak var textview: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        textview.text = "Ask Question"
        textview.textColor = UIColor.lightGray
    }
    
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        if textView.textColor == UIColor.lightGray
        {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView)
    {
        if textView.text.isEmpty
        {
            textView.text = "Ask Question"
            textView.textColor = UIColor.lightGray
        }
    }
    
    @IBAction func doneButton(_ sender: Any)
    {
       self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backButton(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addImageButton(_ sender: Any)
    {
        
    }
    
    @IBAction func cameraButton(_ sender: Any)
    {
        
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
