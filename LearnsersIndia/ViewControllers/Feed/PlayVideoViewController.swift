//
//  PlayVideoViewController.swift
//  LearnsersIndia
//
//  Created by macbook on 31/03/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import Alamofire

class PlayVideoViewController: UIViewController {

//    let controller = AVPlayerViewController()
    
    @IBOutlet weak var videoPreviewLayer: UIView!
    var player: AVPlayer!
    var avpController = AVPlayerViewController()
    var url = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(url)


    }
    

    
    func playVideo(urlString:String)
    {
        DispatchQueue.main.async
        {
            let player = AVPlayer(url: URL(string: urlString)!)

            self.avpController.view.frame = self.videoPreviewLayer.frame
            self.view.addSubview(self.avpController.view)
            self.avpController.didMove(toParentViewController: self)
            self.avpController.player = player
//            self.avpController.showsPlaybackControls = true
//            player.isClosedCaptionDisplayEnabled = true
//            if #available(iOS 11.0, *)
//            {
//                self.avpController.entersFullScreenWhenPlaybackBegins = true
//            }
//            else
//            {
//                // Fallback on earlier versions
//            }
            player.play()
            
            self.addChildViewController(self.avpController)
            self.view.addSubview(self.avpController.view)
        }

    }
    
    @IBAction func backButton(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    

    
    override func viewWillAppear(_ animated: Bool)
    {
         self.webcall()
    }
    
//    override func viewWillDisappear(animated: Bool) {
//        audioPlayer.pause()
//        audioPlayer.currentItem = nil
//    }
    
    
//    override func viewWillDisappear(_ animated: Bool)
//    {
//        player.pause()
//        //player.currentItem = nil
//    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
  
    
    func webcall()
    {

                let user = "Authorization"
        
                let password = "Bearer f975e748b7fccb6e3db8b06d152879fd"
        
                let credentialData = "\(user):\(password)".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
        

        
        let base64Credentials = credentialData.base64EncodedString()
        
        
        
        let headers = [
            "Authorization": "Bearer f975e748b7fccb6e3db8b06d152879fd",
            "Accept": "application/json",
            "Content-Type": "application/json" ]
        

        
        Alamofire.request(url, method: .get, parameters: nil,encoding: URLEncoding.default, headers: headers) .responseJSON { response in
            switch response.result
            {
            case .success(_):
                
                print("sucess")
                print(response.result.value)
                
               
                if response.result.value != nil
                {
                    if let responseDic:NSDictionary = response.result.value as? NSDictionary
                    {
                        print(responseDic)
//                        if responseDic.object(forKey: "error") as! String
//
//                            let message = responseDic.object(forKey: responseDic.object(forKey: "error") as! String) as! String
//                            let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
//                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
//                            self.present(alert, animated: true, completion: nil)

                       if let error = responseDic.object(forKey: "error") as? String
                       {
                                                    let alert = UIAlertController(title: "Error", message: error, preferredStyle: UIAlertControllerStyle.alert)
                                                   // alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
                            print("you have pressed the ok button")
                           // self.dismiss(animated: true, completion: nil)
                            self.navigationController?.popViewController(animated: true)
                        }))
                                                    self.present(alert, animated: true, completion: nil)
                        }
                        else
                       {
                        let arrayy = responseDic.object(forKey: "files") as! NSArray
                        
                        let dic = arrayy[0] as! NSDictionary
                        let videoURL = dic.object(forKey: "link") as! String
                        print(videoURL)
                        
                        self.playVideo(urlString: videoURL)
                        }
                            
 
                        
                        
                    }
                }
                
                
                
                 break
                //your success code
            case .failure(_):
                
                print("failed")
                break
                
            }
 
            //your failure code
        }
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


import AVKit

class LandscapeAVPlayerController: AVPlayerViewController
{
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask
    {
        return .landscapeLeft
    }
}
