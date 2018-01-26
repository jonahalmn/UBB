//
//  QRCodeViewController.swift
//  QRCodeReader
//
//  Created by Bastien on 23/01/2018.
//  Copyright © 2018. All rights reserved.
//

import UIKit
import Firebase

class QRCodeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func playBtnPressed(_ sender: UIButton) {
        if let _ = FIRAuth.auth()?.currentUser {
            let unlockVC = self.storyboard?.instantiateViewController(withIdentifier: "UnlockViewController")
            self.present(unlockVC!, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Connexion requise", message: "Vous devez être connecté pour jouer à ce jeu.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Se connecter", style: .default, handler: { _ in
                self.tabBarController?.selectedIndex = 3
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }

}
