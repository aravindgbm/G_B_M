//
//  TutorialScreenViewController.swift
//  LearnsersIndia
//
//  Created by macbook on 10/03/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit
import ImageIO
import FLAnimatedImage

var loginORSign = ""

class TutorialScreenViewController: UIViewController,navigateProtocol {

    func loginNavigateFunction()
    {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func boardNavigateFunction()
    {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "YourBoardViewController") as! YourBoardViewController
//        self.present(vc, animated: true, completion: nil)
            self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func signUPNavigateFunction()
    {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        self.navigationController?.pushViewController(vc, animated: true)
//        self.present(vc, animated: true, completion: nil)
    }
    
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var pageControl: UIPageControl!
    
    var array_1 = ["","Mathematics is the art of giving the same name to different things.","Pure mathematics is in its way the poetry of logical ideas.","God used beautiful mathematics in creating the world.","Mathematics is the music of reason"]
    
    var array_2 = ["","- Henri Poincare","- Albert Einstein","- Paul Dirac","- James Joseph Sylvester"]
    var gifArray = ["","gif_one","gif_two","gif_one","gif_two"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.pageControl.transform = CGAffineTransform(scaleX: 1, y: 1);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func LoginButton(_ sender: Any)
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "UserTypePopUpViewController") as! UserTypePopUpViewController
        loginORSign = "login"
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func SignUpButton(_ sender: Any)
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "UserTypePopUpViewController") as! UserTypePopUpViewController
        loginORSign = "sign"
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
   
    //    image url
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension TutorialScreenViewController: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
//        if section == 0
//        {
//        return 1
//        }
//        else
//        {
        return 5
 //       }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if indexPath.row == 0
        {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TutorialScreenCharacterCollectionViewCell", for: indexPath) as! TutorialScreenCharacterCollectionViewCell
          return cell
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TutorialScreenCollectionViewCell", for: indexPath) as! TutorialScreenCollectionViewCell
            cell.label_1.text = array_1[indexPath.row]
            cell.label_2.text = array_2[indexPath.row]
            
            
            let gifImageUrl = Bundle.main.path(forResource: gifArray[indexPath.row], ofType: "gif")
            let gifData = try? Data(contentsOf: URL(fileURLWithPath: gifImageUrl!))
            let animGIFImage = FLAnimatedImage(animatedGIFData: gifData)
            cell.imageview.animatedImage = animGIFImage
            
            
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let width = collectionView.bounds.width
        let height = collectionView.bounds.height
        
        return CGSize(width: width, height: height)
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    {
        let x = scrollView.contentOffset.x
        let w = scrollView.bounds.size.width
        let currentPage = Int(ceil(x/w))
        
        print("current page \(currentPage)")
        self.pageControl.currentPage = currentPage
        // Do whatever with currentPage.
        
        
    }
    
}



