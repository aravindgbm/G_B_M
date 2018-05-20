//
//  StandardUIElements.swift
//  StandardClasses
//
//  Created by Appzoc on 04/01/18.
//  Copyright © 2018 Appzoc. All rights reserved.
//

import Foundation
import UIKit

//Mark:-  Setting custom color
public class R_UIColor: UIColor {
    public class var midColor: UIColor { get { return UIColor(red: 5/255, green: 150/255, blue: 207/255, alpha: 1.0)}}
    public class var darkColor: UIColor { get { return UIColor(red: 8/255, green: 139/255, blue: 191/255, alpha: 1.0)}}
//    public class var romanaLightBlue: UIColor { get { return UIColor(red: 64/255, green: 185/255, blue: 255/255, alpha: 1.0)}}
//    public class var romanaDarkBlue: UIColor { get { return UIColor(red: 16/255, green: 66/255, blue: 159/255, alpha: 1.0)}}
//    public class var localNotificationColor: UIColor { get { return UIColor(red: 219/255, green: 217/255, blue: 219/255, alpha: 1.0)}}

}

/* For UIButton, UIImageview, UIVIew.
 A - To set currentCornerRadius,borderWidth,borderColor,roundCorners, shadowOffset, shadowColor, shadowOpacity and shadowRadius as Inspectable properties.
 B - To set corner radius for specific corners through function.
 */
@IBDesignable
class StandardButton: UIButton {
    
    var currentCornerRadius:Float?
    
    //MARK:- A - UIButton
    
   @IBInspectable var cornerRadius:Float{
        get{
            return Float(self.layer.cornerRadius)
        }
        set{
            self.layer.cornerRadius = CGFloat(newValue)
        }
    }
    
    @IBInspectable var borderWidth:Float{
        get{
            return Float(self.layer.borderWidth)
        }
        set{
            self.layer.borderWidth = CGFloat(newValue)
        }
    }
    
    @IBInspectable var borderColor:UIColor{
        get{
            if let color = self.layer.borderColor{
            return UIColor(cgColor: color)
            }else{
                return UIColor.clear
            }
        }
        set{
            self.layer.borderColor = newValue.cgColor
        }
    }
    
    
    @IBInspectable var roundCorners:Bool{
        get{
            return self.roundCorners
        }
        set{
            self.currentCornerRadius = Float(self.layer.cornerRadius)
            if newValue{
            self.layer.cornerRadius = self.frame.width/2
            }else{
                self.layer.cornerRadius = CGFloat(currentCornerRadius ?? 0)
            }
        }
    }
    
    @IBInspectable var shadowOffset:CGSize{
        get{
            let currentOffset = self.layer.shadowOffset
           // let offset:(width:Int,height:Int) = (Int(currentOffset.width),Int(currentOffset.height))
            return currentOffset
        }
        set{
            self.layer.shadowOffset = newValue
            
        }
    }
    
    @IBInspectable var shadowColor:UIColor{
        get{
            return UIColor(cgColor: self.layer.shadowColor ?? UIColor.clear.cgColor)
        }
        
        set{
            self.layer.shadowColor = newValue.cgColor
        }
    }
    
    @IBInspectable var shadowOpacity:Float{
        get{
            return self.layer.shadowOpacity
        }
        set{
            self.layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable var shadowRadius:Float{
        get{
            return self.layer.shadowOpacity
        }
        set{
            self.layer.shadowOpacity = newValue
        }
    }
    
    
    func setUpShadows(mask: CAShapeLayer){
        self.layer.masksToBounds = false
        self.layer.shadowPath = mask.path
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        
    }
    
    //MARK:- B - UIButton
    //MARK:- Usage -> view.setSpecificRoundCorners([.topLeft, .bottomLeft], radius: 10)
    //Default Border Color and Width are set.
    func setSpecificRoundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
        
        let borderLayer = CAShapeLayer()
        borderLayer.frame = self.bounds
        borderLayer.path = mask.path
        borderLayer.lineWidth = CGFloat(self.borderWidth)
        borderLayer.strokeColor = self.borderColor.cgColor
        borderLayer.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(borderLayer)
        setUpShadows(mask: mask)
        
    }
}


@IBDesignable
class StandardImageView: UIImageView{
    var currentCornerRadius:Float?
    //MARK:- A - UIImageview
    
    @IBInspectable var cornerRadius:Float{
        get{
            return Float(self.layer.cornerRadius)
        }
        set{
            self.layer.cornerRadius = CGFloat(newValue)
        }
    }
    
    @IBInspectable var borderWidth:Float{
        get{
            return Float(self.layer.borderWidth)
        }
        set{
            self.layer.borderWidth = CGFloat(newValue)
        }
    }
    
