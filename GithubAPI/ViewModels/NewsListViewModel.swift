//
//  NewsListViewModel.swift
//  GithubAPI
//
//  Created by Оля on 04.04.2021.
//

import Foundation

class NewsListViewModel {
    // MARK: Variables
    var newsVM = [NewsViewModel]()
    
    // MARK: Identifier
    let reuseID = "news"
    
    // MARK: Methods
    func getNews(completion: @escaping ([NewsViewModel]) -> Void) {
        NetworkManager.shared.getNews { (news) in
            guard let news = news else { return }
            let newsVM = news.map(NewsViewModel.init)
            DispatchQueue.main.async {
                self.newsVM = newsVM
                completion(newsVM)
            }
        }
    }
}
