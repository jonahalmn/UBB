//
//  EndViewController.swift
//  UBB
//
//  Created by Jonah Alle Monne on 29/01/2018.
//  Copyright © 2018 Sébastien Gaya. All rights reserved.
//

import UIKit
import Firebase
import Alamofire
import SwiftyJSON

class EndViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var persister = highscorePersister()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "Votre Score: " + String(persister.score)
        
        if persister.score == 3 {
            resultLabel.text = "Bravo, vous avez gagné !"
            imageView.image = UIImage(named: "UBBFCG_AVEI_CAZEAUX_LESGOURGUES_CONNOR")
            
            instructionLabel.text = "Inscription en cours..."
            if let userID = FIRAuth.auth()?.currentUser?.uid {
                let params: Parameters = [
                    "user_id": userID,
                    "game_id": 2
                ]
                
                Alamofire.request("https://api.sebastiengaya.fr", method: .post, parameters: params).responseJSON { (response) in
                    if response.result.isSuccess {
                        print("Réponse de l'API !")
                        let tokenJSON: JSON = JSON(response.result.value!)
                        if let token = tokenJSON["token"].string {
                            let ref = FIRDatabase.database().reference()
                            ref.child("users").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
                                let value = snapshot.value as? NSDictionary
                                var currentTokens = value?["tokens"] as? [String] ?? []
                                currentTokens.append(token)
                                ref.child("users").child(userID).setValue(["tokens": currentTokens])
                                self.instructionLabel.text = "Votre token est : \(token)"
                            })
                        } else if let error = tokenJSON["error"].dictionaryObject {
                            print(error["message"] as? String ?? "")
                            switch (error["code"] as! Int) {
                            case 4:
                                self.instructionLabel.text = "Vous avez déjà un token de ce jeu."
                                break
                            default:
                                self.instructionLabel.text = "Erreur API"
                            }
                        }
                    } else {
                        print("Erreur: \(response.result.error!)")
                        self.instructionLabel.text = "Problème de connexion"
                    }
                }
            }
        }else{
            resultLabel.text = "Vous avez perdu..."
            instructionLabel.text = "Retentez votre chance"
            imageView.image = UIImage(named: "UBBST_BRAID")
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
