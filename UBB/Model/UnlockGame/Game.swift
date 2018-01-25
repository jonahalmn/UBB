//
//  Game.swift
//  unlockMe
//
//  Created by Jonah Alle Monne on 18/11/2017.
//  Copyright © 2017 Jonah Alle Monne. All rights reserved.
//

import Foundation

class Game {
    
    var securityCode = Combinaison()
    
    //Game essentials
    enum Status {
        case ongoing, over, timeout, done
    }
    var status :Status
    var step = 0
    var timer: Timer!
    var currentTime = 0.0
    var currentCode = 0
    
    //Check time before validation
    var timeCheckPoint = 0.0
    var valueCheckPoint = 0
    
    init() {
        self.status = .ongoing
    }
    
    func startGame(){
        self.status = .ongoing
        startTimer()
    }
    
    func endGame(){
        self.status = .over
        stopTimer()
    }
    
    func checkUserInput(_ keyPass: Int) -> Bool {
        if(valueCheckPoint != keyPass || timeCheckPoint == 0){
            self.valueCheckPoint = keyPass
            self.timeCheckPoint = currentTime
        }
        if keyPass == securityCode.codeArray[step] {
            return true
        }else{
            return false
        }
    }
    
    func isUserNear(_ keyPass: Int) -> Bool{
        if keyPass < securityCode.codeArray[step] + 5 && keyPass > securityCode.codeArray[step] - 5{
            return true
        }else{
            return false
        }
    }
    
    func validUserInput(_ keyPass: Int) -> Bool {
        if currentTime > self.timeCheckPoint + 1 && checkUserInput(keyPass){
            currentCode = securityCode.codeArray[step]
            return true
        }else{
            return false
        }
    }
    
    func nextStep(){
        if step < securityCode.codeArray.count - 1{
        self.step += 1
        }else{
            endGame()
        }
    }
    
    //Timer Functions
    
    func startTimer(){
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector:#selector(Game.updateCurrentTime), userInfo: nil, repeats: true)
    }
    
    func stopTimer(){
        self.timer?.invalidate()
    }
    
    @objc func updateCurrentTime(){
        self.currentTime += 0.1
    }
    
    
}
