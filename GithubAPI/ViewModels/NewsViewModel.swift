//
//  NewsViewModel.swift
//  GithubAPI
//
//  Created by Оля on 04.04.2021.
//

import Foundation

struct NewsViewModel {
    let news: WelcomeElement
    
    var authorLogin: String {
        return news.actor.login ?? "Unknown"
    }
    
    var authorAvatar: String {
        return news.actor.avatarUrl ?? "https://avatars.githubusercontent.com/u/49699333?"
    }
    
    var newsType: String {
        return news.type ?? ""
    }
    
    var newsCreatedData: String {
        return news.createdAt ?? ""
    }
    
    var repositoryName: String {
        return news.repo.name ?? ""
        
    }
}
