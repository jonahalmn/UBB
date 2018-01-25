//
//  HighscorePersister.swift
//  unlockMe
//
//  Created by Jonah Alle Monne on 18/11/2017.
//  Copyright © 2017 Jonah Alle Monne. All rights reserved.
//

import Foundation

class HighscorePersister {
    var highscore: Double
    var levelMax: Int
    
    init() {
        if (UserDefaults.standard.object(forKey: "HighScore") as? Double) != nil {
            self.highscore = (UserDefaults.standard.object(forKey: "HighScore") as? Double)!
        }else{
            self.highscore = 10000000
        }
        
        if (UserDefaults.standard.object(forKey: "levelMax") as? Int) != nil {
            self.levelMax = (UserDefaults.standard.object(forKey: "levelMax") as? Int)!
        }else{
            self.levelMax = 0
        }
    }
    
    func setHighscore(score: Double){
        if(score < self.highscore){
            self.highscore = score
            UserDefaults.standard.set(self.highscore,forKey:"HighScore")
        }
    }
    
    func setLevelMax(level: Int){
        if(level > self.levelMax){
            self.levelMax = level
            UserDefaults.standard.set(self.levelMax,forKey:"levelMax")
        }
    }
}
