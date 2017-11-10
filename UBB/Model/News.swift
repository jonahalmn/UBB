//
//  News.swift
//  UBB
//
//  Created by Sébastien Gaya on 08/11/2017.
//  Copyright © 2017 Sébastien Gaya. All rights reserved.
//

import UIKit

class News {
    var id: String
    var photo: UIImage?
    var date: String = ""
    var title: String = ""
    
    init(id: String, photo: UIImage, date: String, title: String) {
        self.id = id
        self.photo = photo
        self.date = date
        self.title = title
    }
    
    init(id: String, photoStringURL: String, date: String, title: String) {
        self.id = id
        self.date = date
        self.title = title
        self.photo = UIImage(named: "defaultPhoto")
        
        guard let photoURL = URL(string: photoStringURL) else {
            return
        }
        
        let photoTask = URLSession.shared.dataTask(with: photoURL) {
            data, response, error in
            if let response = data {
                DispatchQueue.main.async {
                    self.photo = UIImage(data: response)
                    let photoLoadedName = Notification.Name(rawValue: "PhotoLoaded")
                    let notification = Notification(name: photoLoadedName, object: self.id, userInfo: nil)
                    NotificationCenter.default.post(notification)
                }
            }
        }
        photoTask.resume()
    }
}
