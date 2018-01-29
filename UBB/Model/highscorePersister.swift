//
//  highscorePersister.swift
//  UBB
//
//  Created by Jonah Alle Monne on 26/01/2018.
//  Copyright © 2018 Sébastien Gaya. All rights reserved.
//

import Foundation

class highscorePersister {
    var answered: [Int]
    var score : Int
    //var scoreQuestion: Int
    //var scoreUnlock: Double
    
    init() {
        if (UserDefaults.standard.object(forKey: "Answered") as? [Int]) != nil {
            self.answered = (UserDefaults.standard.object(forKey: "Answered") as? [Int])!
        }else{
            self.answered = []
        }
        
        if (UserDefaults.standard.object(forKey: "Score") as? Int) != nil {
            self.score = (UserDefaults.standard.object(forKey: "Score") as? Int)!
        }else{
            self.score = 0
        }
    }
    
    func update() -> Void {
        if (UserDefaults.standard.object(forKey: "Answered") as? [Int]) != nil {
            self.answered = (UserDefaults.standard.object(forKey: "Answered") as? [Int])!
        }else{
            self.answered = []
        }
        
        if (UserDefaults.standard.object(forKey: "Score") as? Int) != nil {
            self.score = (UserDefaults.standard.object(forKey: "Score") as? Int)!
        }else{
            self.score = 0
        }
    }
    
    func questionDone(_ id: Int) -> Void {
        update()
        self.answered.append(id)
        UserDefaults.standard.set(self.answered,forKey:"Answered")
    }
    
    func correctAnswer(){
        update()
        self.score += 1
        UserDefaults.standard.set(self.score,forKey:"Score")
    }
    
    
    func isAnswered(_ id: Int) -> Bool {
        update()
        for ids in answered {
            if ids == id{
                return true
            }
        }
        return false
    }
    
    func isFinished() -> Bool {
        update()
        if answered.count > 2{
            return true
        }else{
            return false
        }
    }
    
    func resetQuestion(){
        self.answered = []
        self.score = 0
        UserDefaults.standard.set(self.answered,forKey:"Answered")
        UserDefaults.standard.set(self.score,forKey:"Score")
    }
    
    func refresh() -> Void {
        
    }
}