    @IBInspectable var borderColor:UIColor{
        get{
            if let color = self.layer.borderColor{
                return UIColor(cgColor: color)
            }else{
                return UIColor.clear
            }
        }
        set{
            self.layer.borderColor = newValue.cgColor
        }
    }
    
    
    @IBInspectable var roundCorners:Bool{
        get{
            return self.roundCorners
        }
        set{
            self.currentCornerRadius = Float(self.layer.cornerRadius)
            if newValue{
                self.layer.cornerRadius = self.frame.width/2
            }else{
                self.layer.cornerRadius = CGFloat(currentCornerRadius ?? 0)
            }
        }
    }
    
    @IBInspectable var shadowOffset:CGSize{
        get{
            let currentOffset = self.layer.shadowOffset
            // let offset:(width:Int,height:Int) = (Int(currentOffset.width),Int(currentOffset.height))
            return currentOffset
        }
        set{
            self.layer.shadowOffset = newValue
            
        }
    }
    
    @IBInspectable var shadowColor:UIColor{
        get{
            return UIColor(cgColor: self.layer.shadowColor ?? UIColor.clear.cgColor)
        }
        
        set{
            self.layer.shadowColor = newValue.cgColor
        }
    }
    
    @IBInspectable var shadowOpacity:Float{
        get{
            return self.layer.shadowOpacity
        }
        set{
            self.layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable var shadowRadius:Float{
        get{
            return self.layer.shadowOpacity
        }
        set{
            self.layer.shadowOpacity = newValue
        }
    }
    
    
    func setUpShadows(mask: CAShapeLayer){
        self.layer.masksToBounds = false
        self.layer.shadowPath = mask.path
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        
    }
    
    //MARK:- B - UIImageview
    //MARK:- Usage -> view.setSpecificRoundCorners([.topLeft, .bottomLeft], radius: 10)
    //Default Border Color and Width are set.
    func setSpecificRoundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
        
        let borderLayer = CAShapeLayer()
        borderLayer.frame = self.bounds
        borderLayer.path = mask.path
        borderLayer.lineWidth = CGFloat(self.borderWidth)
        borderLayer.strokeColor = self.borderColor.cgColor
        borderLayer.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(borderLayer)
        setUpShadows(mask: mask)
        
    }

}

@IBDesignable
class StandardView:UIView{
    var currentCornerRadius:Float?
    
    //MARK:- A - UIView
    
    @IBInspectable var cornerRadius:Float{
        get{
            return Float(self.layer.cornerRadius)
        }
        set{
            self.layer.cornerRadius = CGFloat(newValue)
        }
    }
    
    @IBInspectable var borderWidth:Float{
        get{
            return Float(self.layer.borderWidth)
        }
        set{
            self.layer.borderWidth = CGFloat(newValue)
        }
    }
    
    @IBInspectable var borderColor:UIColor{
        get{
            if let color = self.layer.borderColor{
                return UIColor(cgColor: color)
            }else{
                return UIColor.clear
            }
        }
        set{
            self.layer.borderColor = newValue.cgColor
        }
    }
    
    
    @IBInspectable var roundCorners:Bool{
        get{
            return self.roundCorners
        }
        set{
            self.currentCornerRadius = Float(self.layer.cornerRadius)
            if newValue{
                self.layer.cornerRadius = self.frame.width/2
            }else{
                self.layer.cornerRadius = CGFloat(currentCornerRadius ?? 0)
            }
        }
    }
    
    @IBInspectable var shadowOffset:CGSize{
        get{
            let currentOffset = self.layer.shadowOffset
            // let offset:(width:Int,height:Int) = (Int(currentOffset.width),Int(currentOffset.height))
            return currentOffset
        }
        set{
            self.layer.shadowOffset = newValue
            
        }
    }
    
    @IBInspectable var shadowColor:UIColor{
        get{
            return UIColor(cgColor: self.layer.shadowColor ?? UIColor.clear.cgColor)
        }
        
        set{
            self.layer.shadowColor = newValue.cgColor
        }
    }
    
    @IBInspectable var shadowOpacity:Float{
        get{
            return self.layer.shadowOpacity
        }
        set{
            self.layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable var shadowRadius:Float{
        get{
            return Float(self.layer.shadowRadius)
        }
        set{
            self.layer.shadowRadius = CGFloat(newValue)
        }
    }
    
    
    func setUpShadows(mask: CAShapeLayer){
        self.layer.masksToBounds = false
        self.layer.shadowPath = mask.path
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        
    }
    
    //MARK:- B - UIView
    //MARK:- Usage -> view.setSpecificRoundCorners([.topLeft, .bottomLeft], radius: 10)
    //Default Border Color and Width are set.
    func setSpecificRoundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
        
        let borderLayer = CAShapeLayer()
        borderLayer.frame = self.bounds
        borderLayer.path = mask.path
        borderLayer.lineWidth = CGFloat(self.borderWidth)
        borderLayer.strokeColor = self.borderColor.cgColor
        borderLayer.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(borderLayer)
        setUpShadows(mask: mask)
        
    }

}

@IBDesignable
class StandardLabel:UILabel{
    var currentCornerRadius:Float?
    
