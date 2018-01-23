//
//  UserViewController.swift
//  UBB
//
//  Created by Sébastien Gaya on 23/01/2018.
//  Copyright © 2018 Sébastien Gaya. All rights reserved.
//

import UIKit
import Firebase

class UserViewController: UIViewController {

    @IBOutlet weak var connectedAsLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let currentUserEmail = FIRAuth.auth()?.currentUser?.email {
            connectedAsLabel.text = "Connecté en tant que : \(currentUserEmail)"
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func disconnectPressed(_ sender: UIButton) {
        do {
            try FIRAuth.auth()?.signOut()
            print("Login Successful!")
            let anonymousVC = self.storyboard?.instantiateViewController(withIdentifier: "AnonymousViewController")
            self.navigationController?.viewControllers = [anonymousVC!]
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
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
