import UIKit

@IBDesignable class R_UIImage: UIImageView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor.init(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }

    /// SwifterSwift: Shadow color of view; also inspectable from Storyboard.
    @IBInspectable public var shadowColor: UIColor? {
        get {
            guard let color = layer.shadowColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }

    /// SwifterSwift: Shadow offset of view; also inspectable from Storyboard.
    @IBInspectable public var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }

    /// SwifterSwift: Shadow opacity of view; also inspectable from Storyboard.
    @IBInspectable public var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }

    /// SwifterSwift: Shadow radius of view; also inspectable from Storyboard.
    @IBInspectable public var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }



    override init(frame: CGRect) {
        super.init(frame: frame)
    }


    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}




































////
////  R_Classes + Extensions.swift
////  Romana
////
////  Created by Appzoc on 25/09/17.
////  Copyright © 2017 Appzoc-Macmini. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//
//
////Mark:-  Setting custom color
//public class R_UIColor: UIColor {
//    public class var romanaGreen: UIColor { get { return UIColor(red: 0/255, green: 143/255, blue: 44/255, alpha: 1.0)}}
//    public class var romanaBlue: UIColor { get { return UIColor(red: 18/255, green: 60/255, blue: 159/255, alpha: 1.0)}}
//    public class var romanaLightBlue: UIColor { get { return UIColor(red: 64/255, green: 185/255, blue: 255/255, alpha: 1.0)}}
//    public class var romanaDarkBlue: UIColor { get { return UIColor(red: 16/255, green: 66/255, blue: 159/255, alpha: 1.0)}}
//    public class var localNotificationColor: UIColor { get { return UIColor(red: 219/255, green: 217/255, blue: 219/255, alpha: 1.0)}}
//    
//}
//
//
//
//
//
//
////Mark:-  Setting custom view with corner radius and borders
//@IBDesignable class R_UIView: UIView {
//    @IBInspectable var cornerRadius: CGFloat {
//        get {
//            return layer.cornerRadius
//        }
//        set {
//            layer.cornerRadius = newValue
//            layer.masksToBounds = newValue > 0
//        }
//    }
//    
//    @IBInspectable var borderWidth: CGFloat {
//        get {
//            return layer.borderWidth
//        }
//        set {
//            layer.borderWidth = newValue
//            layer.masksToBounds = newValue > 0
//        }
//    }
//    
//    @IBInspectable var borderColor: UIColor {
//        get {
//            return UIColor.init(cgColor: layer.borderColor!)
//        }
//        set {
//            layer.borderColor = newValue.cgColor
//        }
//    }
//    
//    /// SwifterSwift: Shadow color of view; also inspectable from Storyboard.
//    @IBInspectable public var shadowColor: UIColor? {
//        get {
//            guard let color = layer.shadowColor else {
//                return nil
//            }
//            return UIColor(cgColor: color)
//        }
//        set {
//            layer.shadowColor = newValue?.cgColor
//        }
//    }
//    
//    /// SwifterSwift: Shadow offset of view; also inspectable from Storyboard.
//    @IBInspectable public var shadowOffset: CGSize {
//        get {
//            return layer.shadowOffset
//        }
//        set {
//            layer.shadowOffset = newValue
//        }
//    }
//    
//    /// SwifterSwift: Shadow opacity of view; also inspectable from Storyboard.
//    @IBInspectable public var shadowOpacity: Float {
//        get {
//            return layer.shadowOpacity
//        }
//        set {
//            layer.shadowOpacity = newValue
//        }
//    }
//    
//    /// SwifterSwift: Shadow radius of view; also inspectable from Storyboard.
//    @IBInspectable public var shadowRadius: CGFloat {
//        get {
//            return layer.shadowRadius
//        }
//        set {
//            layer.shadowRadius = newValue
//        }
//    }
//    
//    
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//    
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//}
//
//// Label
//
//@IBDesignable class R_UILabel: UILabel {
//    @IBInspectable var cornerRadius: CGFloat {
//        get {
//            return layer.cornerRadius
//        }
//        set {
//            layer.cornerRadius = newValue
//            layer.masksToBounds = newValue > 0
//        }
//    }
//    
//    @IBInspectable var borderWidth: CGFloat {
//        get {
//            return layer.borderWidth
//        }
//        set {
//            layer.borderWidth = newValue
//            layer.masksToBounds = newValue > 0
//        }
//    }
//    
//    @IBInspectable var borderColor: UIColor {
//        get {
//            return UIColor.init(cgColor: layer.borderColor!)
//        }
//        set {
//            layer.borderColor = newValue.cgColor
//        }
//    }
//    
//
//    
//    
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//    
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//}
//
////Mark:-  Setting custom view with corner radius and borders in UIButton
//@IBDesignable class R_UIButton: UIButton {
//    @IBInspectable var cornerRadius: CGFloat {
//        get {
//            return layer.cornerRadius
//        }
//        set {
//            layer.cornerRadius = newValue
//            layer.masksToBounds = newValue > 0
//        }
//    }
//    
//    @IBInspectable var borderWidth: CGFloat {
//        get {
//            return layer.borderWidth
//        }
//        set {
//            layer.borderWidth = newValue
//            layer.masksToBounds = newValue > 0
//        }
//    }
//    
//    @IBInspectable var borderColor: UIColor {
//        get {
//            return UIColor.init(cgColor: layer.borderColor!)
//        }
//        set {
//            layer.borderColor = newValue.cgColor
//        }
//    }
//    
//    /// SwifterSwift: Shadow color of view; also inspectable from Storyboard.
//    @IBInspectable public var shadowColor: UIColor? {
//        get {
//            guard let color = layer.shadowColor else {
//                return nil
//            }
//            return UIColor(cgColor: color)
//        }
//        set {
//            layer.shadowColor = newValue?.cgColor
//        }
//    }
//    
//    /// SwifterSwift: Shadow offset of view; also inspectable from Storyboard.
//    @IBInspectable public var shadowOffset: CGSize {
//        get {
//            return layer.shadowOffset
//        }
//        set {
//            layer.shadowOffset = newValue
//        }
//    }
//    
//    /// SwifterSwift: Shadow opacity of view; also inspectable from Storyboard.
//    @IBInspectable public var shadowOpacity: Float {
//        get {
//            return layer.shadowOpacity
//        }
//        set {
//            layer.shadowOpacity = newValue
//        }
//    }
//    
//    /// SwifterSwift: Shadow radius of view; also inspectable from Storyboard.
//    @IBInspectable public var shadowRadius: CGFloat {
//        get {
//            return layer.shadowRadius
//        }
//        set {
//            layer.shadowRadius = newValue
//        }
//    }
//    
//    
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//    
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//}
//
//
//
//extension UIView {
//    
//    // OUTPUT 1
//    func dropShadow(scale: Bool = true) {
//        self.layer.masksToBounds = false
//        self.layer.shadowColor = UIColor.black.cgColor
//        self.layer.shadowOpacity = 0.5
//        self.layer.shadowOffset = CGSize(width: -1, height: 1)
//        self.layer.shadowRadius = 1
//        
//        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
//        self.layer.shouldRasterize = true
//        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
//    }
//    
//    // OUTPUT 2
//    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
//        self.layer.masksToBounds = false
//        self.layer.shadowColor = color.cgColor
//        self.layer.shadowOpacity = opacity
//        self.layer.shadowOffset = offSet
//        self.layer.shadowRadius = radius
//        
//        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
//        self.layer.shouldRasterize = true
//        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
//    }
//}
//
//public enum R_TrasitionStyle:Int{
//    case leftToRight
//    case rightToLeft
//    case topToBottom
//    case bottomToTop
//}
//
//extension UIViewController{
//    
//    
//    var transitionStyle: R_TrasitionStyle{
//        get{
//            return R_TrasitionStyle.leftToRight
//        }
//        set{
//            let transition = CATransition()
//            transition.duration = 0.4
//            transition.type = kCATransitionPush
//            switch newValue {
//            case .leftToRight:
//                transition.subtype = kCATransitionFromLeft
//                apply(customTransition: transition)
//            case .rightToLeft:
//                transition.subtype = kCATransitionFromRight
//                apply(customTransition: transition)
//            case .topToBottom:
//                transition.subtype = kCATransitionFromTop
//                apply(customTransition: transition)
//            case .bottomToTop:
//                transition.subtype = kCATransitionFromBottom
//                apply(customTransition: transition)
//            }
//        }
//    }
//    func apply(customTransition: CATransition){
//        self.view.window!.layer.add(customTransition, forKey: kCATransition)
//    }
//}
//
//
//extension CALayer {
//    var borderWidthIB: NSNumber {
//        get {
//            return NSNumber(value: Float(borderWidth))
//        }
//        set {
//            borderWidth = CGFloat(newValue.floatValue)
//        }
//    }
//    var borderColorIB: UIColor? {
//        get {
//            return borderColor != nil ? UIColor(cgColor: borderColor!) : nil
//        }
//        set {
//            borderColor = newValue?.cgColor
//        }
//    }
//    var cornerRadiusIB: NSNumber {
//        get {
//            return NSNumber(value: Float(cornerRadius))
//        }
//        set {
//            cornerRadius = CGFloat(newValue.floatValue)
//        }
//    }
//}
//
//
//
