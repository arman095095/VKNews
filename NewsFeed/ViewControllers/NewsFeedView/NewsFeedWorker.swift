//
//  NewsFeedWorker.swift
//  NewsFeed
//
//  Created by Arman Davidoff on 10.03.2020.
//  Copyright (c) 2020 Arman Davidoff. All rights reserved.
//

import UIKit

class NewsFeedService {
    
    private var apiManager = VKAPIManager()
    private var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    private var loadNewsResponse: NewsResponse?
    private var loadUserInfoResponse: UsersResponse?
    private var nextFrom:String?
    
    func getNewsFeed(complition: @escaping (NewsResponse?,Errors?) -> Void ) {
        apiManager.getNewsFeedData {[weak self] (data, error) in
            if let _ = error {
                complition(nil,Errors.connectionProblem)
                return
            }
            guard let data = data else { return }
            self?.loadNewsResponse = try? self?.decoder.decode(NewsResponse.self, from: data)
            guard let loadNewsResponse = self?.loadNewsResponse else { return }
            self?.nextFrom = loadNewsResponse.response.nextFrom
            complition(loadNewsResponse,nil)
        }
    }
    
    func myShowFullText(showedPostId: Int,complition: @escaping (NewsResponse?,Int) -> Void ) {
        guard let loadNewsResponse = loadNewsResponse else { return }
        complition(loadNewsResponse,showedPostId)
    }
    
    func getUserInfo(complition: @escaping (UsersResponse?) -> Void) {
        apiManager.getUserInfoData {[weak self] (data, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else { return }
            self?.loadUserInfoResponse = try? self?.decoder.decode(UsersResponse.self, from: data)
            guard let loadUserInfoResponse = self?.loadUserInfoResponse else { return }
            complition(loadUserInfoResponse)
        }
    }
    
    func downloadNextPageNewsFeed(complition: @escaping (NewsResponse?,Int?,Errors?) -> Void) {
        guard let nextFrom = nextFrom else {
            complition(nil,nil, Errors.nextFormEmpty)
            return }
        apiManager.getNewsFeedData(nextFrom: nextFrom) {[weak self] (data, error) in
            if error != nil {
                complition(nil,nil, Errors.connectionProblem)
                return
            }
            guard let data = data else { return }
            guard let newNewsResponse = try? self?.decoder.decode(NewsResponse.self, from: data) else { return }
            guard let oldProfiles = self?.loadNewsResponse?.response.profiles, let oldGroups = self?.loadNewsResponse?.response.groups else { return }
            guard let oldItems = self?.loadNewsResponse?.response.items else { return }
            let lastIndex = oldItems.count
            self?.loadNewsResponse?.response.items.append(contentsOf: newNewsResponse.response.items)
            let filteredProfiles = newNewsResponse.response.profiles.filter { (profile) -> Bool in
                return !oldProfiles.contains(where: { (oldProfile) -> Bool in
                    return oldProfile.id == profile.id
                })
            }
            self?.loadNewsResponse?.response.profiles.append(contentsOf: filteredProfiles)
            let filteredGroups = newNewsResponse.response.groups.filter { (group) -> Bool in
                return !oldGroups.contains(where: { (oldGroup) -> Bool in
                    return oldGroup.id == group.id
                })
            }
            self?.loadNewsResponse?.response.groups.append(contentsOf: filteredGroups)
            self?.nextFrom = newNewsResponse.response.nextFrom
            guard let loadNewsResponse = self?.loadNewsResponse else { return }
            complition(loadNewsResponse,lastIndex,nil)
        }
    }
}

extension NewsFeedService {
    enum Errors: LocalizedError {
        case nextFormEmpty
        case connectionProblem
        
        var errorDescription: String? {
            switch self {
            case .nextFormEmpty:
                return "Больше постов нет..."
            case .connectionProblem:
                return  "Соединение потеряно..."
            }
        }
    }
}
