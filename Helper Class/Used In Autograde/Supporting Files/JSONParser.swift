//
//  JSONParser.swift
//  SimpleJSONParse
//
//  Created by Appzoc on 22/01/18.
//  Copyright © 2018 Appzoc. All rights reserved.
//

import Foundation
import Alamofire

class JSONParser{
    
    let delegate:JSONParserDelegate
    let url:String
    let httpMethod:HTTPMethod
    let parameters:[String:Any]
    let model:ModelType
    
    init(url:String,httpMethod:HTTPMethod,parameters:[String:Any]?,delegate:JSONParserDelegate, into model:ModelType) {
        self.url = url
        self.httpMethod = httpMethod
        self.parameters = parameters ?? [:]
        self.delegate = delegate
        self.model = model
        
    }
    
    func callWebService(){
        print("Webcall initiate")
        Alamofire.request(url, method: self.httpMethod, parameters: self.parameters, encoding: JSONEncoding.default , headers: nil).authenticate(user: "vts01", password: "Vts@2017").responseJSON { (response) in
            //print(response.result.value!)
            switch response.result{
            case .success(let validJSON):
                print("Call Success")
                print(validJSON)
                //let tempJSON = validJSON as! [String:Any]
                //print(tempJSON)
                // let jsonData = tempJSON
                //print(jsonData)
                //let jsonDataField = jsonData["Data"] as! [String:Any]
                do{
                    let jsonObject = try JSONSerialization.data(withJSONObject: validJSON, options: .prettyPrinted)
                    self.extractModelFromData(modelData: jsonObject)
                }catch
                {
                    print(error)
                    self.delegate.NoResponse(error: error)
                }
                
            //print(validJSON)
            case .failure(let failCause):
                print("Call Failure")
                self.delegate.didReturnWithError(error: failCause)
            }
        }
    }
    
    func extractModelFromData(modelData:Data){
        print("Extracting Model")
        let decoder = JSONDecoder()
        do {
            switch model {
            case .LoginResponse:
                let populatedModel = try decoder.decode(LoginResponse.self, from: modelData)
                delegate.operateOnJSONResult(model: populatedModel)
                
            case .AllVehicleCount:
                let populatedModel = try decoder.decode(AllVehicleCount.self, from: modelData)
                delegate.operateOnJSONResult(model: populatedModel)
                
            case .VehicleListing:
                let populatedModel = try decoder.decode(VehicleListing.self, from: modelData)
                delegate.operateOnJSONResult(model: populatedModel)
                
            case .VehicleListingMoving:
                let populatedModel = try decoder.decode(VehicleListingMoving.self, from: modelData)
                delegate.operateOnJSONResult(model: populatedModel)
                
            case .VehicleListingStop:
                let populatedModel = try decoder.decode(VehicleListingStop.self, from: modelData)
                delegate.operateOnJSONResult(model: populatedModel)
                
            case .VehicleListingHalt:
                let populatedModel = try decoder.decode(VehicleListingHalt.self, from: modelData)
                delegate.operateOnJSONResult(model: populatedModel)
                
            case .VehicleListingLost:
                let populatedModel = try decoder.decode(VehicleListingLost.self, from: modelData)
                delegate.operateOnJSONResult(model: populatedModel)
                
            case .VehicleDetailReponse:
                let populatedModel = try decoder.decode(VehicleDetailReponse.self, from: modelData)
                delegate.operateOnJSONResult(model: populatedModel)
            case .UsageResponse:
                let populatedModel = try decoder.decode(UsageResponse.self, from: modelData)
                delegate.operateOnJSONResult(model: populatedModel)
            case .TripManagementResponse:
                let populatedModel = try decoder.decode(TripManagementResponse.self, from: modelData)
                delegate.operateOnJSONResult(model: populatedModel)
            case .TripnameList:
                let populatedModel = try decoder.decode(TripnameList.self, from: modelData)
                delegate.operateOnJSONResult(model: populatedModel)

            case .saveTrip:
                let populatedModel = try decoder.decode(saveTrip.self, from: modelData)
                delegate.operateOnJSONResult(model: populatedModel)
            case .SearchResponse:
                let populatedModel = try decoder.decode(SearchResponse.self, from: modelData)
                delegate.operateOnJSONResult(model: populatedModel)
            case .HistoryTrackingDataResponse:
                let populatedModel = try decoder.decode(HistoryTrackingDataResponse.self, from: modelData)
                delegate.operateOnJSONResult(model: populatedModel)
        
            }
            
            
        } catch {
            print("error trying to convert data to JSON")
            delegate.didReturnWithError(error: error)
            
        }
    }
}

enum ModelType
{
    case LoginResponse
    case AllVehicleCount
    case VehicleListing
    case VehicleListingLost
    case VehicleListingMoving
    case VehicleListingStop
    case VehicleListingHalt
    case VehicleDetailReponse
    case UsageResponse
    case TripManagementResponse
    case TripnameList
    case saveTrip
    case SearchResponse
    case HistoryTrackingDataResponse
}

protocol JSONParserDelegate
{
    func operateOnJSONResult(model:Any)
    func didReturnWithError(error:Error)
    func NoResponse(error: Error)
}

