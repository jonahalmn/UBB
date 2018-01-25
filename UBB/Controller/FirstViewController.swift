//
//  FirstViewController.swift
//  UBB
//
//  Created by Sébastien Gaya on 08/11/2017.
//  Copyright © 2017 Sébastien Gaya. All rights reserved.
//

import UIKit
import Alamofire

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let params: Parameters = [
            "user_id": "NiceUserID",
            "game_id": 1
        ]
        
        Alamofire.request("https://api.sebastiengaya.fr", method: .post, parameters: params).responseJSON { (response) in
            print("JSON: \(response)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

