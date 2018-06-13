//
//  VideoViewController.swift
//  LearnsersIndia
//
//  Created by Appzoc-Macmini on 27/03/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit
import AVFoundation
import Alamofire

class VideoViewController: UIViewController {
    
    let url = "https://appapi.learnersindia.com/get-videos"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getThumbnail()
    {
        let asset = AVURLAsset(url: URL(fileURLWithPath: "/that/long/path"), options: nil)
        let imgGenerator = AVAssetImageGenerator(asset: asset)
        let cgImage = try! imgGenerator.copyCGImage(at: CMTime(value: 0, timescale: 1), actualTime: nil)
        let uiImage = UIImage(cgImage: cgImage)
        let imageView = UIImageView(image: uiImage)

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




extension VideoViewController
{
    func Post_Call_YourBoard(urlString: String, completion: @escaping(Bool) -> Void)
    {
        let paramters = ["tocken":"",
                         "syl_id":"",
                         "class_id":"",
                         "sub_id":"",
                         "chap_id":""] as [String : Any]
        
        Alamofire.request(urlString, method: .post, parameters: paramters, headers: nil).responseJSON { (response) in
            
            ActivityIndicator.dismissActivityView()
            switch(response.result)
            {
            case .success(_):
                if response.result.value != nil
                {
                    if let responseDic:NSDictionary = response.result.value as? NSDictionary
                    {
                        print(responseDic)
                        if responseDic.object(forKey: "response_type") as! String == "error"
                        {
                            let message = responseDic.object(forKey: "response_text") as! String
                            let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                        else
                        {
                            
                        }
                    }
                }
                
                break
                
            case .failure(_):
                print("Post call Failed \(response.result.error as Any)")
                completion(false)
                break
            }
            ActivityIndicator.dismissActivityView()
        }
    }
}


