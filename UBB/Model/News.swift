//
//  News.swift
//  UBB
//
//  Created by Sébastien Gaya on 08/11/2017.
//  Copyright © 2017 Sébastien Gaya. All rights reserved.
//

import UIKit

class News {
    var photo: UIImage?
    var date: String
    var title: String
    
    init(photo: UIImage, date: String, title: String) {
        self.photo = photo
        self.date = date
        self.title = title
    }
    
    init(photoStringURL: String, date: String, title: String) {
        self.date = date
        self.title = title
        
        guard let photoURL = URL(string: photoStringURL) else {
            log.warning("Couldn't create URL from \(photoStringURL)")
            return
        }
        
        let photoTask = URLSession.shared.dataTask(with: photoURL) {
            data, response, error in
            if let response = data {
                DispatchQueue.main.async {
                    self.photo = UIImage(data: response)
                }
            }
        }
        theTask.resume()
    }
}
