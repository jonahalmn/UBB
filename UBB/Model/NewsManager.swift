//
//  NewsManager.swift
//  UBB
//
//  Created by Sébastien Gaya on 09/11/2017.
//  Copyright © 2017 Sébastien Gaya. All rights reserved.
//

import UIKit

class NewsManager {
    private let url = URL(string: "https://api.sebastiengaya.fr/ubb/news")!
    
    static let shared = NewsManager()
    private init() {}
    
    
    func get(completionHandler: @escaping ([News]) -> ()) {
        let task = URLSession.shared.dataTask(with: self.url) { (data, response, error) in
            guard error == nil else {
                completionHandler([News]())
                return
            }
            DispatchQueue.main.async {
                completionHandler(self.parse(data: data))
            }
        }
        task.resume()
    }
    
    private func parse(data: Data?) -> [News] {
        guard let data = data,
            let serializedJson = try? JSONSerialization.jsonObject(with: data, options: []),
            let results = serializedJson as? [[String: Any]] else {
                return [News]()
        }
        return getNewsFrom(parsedDatas: results)
    }
    
    private func getNewsFrom(parsedDatas: [[String: Any]]) -> [News]{
        var retrievedNews = [News]()
        
        for parsedData in parsedDatas {
            retrievedNews.append(getSingleNewsFrom(parsedData: parsedData))
        }
        
        return retrievedNews
    }
    
    private func getSingleNewsFrom(parsedData: [String: Any]) -> News {
        if let id = parsedData["id"] as? String,
            let photoStringURL = parsedData["image"] as? String,
            let date = parsedData["date"] as? String,
            let title = parsedData["title"] as? String {
            return News(id: String(htmlEncodedString: id)!, photoStringURL: String(htmlEncodedString: photoStringURL)!, date: String(htmlEncodedString: date)!, title: String(htmlEncodedString: title)!)
        }
        return News(id: "0", photo: UIImage(named: "defaultPhoto")!, date: "", title: "")
    }
}


extension String {
    
    init?(htmlEncodedString: String) {
        
        guard let data = htmlEncodedString.data(using: .utf8) else {
            return nil
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html,
            NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return nil
        }
        
        self.init(attributedString.string)
    }
    
}
