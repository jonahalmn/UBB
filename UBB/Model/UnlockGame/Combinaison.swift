//
//  Combinaison.swift
//  unlockMe
//
//  Created by Jonah Alle Monne on 18/11/2017.
//  Copyright © 2017 Jonah Alle Monne. All rights reserved.
//

import Foundation
class Combinaison {
    var codeArray = [Int]()
    var length = 4
    
    init() {
        for _ in 0...length{
            codeArray.append(Int(arc4random_uniform(UInt32(100))))
        }
    }
    
    init(length: Int) {
        self.length = length
        if(self.length != 1){
        for _ in 0...self.length - 1{
            codeArray.append(Int(arc4random_uniform(UInt32(100))))
            }
            
        }else{
            codeArray.append(Int(arc4random_uniform(UInt32(100))))
        }
    }
    
}
