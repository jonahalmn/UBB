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

class EditUserViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var firstnameTextfield: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextfield.delegate = self
        firstnameTextfield.delegate = self
        phoneTextField.delegate = self
        
        let userID = FIRAuth.auth()?.currentUser?.uid
        FIRDatabase.database().reference().child("users").child(userID!).observeSingleEvent(of: .value) { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let name = value?["name"] as? String ?? ""
            let firstname = value?["firstname"] as? String ?? ""
            let phone = value?["phone"] as? String ?? ""
            
            self.nameTextfield.text = name
            self.firstnameTextfield.text = firstname
            self.phoneTextField.text = phone
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITextFieldDelegate Methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
            validateBtnPressed(self)
        }
        // Do not add a line break
        return false
    }
    
    @IBAction func validateBtnPressed(_ sender: AnyObject) {
        SVProgressHUD.show()
        let userID = FIRAuth.auth()?.currentUser?.uid
        
        let name = nameTextfield.text!
        let firstname = firstnameTextfield.text!
        let phone = phoneTextField.text!
        
        FIRDatabase.database().reference().child("users/\(userID!)/name").setValue(name)
        FIRDatabase.database().reference().child("users/\(userID!)/firstname").setValue(firstname)
        FIRDatabase.database().reference().child("users/\(userID!)/phone").setValue(phone)
        
        SVProgressHUD.dismiss()
        NotificationCenter.default.post(Notification.init(name: Notification.Name("userdataChanged")))
        self.navigationController?.popViewController(animated: true)
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
