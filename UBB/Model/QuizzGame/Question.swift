//
//  Question.swift
//  QRCodeReader
//
//  Created by Jonah Alle Monne on 23/01/2018.
//  Copyright © 2018. All rights reserved.
//

import Foundation

class Question {
    
    var title : String
    var answers : [String]
    var correctAnswer : String
    
    init(title : String, answers : [String], correctAnswer : String) {
        self.title = title
        self.answers = answers
        self.correctAnswer = correctAnswer
    }
    
    
    
}


