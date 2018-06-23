//
//  LIShowLevelView.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 23/06/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class LIShowLevelView: UIView {
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var levelDetailsLabel: UILabel!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initializeView()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initializeView()
    }
    private func initializeView(){
        Bundle.main.loadNibNamed(LINibs.ShowLevel, owner: self, options: nil)
        self.containerView.frame = self.frame
        self.containerView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        self.addSubview(containerView)
    }
    func setLevelText(_ level:String?){
        self.levelDetailsLabel.text = level
    }
}
