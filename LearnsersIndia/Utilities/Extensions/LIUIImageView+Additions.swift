//
//  LIUIImageView+Additions.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 23/05/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit
import SDWebImage
extension UIImageView {
    func setImageWith(_ urlString:String?,and placeHolderImage:UIImage? ) {
       
        if let url = urlString{
             self.sd_setImage(with: URL(string:url), placeholderImage: UIImage(named: "placeholder.png"))
//            self.sd_setImage(with: URL(string: url), placeholderImage: placeHolderImage, options: , completed: nil)
        }
    }
}
