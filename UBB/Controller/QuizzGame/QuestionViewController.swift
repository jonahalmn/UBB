//
//  QuestionViewController.swift
//  QRCodeReader
//
//  Created by Bastien Bahuet on 23/01/2018.
//  Copyright © 2018. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    var allQuestions = QuestionBank()
    var persister = highscorePersister()
    var questionIndex: Int = 0
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet var anwersButtons: [UIButton]!
    @IBOutlet weak var answer: UILabel!
    @IBOutlet weak var NextQuestion: UIButton!
    
    var pickedAnswer = " "
    
    @IBOutlet weak var idQuestion: UILabel!
    
    var currentQuestion = Question(title: "title", answers: ["title"], correctAnswer: "title")
    
    @IBAction func nextStep(_ sender: Any) {
        if persister.isFinished(){
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "endViewController") as! EndViewController
            self.present(nextViewController, animated:true, completion:nil)
        }else{
            dismiss(animated: true, completion: nil)
        }
    }
    
    
    
    @IBAction func UserTapAnswer(_ sender: UIButton) {
        persister.questionDone(questionIndex)
        print(String((sender.titleLabel?.text)!))
        
//        switch (sender.tag){
//        case 1:
//            answer.text = "mauvaise réponse"
//            break
//        case 2:
//            answer.text = "bonne réponse"
//            NextQuestion.isHidden = false
//            break
//        case 3:
//            answer.text = "mauvaise réponse"
//            break
//        default:
//            print("Il y a un soucis")
//        }
        
        if String((sender.titleLabel?.text)!) == currentQuestion.correctAnswer {
            answer.text = "Bonne réponse !"
            answer.isHidden = false
            NextQuestion.isHidden = false
            persister.correctAnswer()
            for button in anwersButtons{
                button.isHidden = true
            }
        }else{
            answer.text = "Mauvaise réponse..."
            NextQuestion.isHidden = false
            answer.isHidden = false
            for button in anwersButtons{
                button.isHidden = true
            }
        }
    }
    
    func checkAnswer(){
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        answer.isHidden = true
        NextQuestion.isHidden = true
        idQuestion.text = "QUESTION " + String(questionIndex)
        currentQuestion = allQuestions.list[questionIndex]
        questionLabel.text = currentQuestion.title
        var i = 0
        for answer in currentQuestion.answers {
            anwersButtons[i].setTitle(answer, for: UIControlState.normal)
            i += 1
            print("gors fdp")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
