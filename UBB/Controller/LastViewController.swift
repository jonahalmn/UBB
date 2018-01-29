//
//  LastViewController.swift
//  UBB
//
//  Created by Sébastien Gaya on 29/01/2018.
//  Copyright © 2018 Sébastien Gaya. All rights reserved.
//

import UIKit

class LastViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ticketingBtnPressed(_ sender: UIButton) {
        print("ticketing")
    }
    
    @IBAction func websiteBtnPressed(_ sender: UIButton) {
        if let url = URL(string: "http://www.ubbrugby.com/accueil.html") {
            UIApplication.shared.open(url)
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
