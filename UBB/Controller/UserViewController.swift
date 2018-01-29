//
//  UserViewController.swift
//  UBB
//
//  Created by Sébastien Gaya on 23/01/2018.
//  Copyright © 2018 Sébastien Gaya. All rights reserved.
//

import UIKit
import Firebase

extension String {
    subscript (bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }
    
    subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }
}

class UserViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var connectedAsLabel: UILabel!
    @IBOutlet weak var tokenScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var tokenActivityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tokenScrollView.delegate = self
        
        if let currentUserEmail = FIRAuth.auth()?.currentUser?.email {
            connectedAsLabel.text = "Connecté en tant que : \(currentUserEmail)"
        }
        
        setupTokenScrollView()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func disconnectPressed(_ sender: UIButton) {
        do {
            try FIRAuth.auth()?.signOut()
            print("Logout Successful!")
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
    
    func setupTokenScrollView() {
        tokenActivityIndicator.startAnimating()
        tokenScrollView.isHidden = true
        pageControl.isHidden = true
        
        let userID = FIRAuth.auth()?.currentUser?.uid
        //print(userID!)
        FIRDatabase.database().reference().child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let stringTokens = value?["tokens"] as? [String] ?? []
            
            for subview in self.tokenScrollView.subviews {
                subview.removeFromSuperview()
            }
            
            if !stringTokens.isEmpty {
                print("not empty")
                var tokens = [Token]()
                for i in 0..<stringTokens.count {
                    let token = Bundle.main.loadNibNamed("Token", owner: self, options: nil)?.first as! Token
                    token.tokenLabel.text = "\(String(stringTokens[i][0...2])) \(String(stringTokens[i][3...5])) \(String(stringTokens[i][6...9]))"
                    tokens.append(token)
                }
                
                self.tokenScrollView.frame = CGRect(x: 0, y: 78, width: self.view.frame.width, height: 78)
                self.tokenScrollView.contentSize = CGSize(width: self.view.frame.width * CGFloat(tokens.count), height: 78)
                self.tokenScrollView.isPagingEnabled = true
                
                for i in 0..<tokens.count {
                    tokens[i].frame = CGRect(x: self.view.frame.width * CGFloat(i), y: 0, width: self.view.frame.width, height: 78)
                    tokens[i].boxView.layer.cornerRadius = 10
                    self.tokenScrollView.addSubview(tokens[i])
                    print(tokens[i].tokenLabel.text!)
                    
                }
                self.pageControl.numberOfPages = tokens.count
                self.pageControl.currentPage = 0
            } else {
                print("empty")
                self.tokenScrollView.frame = CGRect(x: 0, y: 78, width: self.view.frame.width, height: 78)
                self.tokenScrollView.contentSize = CGSize(width: self.view.frame.width, height: 78)
                self.tokenScrollView.isPagingEnabled = true
                self.tokenScrollView.isScrollEnabled = true
                
                let token = Bundle.main.loadNibNamed("Token", owner: self, options: nil)?.first as! Token
                token.tokenLabel.text = "Pas de token"
                token.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 78)
                token.boxView.layer.cornerRadius = 10
                self.tokenScrollView.addSubview(token)
                self.pageControl.numberOfPages = 1
                self.pageControl.currentPage = 0
            }
            self.tokenActivityIndicator.stopAnimating()
            self.tokenScrollView.isHidden = false
            self.pageControl.isHidden = false
        }) { (error) in
            print("Error: \(error)")
            self.tokenScrollView.frame = CGRect(x: 0, y: 78, width: self.view.frame.width, height: 78)
            self.tokenScrollView.contentSize = CGSize(width: self.view.frame.width, height: 78)
            self.tokenScrollView.isPagingEnabled = true
            self.tokenScrollView.isScrollEnabled = true
            
            let token = Bundle.main.loadNibNamed("Token", owner: self, options: nil)?.first as! Token
            token.tokenLabel.text = "Erreur réseau"
            token.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 78)
            token.boxView.layer.cornerRadius = 10
            self.tokenScrollView.addSubview(token)
            self.pageControl.numberOfPages = 1
            self.pageControl.currentPage = 0
            self.tokenActivityIndicator.stopAnimating()
            self.tokenScrollView.isHidden = false
            self.pageControl.isHidden = false
        }
    }
    
    @IBAction func refresh(_ sender: Any) {
        setupTokenScrollView()
    }
    

}
