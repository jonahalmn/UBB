//
//  TimeChallengeGame.swift
//  unlockMe
//
//  Created by Jonah Alle Monne on 18/11/2017.
//  Copyright © 2017 Jonah Alle Monne. All rights reserved.
//

import Foundation

class TimeChallengeGame{
    
    var timerDown: Timer!
    var countdown = 10.0
    var level = 0
    var currentGame = Game()
    
    init() {
        self.currentGame.status = .over
        self.currentGame.securityCode = Combinaison(length: 1)
    }
    
    func timeout() -> Void {
        stopCountdown()
        self.currentGame.status = .timeout
    }
    
    func startGame() {
        level = 0
        currentGame.startGame()
        nextLevel()
    }
    
    func nextLevel(){
        self.level += 1
        currentGame.securityCode = Combinaison(length: level)
        currentGame.step = 0
        stopCountdown()
        currentGame.startGame()
        countdown = Double(level) * 1.0 + 6.0
        startCountdown()
    }
    
    
    //CountDown Functions
    
    func startCountdown(){
        self.timerDown = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector:#selector(updateCountdown), userInfo: nil, repeats: true)
    }
    
    func stopCountdown(){
        self.timerDown?.invalidate()
    }
    
    @objc func updateCountdown(){
        if currentGame.status == .ongoing{
        if(countdown > 0.0){
        self.countdown -= 0.1
            print("zidane")
        }else{
            print("no time")
            self.countdown = 0.0
            self.timeout()
            }
            
        }
    }
    
    
    
}
