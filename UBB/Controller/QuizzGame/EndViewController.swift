//
//  EndViewController.swift
//  UBB
//
//  Created by Jonah Alle Monne on 29/01/2018.
//  Copyright © 2018 Sébastien Gaya. All rights reserved.
//

import UIKit

class EndViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var instructionLabel: UILabel!
    
    var persister = highscorePersister()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "Votre Score: " + String(persister.score)
        
        if persister.score == 3 {
            resultLabel.text = "Bravo vous avez gagné"
            instructionLabel.text = "Votre ticket est sur votre espace perso"
        }else{
            resultLabel.text = "Quel échec"
            instructionLabel.text = "Retentez votre chance"
        }
        // Do any additional setup after loading the view.
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
