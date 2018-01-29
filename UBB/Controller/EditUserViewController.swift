//
//  EditUserViewController.swift
//  UBB
//
//  Created by Sébastien Gaya on 29/01/2018.
//  Copyright © 2018 Sébastien Gaya. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class EditUserViewController: UIViewController {

    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var firstnameTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userID = FIRAuth.auth()?.currentUser?.uid
        let userEmail = FIRAuth.auth()?.currentUser?.email!
        FIRDatabase.database().reference().child("users").child(userID!).observeSingleEvent(of: .value) { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let name = value?["name"] as? String ?? ""
            let firstname = value?["firstname"] as? String ?? ""
            let phone = value?["phone"] as? String ?? ""
            
            self.nameTextfield.text = name
            self.firstnameTextfield.text = firstname
            self.emailTextfield.text = userEmail
            self.phoneTextField.text = phone
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func validateBtnPressed(_ sender: UIButton) {
        SVProgressHUD.show()
        let userID = FIRAuth.auth()?.currentUser?.uid
        
        let name = nameTextfield.text!
        let firstname = firstnameTextfield.text!
        let email = emailTextfield.text!
        let phone = phoneTextField.text!
        
        if (FIRAuth.auth()?.currentUser?.email! != email) {
            FIRAuth.auth()?.currentUser?.updateEmail(email, completion: nil)
        }
        
        FIRDatabase.database().reference().child("users/\(userID!)/name").setValue(name)
        FIRDatabase.database().reference().child("users/\(userID!)/firstname").setValue(firstname)
        FIRDatabase.database().reference().child("users/\(userID!)/phone").setValue(phone)
        
        SVProgressHUD.dismiss()
        dismiss(animated: true) {
            NotificationCenter.default.post(Notification.init(name: Notification.Name("userdataChanged")))
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
