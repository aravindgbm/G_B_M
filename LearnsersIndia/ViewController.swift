//
//  ViewController.swift
//  LearnsersIndia
//
//  Created by macbook on 10/03/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit
import ImageIO

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var heightcons: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.label.text = "Do any additional setup after loading the view, typically from a nib.Do any additional setup after loading the view, typically from a nib.Do any additional setup after loading the view, typically from a nib.Do any additional setup after loading the view, typically from a nib.Do any additional setup after loading the view, typically from a nib."
        
        
        let maxLabelWidth: CGFloat = self.label.frame.size.width
        let neededSize = self.label.sizeThatFits(CGSize(width: maxLabelWidth, height: CGFloat.greatestFiniteMagnitude))
        print(neededSize.height)
        heightcons.constant = neededSize.height
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


