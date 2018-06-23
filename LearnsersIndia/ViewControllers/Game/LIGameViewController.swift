//
//  LIGameViewController.swift
//  LearnsersIndia
//
//  Created by GB Mainframe LLP on 23/06/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit
import AVKit

class LIGameViewController: UIViewController {
    
    struct LIGameTableViewCellIdentifiers {
        static let QuestionHeader = "questionHeader"
        static let AnswerOption = "answerOptionsCell"
    }
    
    @IBOutlet weak var gameTableView: UITableView!
    @IBOutlet weak var fiftyFiftyButton: UIButton!
    @IBOutlet weak var extraLifeButton: UIButton!
    
    var levelDetailsView:LIShowLevelView?
    var gameLevelObject:LIGameLevelModel?
    var isLastLevel:Bool = false
    var firstAudioPlayed:Bool = false
    var gameObject:LIGameModel?
    var isQuestionAnswered:Bool = false
    var selectedOptionRowIndex:Int?
    var player = AVPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showlevelDetails()
        self.navigationItem.title = self.gameLevelObject?.levelName
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            print("AVAudioSession Category Playback OK")
            do {
                try AVAudioSession.sharedInstance().setActive(true)
                print("AVAudioSession is Active")
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showlevelDetails(){
        self.levelDetailsView = LIShowLevelView(frame: self.view.bounds)
        self.levelDetailsView?.setLevelText(self.gameLevelObject?.levelName)
        if let _ = self.levelDetailsView {
            self.view.addSubview(self.levelDetailsView!)
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                self.removeLevelDetailsViewAndUpdate()
            }
        }
    }
    
    func removeLevelDetailsViewAndUpdate(){
        self.levelDetailsView?.removeFromSuperview()
        self.callGetGameQuestionApi()
    }
    
    func setUpView(){
        if !firstAudioPlayed {
            self.playAudioFrom(self.gameObject?.firstAudioUrl)
        }
        self.gameTableView.estimatedRowHeight = 40.0
        self.gameTableView.rowHeight = UITableViewAutomaticDimension
        self.gameTableView.estimatedSectionHeaderHeight = 50.0
        self.gameTableView.sectionHeaderHeight = UITableViewAutomaticDimension
        self.gameTableView.dataSource = self
        self.gameTableView.delegate = self
        self.gameTableView.reloadData()
    }
    
    //   MARK: - Navigation
    func navigateToNextScreen(){
        self.player.pause()
        if let levelId = self.gameLevelObject?.levelId {
            let (levelObject,islastLevel) = LIGameManager.sharedInstance.getNextLevelWithLevelId(levelId)
            
            if !islastLevel && levelObject != nil {
                let storyBoard = UIStoryboard.init(name: LIStoryboards.Home, bundle: nil)
                let gameVC = storyBoard.instantiateViewController(withIdentifier: LIViewControllerIdentifier.GameViewController) as? LIGameViewController
                gameVC?.gameLevelObject = levelObject
                gameVC?.isLastLevel = islastLevel
                self.navigationController?.pushViewController(gameVC!, animated: true)
            }
            else {
                self.navigateToFinalScoreScreen()
            }
        }
        
    }
    
    func playAudioFrom(_ urlString:String?){
        if let _ = urlString {
            if let url = URL(string: urlString!) {
                let playerItem = AVPlayerItem(url: url)
                if !self.firstAudioPlayed{
                    NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying(notif:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
                }
                self.player = AVPlayer(playerItem: playerItem)
        
                player.volume = 5.0
                player.play()

            }
        }
    }
//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//
//    }
    
    @objc func playerDidFinishPlaying(notif: NSNotification) {
        if !firstAudioPlayed {
            self.firstAudioPlayed = true
            self.playAudioFrom(self.gameObject?.secondAudioUrl)
        }
    }
    func navigateToFinalScoreScreen(){
        self.player.pause()
        let storyBoard = UIStoryboard.init(name: LIStoryboards.Home, bundle: nil)
        let finalScoreVC = storyBoard.instantiateViewController(withIdentifier: LIViewControllerIdentifier.FinalScoreViewController) as? LIFinalScoreViewController
        finalScoreVC?.isFromGame = true
        self.navigationController?.pushViewController(finalScoreVC!, animated: true)
    }
    
    func showGameQuestionFetchErrorAlertWithMessage(_ message:String?) {
        let alert = UIAlertController(title: LIConstants.errorAlertTitle, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            self.navigateToFinalScoreScreen()
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }

    func updateSelectedOptionAt(_ index:Int){
        self.isQuestionAnswered = true
        self.selectedOptionRowIndex = index
        self.gameTableView.reloadData()
        LIGameManager.sharedInstance.updateScoreWithSelectedOption(self.gameObject?.optionsArray?[index], and: self.gameLevelObject?.levelId
        )
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
            
            if self.gameObject?.optionsArray?[index].isCorrectOption ?? false{
                self.navigateToNextScreen()
            }
            else {
                self.navigateToFinalScoreScreen()
            }
        }
    }
    
    /*
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: - IBActions
    
    @IBAction func backButtonTapped(_ sender: Any) {
        LIUtilities.showQuitGameALertOnViewController(self)
    }
    
    @IBAction func quitButtonTapped(_ sender: Any) {
        LIUtilities.showQuitGameALertOnViewController(self)
    }
    
    @IBAction func fiftyFiftyButtonTapped(_ sender: Any) {
    }
    @IBAction func extraLifeButtonTapped(_ sender: Any) {
    }
}

extension LIGameViewController {
    
    func callGetGameQuestionApi(){
        
        ActivityIndicator.setUpActivityIndicator(baseView: self.view)
        let parameters:[String:Any] = ["level":self.gameLevelObject?.levelId as Any]
        LIUserStudentAPIsHandler.callGetGameQuestionAPIWith(parameters, shouldAddToken: true, success: { (response) in
            ActivityIndicator.dismissActivityView()
            if let _ = response {
                self.gameObject = response
                self.setUpView()
            }
            else {
                self.showGameQuestionFetchErrorAlertWithMessage(LIConstants.tryAgainMessage)
            }
        }, failure: { (responseMessage) in
            ActivityIndicator.dismissActivityView()
            self.showGameQuestionFetchErrorAlertWithMessage(responseMessage)
        }) { (error) in
            ActivityIndicator.dismissActivityView()
            self.showGameQuestionFetchErrorAlertWithMessage(error?.localizedDescription)
        }
        
    }
}

extension LIGameViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.gameObject?.optionsArray?.count ?? 0 > 0 {
            return 1
        }
        return 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.gameObject?.optionsArray?.count ?? 0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: LIGameTableViewCellIdentifiers.QuestionHeader) as? LIGameQuestionHeaderTableViewCell
        header?.refreshCellWith(self.gameObject?.gameQuestionString)
        return header
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LIGameTableViewCellIdentifiers.AnswerOption, for: indexPath) as? LIGameAnswerOptionsTableViewCell
        cell?.refreshCellWith(self.gameObject?.optionsArray?[indexPath.row], isQuestionAnswered: self.isQuestionAnswered, and: self.selectedOptionRowIndex == indexPath.row)
        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < self.gameObject?.optionsArray?.count ?? 0 {
            if !self.isQuestionAnswered {
                self.updateSelectedOptionAt(indexPath.row)
            }
        }
    }
}
