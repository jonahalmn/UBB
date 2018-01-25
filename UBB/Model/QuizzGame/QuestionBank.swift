//
//  QuestionBank.swift
//  QRCodeReader
//
//  Created by Jonah Alle Monne on 23/01/2018.
//  Copyright © 2018. All rights reserved.
//

import Foundation

class QuestionBank {
    
    var list : [Question]
    
    init() {
        
        list = [Question(title: "Qui est le plus grand des joueurs ci-dessous ?", answers: ["X","Y","Z"], correctAnswer: "X")]
        
        list.append(Question(title: "Combien mesure le tour de pec de X ?", answers: ["75","62","110"], correctAnswer: "75"))
        
        list.append(Question(title: "Combien mesure le terrain en longueur ?", answers: ["75m","90m","100m"], correctAnswer: "100m"))
        
        list.append(Question(title: "Quel est la pointure de chaussure de Léo ?", answers: ["49","54","57"], correctAnswer: "54"))
        
        list.append(Question(title: "Combien de places contient le stade Chaban ?", answers: ["32 000","27 000","40 000"], correctAnswer: "32 000"))
        
        list.append(Question(title: "Combien pèse X ?", answers: ["75","92","110"], correctAnswer: "92"))
        
        list.append(Question(title: "En quelle année l'UBB a-t-il été crée ?", answers: ["1996","2004","2008"], correctAnswer: "2008"))
        
        list.append(Question(title: "Combien de joueurs sont tatoués ?", answers: ["5","12","17"], correctAnswer: "12"))
        
        list.append(Question(title: "Combien d'internationaux ont porté les couleurs de l'UBB ?", answers: ["17","32","45"], correctAnswer: "32"))
        
    }
    
    
}
