
import Alamofire

public class R_Webservice
{
//    private init()
//    {
//        
//    }
    
    public struct R_JsonResponds{
       public var status : Bool = false
       public var object : Any? = nil
      
    }

    
 
    // Post Method
    
    class func Post_Call(urlString: String, paramters: [String: Any], completion: @escaping(Bool,R_JsonResponds?) -> Void)
    {
       var jsonResponse_object = R_JsonResponds()
        print(" Post Call Url \(urlString) \n Parameters \(paramters)")
    
       
        Alamofire.request(urlString, method: .post, parameters: paramters, headers: nil).authenticate(user: "dev", password: "dev").responseJSON { (response) in
       
        switch(response.result)
        {
        case .success(_):
            
            if response.result.value != nil
            {
                if let responseDictionary:NSDictionary = response.result.value as? NSDictionary
                {
                    print("Post call Success \(responseDictionary)")
                    
                    if responseDictionary["ErrorCode"] as! Int == 1
                    {
                        print("Post call Error Message \(responseDictionary["Message"] as Any)")
                        jsonResponse_object.status = false
                        jsonResponse_object.object = responseDictionary["Message"]
                        completion(true,jsonResponse_object)
                    }
                    else
                    {
                       // print("Post call Data \(responseDictionary["Data"] as Any)")
                        jsonResponse_object.status = true
                        jsonResponse_object.object = responseDictionary
                        print(responseDictionary)
                        completion(true,jsonResponse_object)
                    }
                    
                }
            }

            break
            
        case .failure(_):
            print("Post call Failed \(response.result.error as Any)")
            completion(false,nil)
            break
            
            
        }
            
            
        }
        
        
    }
    
    
    
    
    class func Get_Call(urlString: String, parameters: [String: Any], completion: @escaping(Bool,R_JsonResponds?) -> Void)
    {
       var jsonResponse_object = R_JsonResponds()
      
        Alamofire.request(urlString, method: .get, parameters: parameters, headers: nil).authenticate(user: "dev", password: "dev").responseJSON { (response) in
            
            switch(response.result)
            {
            case .success(_):
                
                if response.result.value != nil
                {
                    if let responseDictionary : NSDictionary = response.result.value as? NSDictionary
                    {
                        if responseDictionary["ErrorCode"] as! Int != 0
                        {
                           jsonResponse_object.status = false
                           jsonResponse_object.object = responseDictionary["Message"]
                            completion(true, jsonResponse_object)
                            
                            
                        }
                        else
                        {
                            jsonResponse_object.status = true
                            jsonResponse_object.object = responseDictionary
                            print(responseDictionary)
                            completion(true,jsonResponse_object)
                        }
                        
                    }
                }
                
                break
                
            case .failure(_):
              
                completion(false,nil)
                break
                
            }
         
            
            
        }
        
    }
    
    
}