    //MARK:- A - UIView
    
    @IBInspectable var cornerRadius:Float{
        get{
            return Float(self.layer.cornerRadius)
        }
        set{
            self.layer.cornerRadius = CGFloat(newValue)
        }
    }
    
    @IBInspectable var borderWidth:Float{
        get{
            return Float(self.layer.borderWidth)
        }
        set{
            self.layer.borderWidth = CGFloat(newValue)
        }
    }
    
    @IBInspectable var borderColor:UIColor{
        get{
            if let color = self.layer.borderColor{
                return UIColor(cgColor: color)
            }else{
                return UIColor.clear
            }
        }
        set{
            self.layer.borderColor = newValue.cgColor
        }
    }
    
    
    @IBInspectable var roundCorners:Bool{
        get{
            return self.roundCorners
        }
        set{
            self.currentCornerRadius = Float(self.layer.cornerRadius)
            if newValue{
                self.layer.cornerRadius = self.frame.width/2
            }else{
                self.layer.cornerRadius = CGFloat(currentCornerRadius ?? 0)
            }
        }
    }
    
}
    @IBDesignable
    class StandardTableView: UITableView {
        
        var currentCornerRadius:Float?
        
        //MARK:- A - UIButton
        
        @IBInspectable var cornerRadius:Float{
            get{
                return Float(self.layer.cornerRadius)
            }
            set{
                self.layer.cornerRadius = CGFloat(newValue)
            }
        }
        
        @IBInspectable var borderWidth:Float{
            get{
                return Float(self.layer.borderWidth)
            }
            set{
                self.layer.borderWidth = CGFloat(newValue)
            }
        }
        
        @IBInspectable var borderColor:UIColor{
            get{
                if let color = self.layer.borderColor{
                    return UIColor(cgColor: color)
                }else{
                    return UIColor.clear
                }
            }
            set{
                self.layer.borderColor = newValue.cgColor
            }
        }
        
        
        @IBInspectable var roundCorners:Bool{
            get{
                return self.roundCorners
            }
            set{
                self.currentCornerRadius = Float(self.layer.cornerRadius)
                if newValue{
                    self.layer.cornerRadius = self.frame.width/2
                }else{
                    self.layer.cornerRadius = CGFloat(currentCornerRadius ?? 0)
                }
            }
        }
        
        @IBInspectable var shadowOffset:CGSize{
            get{
                let currentOffset = self.layer.shadowOffset
                // let offset:(width:Int,height:Int) = (Int(currentOffset.width),Int(currentOffset.height))
                return currentOffset
            }
            set{
                self.layer.shadowOffset = newValue
                
            }
        }
        
        @IBInspectable var shadowColor:UIColor{
            get{
                return UIColor(cgColor: self.layer.shadowColor ?? UIColor.clear.cgColor)
            }
            
            set{
                self.layer.shadowColor = newValue.cgColor
            }
        }
        
        @IBInspectable var shadowOpacity:Float{
            get{
                return self.layer.shadowOpacity
            }
            set{
                self.layer.shadowOpacity = newValue
            }
        }
        
        @IBInspectable var shadowRadius:Float{
            get{
                return self.layer.shadowOpacity
            }
            set{
                self.layer.shadowOpacity = newValue
            }
        }
        
        
        func setUpShadows(mask: CAShapeLayer){
            self.layer.masksToBounds = false
            self.layer.shadowPath = mask.path
            self.layer.shouldRasterize = true
            self.layer.rasterizationScale = UIScreen.main.scale
            
        }
        
        //MARK:- B - UIButton
        //MARK:- Usage -> view.setSpecificRoundCorners([.topLeft, .bottomLeft], radius: 10)
        //Default Border Color and Width are set.
        func setSpecificRoundCorners(_ corners:UIRectCorner, radius: CGFloat) {
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
            
            let borderLayer = CAShapeLayer()
            borderLayer.frame = self.bounds
            borderLayer.path = mask.path
            borderLayer.lineWidth = CGFloat(self.borderWidth)
            borderLayer.strokeColor = self.borderColor.cgColor
            borderLayer.fillColor = UIColor.clear.cgColor
            self.layer.addSublayer(borderLayer)
            setUpShadows(mask: mask)
            
        }
    }


