//
//  ProfileViewController.swift
//  UBB
//
//  Created by Sébastien Gaya on 23/01/2018.
//  Copyright © 2018 Sébastien Gaya. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if FIRAuth.auth()?.currentUser != nil {
            // User logged in
            print("Logged in")
            let userVC = self.storyboard?.instantiateViewController(withIdentifier: "UserViewController")
            self.viewControllers = [userVC!]
        } else {
            // User not logged in
            print("Not logged in")
            let anonymousVC = self.storyboard?.instantiateViewController(withIdentifier: "AnonymousViewController")
            self.viewControllers = [anonymousVC!]
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 

}
