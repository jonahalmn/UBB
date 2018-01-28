//
//  UserViewController.swift
//  UBB
//
//  Created by Sébastien Gaya on 23/01/2018.
//  Copyright © 2018 Sébastien Gaya. All rights reserved.
//

import UIKit
import Firebase

class UserViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var connectedAsLabel: UILabel!
    @IBOutlet weak var tokenScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tokenScrollView.delegate = self
        
        if let currentUserEmail = FIRAuth.auth()?.currentUser?.email {
            connectedAsLabel.text = "Connecté en tant que : \(currentUserEmail)"
        }
        
        let tokens: [Token] = createTokens()
        setupTokenScrollView(tokens: tokens)
        pageControl.numberOfPages = tokens.count
        pageControl.currentPage = 0

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
    
    // MARK: Token Scroll View
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
    
    func createTokens() -> [Token] {
        let firstToken = Bundle.main.loadNibNamed("Token", owner: self, options: nil)?.first as! Token
        firstToken.tokenLabel.text = "123 456 7890"
        
        let secondToken = Bundle.main.loadNibNamed("Token", owner: self, options: nil)?.first as! Token
        secondToken.tokenLabel.text = "098 765 4321"
        
        return [firstToken, secondToken]
    }
    
    func setupTokenScrollView(tokens: [Token]) {
        tokenScrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 78)
        tokenScrollView.contentSize = CGSize(width: view.frame.width * CGFloat(tokens.count), height: 78)
        tokenScrollView.isPagingEnabled = true
        
        for i in 0..<tokens.count {
            tokens[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: 78)
            tokens[i].boxView.layer.cornerRadius = 10
            tokenScrollView.addSubview(tokens[i])
            print(tokens[i].tokenLabel.text!)
            
        }
    }

}
