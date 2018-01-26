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
    //var scoreQuestion: Int
    //var scoreUnlock: Double
    
    init() {
        if (UserDefaults.standard.object(forKey: "Answered") as? Int) != nil {
            self.answered = (UserDefaults.standard.object(forKey: "Answered") as? [Int])!
        }else{
            self.answered = []
        }
    }
    
    func questionDone(_ id: Int) -> Void {
        self.answered.append(id)
        UserDefaults.standard.set(self.answered,forKey:"Answered")
    }
    
    func isAnswered(_ id: Int) -> Bool {
        for ids in answered {
            if ids == id{
                return true
            }
        }
        return false
    }
    
    func resetQuestion(){
        self.answered = [] 
        UserDefaults.standard.set(self.answered,forKey:"Answered")
    }
}
