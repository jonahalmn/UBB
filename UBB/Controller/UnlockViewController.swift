//
//  ViewController.swift
//  unlockMe
//
//  Created by Jonah Alle Monne on 18/11/2017.
//  Copyright © 2017 Jonah Alle Monne. All rights reserved.
//

import UIKit
import CoreMotion
import AudioToolbox

class UnlockViewController: UIViewController {
    @IBOutlet weak var userInput: UILabel!
    @IBOutlet weak var gameProgression: UILabel!
    @IBOutlet weak var gameHint: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    @IBOutlet weak var lockerview: UIView!
    @IBOutlet weak var button: UIImageView!
    
    @IBOutlet var combinaisonLabel: [UILabel]!
    
    var timeGame = TimeChallengeGame()
    var game = Game()
    var persister = HighscorePersister()
    var manager = CMMotionManager()
    var codeToSend = 0
    
    
    func hideX(){
        for var i in 0...combinaisonLabel.count - 1 {
            combinaisonLabel[i].isHidden = true
        }
    }
    
    func seeX(){
        for var i in 0...combinaisonLabel.count - 1 {
            combinaisonLabel[i].isHidden = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background")
        self.view.insertSubview(backgroundImage, at: 0)
        if(Modes.name == .chrono){
            timeGame.startGame()
        }else{
            game.startGame()
        }
        // Do any additional setup after loading the view, typically from a nib.
        setHighScoreLabel(persister.highscore)
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector:#selector(refreshTime), userInfo: nil, repeats: true)
        
        if manager.isDeviceMotionAvailable {
            manager.deviceMotionUpdateInterval = 0.01
            manager.startDeviceMotionUpdates(to: OperationQueue.current!) {
                [weak self] (data: CMDeviceMotion?, error: Error?) in
                if let gravity = data?.gravity {
                    let rotation = atan2(gravity.x, gravity.y) - Double.pi
                    
                    self?.button.transform = CGAffineTransform(rotationAngle: CGFloat(rotation))
                    self?.userInput.text = String(Int(rotation * (100 / -6)))
                    self?.codeToSend = Int(rotation * (100 / -6))
                    if Modes.name == .classic{
                        self?.testInput() // Normal Mode
                    }else{
                        self?.timeMode()
                    }
                }
            }
        }
        
        
    }
    
    // CLASSIC ===================================
    
    func testInput(){
        if game.status == .ongoing{
            if game.checkUserInput(self.codeToSend) {
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            }
            
            if game.isUserNear(codeToSend){
                self.gameProgression.text = "Presque"
            }else if gameProgression.text == "Presque"{
                gameProgression.text = "Vous vous éloignez"
            }
            
            if game.validUserInput(codeToSend) {
                SoundPlayer.validSound()
                combinaisonLabel[game.step].text = String(game.currentCode)
                self.gameHint.text = "Vous avez trouvé \(game.step + 1) chiffre"
                self.gameProgression.text = "Au suivant!"
                game.nextStep()
            }
            
        }else{
            self.gameHint.text = "Partie terminée"
            
            self.gameProgression.text = "Vous participez au tirage au sort"
            
            persister.setHighscore(score: game.currentTime)
            setHighScoreLabel(persister.highscore)
        }
        
    }
    
    // TIME MODE ============================
    
    func timeMode(){
        self.gameHint.text = "\(timeGame.level - timeGame.currentGame.step) nombres avant le prochain niveau"
        print(timeGame.level)
        if timeGame.currentGame.status == .ongoing{
            if timeGame.currentGame.checkUserInput(self.codeToSend) {
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            }
            
            if timeGame.currentGame.isUserNear(codeToSend){
                self.gameProgression.text = "Presque"
            }else if gameProgression.text == "Presque"{
                gameProgression.text = "Vous vous éloignez"
            }
            
            if timeGame.currentGame.validUserInput(codeToSend) {
                SoundPlayer.validSound()
                self.gameHint.text = "\(timeGame.level - timeGame.currentGame.step) nombres avant le prochain niveau"
                self.gameProgression.text = "Au suivant!"
                timeGame.currentGame.nextStep()
            }
            
        }else{
            if(timeGame.currentGame.status == .over){
                persister.setLevelMax(level: timeGame.level)
                timeGame.nextLevel()
            }
            
            if(timeGame.currentGame.status == .timeout){
                self.gameHint.text = "Plus de temps mon srab"
                persister.setLevelMax(level: timeGame.level)
            }
        }
        
    }
    
    //modeCountDown
    
    @objc func refreshTime(){
        setTime()
    }
    
    func setTime(){
        if Modes.name == .classic{
            setTimeLabel()
        }else{
            setCountLabel()
        }
    }
    
    @IBAction func restartGame(_ sender: Any) {
        for var i in 0...self.combinaisonLabel.count - 1{
            combinaisonLabel[i].text = "X"
        }
        if(Modes.name == .chrono){
            timeGame = TimeChallengeGame()
            timeGame.startGame()
        }else{
            game = Game()
            game.startGame()
        }
    }
    
    func setTimeLabel(){
        timeLabel.text = String(format:"%.1f", game.currentTime) + "s"
    }
    
    func setCountLabel(){
        timeLabel.text = "Time: " + String(format:"%.1f", timeGame.countdown) + "s"
    }
    
    func setHighScoreLabel(_ score: Double){
        highscoreLabel.text = String(format: "%.1f", score) + "s"
    }
    
    func setHighLevelLabel(_ level: Int){
        highscoreLabel.text = "Highscore: Level" + String(level)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


