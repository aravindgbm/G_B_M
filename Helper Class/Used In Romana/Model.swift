//
//  Model.swift
//  Romana
//
//  Created by Appzoc-Macmini on 14/12/17.
//  Copyright © 2017 Appzoc-Macmini. All rights reserved.
//

import Foundation

class RegistrationTwo
{
    var Height = [idName]()
    var Complexion = [idName]()
    var NativePlace = [idName]()
    var MaritalStatus = [idName]()
    var PhysicalStatus = [idName]()
    var EducationCategory = [idName]()
    var OccupationCategory = [idName]()
    var EmployedCategory = [idName]()
    var AnualIncome = [idName]()
    var Denomination = [idName]()
    var Createdby = [idName]()
    var Countrycode = [idName]()
    var ErrorCode = 0
    var Message = "Message"
    
    func getData(dataDict:[String:Any]) -> RegistrationTwo
    {
        self.ErrorCode = dataDict["ErrorCode"] as! Int
        self.Message = dataDict["Message"] as! String
        
        let Data = dataDict["Data"] as! [String:Any]
        let HeightArray = Data["Height"] as! [Any]
        let ComplexionArray = Data["Complexion"] as! [Any]
        let NativePlaceArray = Data["NativePlace"] as! [Any]
        let MaritalStatusArray = Data["MaritalStatus"] as! [Any]
        let PhysicalStatusArray = Data["PhysicalStatus"] as! [Any]
        let EducationCategoryArray = Data["EducationCategory"] as! [Any]
        let OccupationCategoryArray = Data["OccupationCategory"] as! [Any]
        let EmployedCategoryArray = Data["EmployedCategory"] as! [Any]
        let AnualIncomeArray = Data["AnualIncome"] as! [Any]
        let DenominationArray = Data["Denomination"] as! [Any]
        let CreatedbyArray = Data["Createdby"] as! [Any]
        let CountrycodeArray = Data["Countrycode"] as! [Any]
        
        for items in HeightArray
        {
            let idNameTemp = idName(dataDict: items as! [String : String])
            self.Height.append(idNameTemp)
        }
        
        for items in ComplexionArray
        {
            let idNameTemp = idName(dataDict: items as! [String : String])
            self.Complexion.append(idNameTemp)
        }
        
        for items in NativePlaceArray
        {
            let idNameTemp = idName(dataDict: items as! [String : String])
            self.NativePlace.append(idNameTemp)
        }
        
        for items in MaritalStatusArray
        {
            let idNameTemp = idName(dataDict: items as! [String : String])
            self.MaritalStatus.append(idNameTemp)
        }
        
        for items in PhysicalStatusArray
        {
            let idNameTemp = idName(dataDict: items as! [String : String])
            self.PhysicalStatus.append(idNameTemp)
        }
        
        for items in EducationCategoryArray
        {
            let idNameTemp = idName(dataDict: items as! [String : String])
            self.EducationCategory.append(idNameTemp)
        }
        
        for items in OccupationCategoryArray
        {
            let idNameTemp = idName(dataDict: items as! [String : String])
            self.OccupationCategory.append(idNameTemp)
        }
        
        for items in EmployedCategoryArray
        {
            let idNameTemp = idName(dataDict: items as! [String : String])
            self.EmployedCategory.append(idNameTemp)
        }
        
        for items in AnualIncomeArray
        {
            let idNameTemp = idName(dataDict: items as! [String : String])
            self.AnualIncome.append(idNameTemp)
        }
        
        for items in DenominationArray
        {
            let idNameTemp = idName(dataDict: items as! [String : String])
            self.Denomination.append(idNameTemp)
        }
        
        for items in CreatedbyArray
        {
            let idNameTemp = idName(dataDict: items as! [String : String])
            self.Createdby.append(idNameTemp)
        }
        
        for items in CountrycodeArray
        {
            let idNameTemp = idName(dataDict: items as! [String : String])
            self.Countrycode.append(idNameTemp)
        }
        
        
        return self
    }
    
}

class idName
{
    var id = "1"
    var name = "name"
    
    init(dataDict:[String:String])
    {
        self.id = dataDict["id"]!
        self.name = dataDict["name"]!
    }
}
