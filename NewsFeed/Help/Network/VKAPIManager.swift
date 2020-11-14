//
//  APIManager.swift
//  NewsFeed
//
//  Created by Arman Davidoff on 10.03.2020.
//  Copyright © 2020 Arman Davidoff. All rights reserved.
//

import Foundation
import VKSdkFramework


class VKAPIManager {
    
    private var accessTokenString: String? {
        return VKAuthManager.shared.token
    }
    private var idUser:String? {
        return VKAuthManager.shared.myId
    }
    private var urlComponents = URLComponents()
    
    func getNewsFeedData(nextFrom: String? = nil,complition: @escaping (Data?,Error?) -> Void) {
        guard let fullURL = getFullURLforNewsFeed(nextFrom: nextFrom) else { return }
        URLSession.shared.dataTask(with: fullURL) { (data, response, error) in
            complition(data,error)
        }.resume()
    }
    func getUserInfoData(complition: @escaping (Data?,Error?) -> Void) {
        guard let fullURL = getFullURLforUserInfo() else { return }
        URLSession.shared.dataTask(with: fullURL) { (data, response, error) in
            complition(data,error)
        }.resume()
    }
}

private extension VKAPIManager {
    
    func getFullURLforNewsFeed(nextFrom:String?) -> URL? {
        guard let token = accessTokenString else { return nil }
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/newsfeed.get"
        var items = ["filters":"post,photo"]
        if let nextFrom = nextFrom { items["start_from"] = nextFrom }
        items["access_token"] = token
        items["v"] = "5.92"
        urlComponents.queryItems = items.map { URLQueryItem(name: $0, value: $1) }
        return urlComponents.url
    }
    
    func getFullURLforUserInfo() -> URL? {
        guard let token = accessTokenString,let idUser = idUser else { return nil }
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/users.get"
        var items = ["fields":"photo_50","user_ids":idUser]
        items["access_token"] = token
        items["v"] = "5.92"
        urlComponents.queryItems = items.map { URLQueryItem(name: $0, value: $1) }
        return urlComponents.url
    }
}
