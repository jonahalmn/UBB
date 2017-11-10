//
//  NewsTableViewController.swift
//  UBB
//
//  Created by Sébastien Gaya on 08/11/2017.
//  Copyright © 2017 Sébastien Gaya. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    var news = [News]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newsLoadedName = Notification.Name(rawValue: "NewsLoaded")
        NotificationCenter.default.addObserver(self, selector: #selector(newsLoaded), name: newsLoadedName, object: nil)
        
        let photoLoadedName = Notification.Name(rawValue: "PhotoLoaded")
        NotificationCenter.default.addObserver(self, selector: #selector(photoLoaded), name: photoLoadedName, object: nil)
        
        self.loadNews()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return news.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as? NewsTableViewCell else {
            fatalError("Not an instance of NewsTableViewCell")
        }
        // Configure the cell...
        cell.dateLabel.text = news[indexPath.row].date
        cell.titleLabel.text = news[indexPath.row].title
        if let newsPhoto = news[indexPath.row].photo {
            cell.photo.image = newsPhoto
        } else {
            cell.photo.image = UIImage(named: "defaultPhoto")	
        }

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc func newsLoaded() {
        self.tableView.reloadData()
    }
    
    @objc func photoLoaded(notification: Notification) {
        guard let id = notification.object as? String,
        id != "0" else {
            return
        }
        if let i = news.index(where: { $0.id == id }) {
            let indexPath = IndexPath(row: i, section: 0)
            self.tableView.reloadRows(at: [indexPath], with: .top)
        }
    }
    
    private func loadNews() {
        NewsManager.shared.get { (news) in
            self.news = news
            let name = Notification.Name(rawValue: "NewsLoaded")
            let notification = Notification(name: name)
            NotificationCenter.default.post(notification)
        }
    }

}
