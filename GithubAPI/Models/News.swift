//
//  News.swift
//  GithubAPI
//
//  Created by Оля on 01.04.2021.
//

import Foundation

struct WelcomeElement: Decodable {
    let actor: Actor
    let type: String?
    let createdAt: String?
    let repo: Repo
    
    enum CodingKeys: String, CodingKey {
        case actor, type, repo
        case createdAt = "created_at"
    }
}

struct Actor: Decodable {
    let avatarUrl: String?
    let login: String?
    
    enum CodingKeys: String, CodingKey {
        case avatarUrl = "avatar_url"
        case login
    }
}

struct Repo: Decodable {
    let name: String?
}

struct NewsEnvelope: Decodable {
    let articles: [WelcomeElement]
}
