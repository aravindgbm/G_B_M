//
//  Common.swift
//  Romana
//
//  Created by Appzoc-Macmini on 29/11/17.
//  Copyright © 2017 Appzoc-Macmini. All rights reserved.
//

import Foundation
import UIKit

class WebHelper
{
    static let baseUrl = "https://romana-water.dev.webcastle.in/api/"
    static let EngagebaseUrl = "https://romana-water.dev.webcastle.in/api/"
    static let SapbaseUrl = "https://romana-water.dev.webcastle.in/api/"
    
    static let unixTime = "12345"
        //String(describing: NSDate().timeIntervalSince1970)
    static let tokenKey = "appzoc"
    
    
   
}



// Mark:- FLUnwrapper for unwrapping strings integers double values

public class R_Unwraper
{
    class func isEmptyString(string: String?)-> String
    {
      if let newString = string
      {
      return newString
      }
      else
      {
       return ""
       }
        
    }
    
 class func isEmptyInteger(int: Int?)-> Int
 {
        if let newInt = int
        {
        return newInt
        }
        else
        {
        return 0
        }
 }
   
 class func isEmptyDouble(double: Double?)-> Double
 {
         if let newDouble = double
         {
         return newDouble
         }
         else
         {
         return 0.0
         }
 }
    
//    class func isEmptyBool(bool: Bool) -> Bool
//    {
//        if let newBool = bool
//        {
//            return newBool
//        }
//        else
//        {
//            return false
//        }
//    }
    
}
