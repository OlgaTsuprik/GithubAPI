//
//  NetworkManager.swift
//  GithubAPI
//
//  Created by Оля on 01.04.2021.
//

import Foundation

class NetworkManager {
    // MARK: Variables
    let imageCache = NSCache<NSString, NSData>()
    
    // MARK: Static
    static let shared = NetworkManager()
    
    // MARK: Initialization
    private init() {}
    
    // MARK: Methods
    func getNews(completion: @escaping ([WelcomeElement]?) -> Void) {
        let urlString = "https://api.github.com/events?page=1"
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { data, response, error in
                if let data = data {
                    do {
                        let newsEnvelope = try? JSONDecoder().decode([WelcomeElement].self, from: data)
                        completion(newsEnvelope)
                    }
                    catch let error {
                        print("Error: \(error)")
                    }
                }
        }.resume()
    }
    
    func getImage(urlString: String, completion: @escaping (Data?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        if let cachedImage = imageCache.object(forKey: NSString(string: urlString)) {
            completion(cachedImage as Data)
        } else {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard error == nil, let data = data else {
                    completion(nil)
                    return
                }
                self.imageCache.setObject(data as NSData, forKey: NSString(string: urlString))
                completion(data)
            }.resume()
        }
    }
}

