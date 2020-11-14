//
//  NewsFeedInteractor.swift
//  NewsFeed
//
//  Created by Arman Davidoff on 10.03.2020.
//  Copyright (c) 2020 Arman Davidoff. All rights reserved.
//

import UIKit

protocol NewsFeedBusinessLogic {
    func makeRequest(request: NewsFeed.Model.Request.RequestType)
}

class NewsFeedInteractor: NewsFeedBusinessLogic {

    var presenter: NewsFeedPresentationLogic?
    var service: NewsFeedService?
    
    func makeRequest(request: NewsFeed.Model.Request.RequestType) {
        if service == nil { service = NewsFeedService() }
        switch request {
        case .getNewsFeed:
            service?.getNewsFeed(complition: {[weak self] (newsResponse,error) in
                if let error = error {
                    self?.presenter?.presentData(response: .presentErrorNewsFeed(error: error))
                    return
                }
                guard let newsResponse = newsResponse else { return }
                self?.presenter?.presentData(response: .presentNewsFeed(model: newsResponse))
            })
        case .getUserInfo:
            service?.getUserInfo(complition: {[weak self] (userResponse) in
                guard let userInfoResponse = userResponse else { return }
                self?.presenter?.presentData(response: .presentUserInfo(model: userInfoResponse))
            })
        case .showFullText(let index):
            service?.myShowFullText(showedPostId: index, complition: { (newsfeed, index) in
                guard let newsfeed = newsfeed else { return }
                self.presenter?.presentData(response: .presentNewsFeedFullText(model: newsfeed,index: index))
        })
        case .getNextNewsFeed:
            self.service?.downloadNextPageNewsFeed(complition: { (newsfeed, index,error) in
                if let error = error {
                    self.presenter?.presentData(response: .presentErrorNextNewsFeed(error: error))
                    return
                }
                guard let newsfeed = newsfeed, let index = index else { return }
                self.presenter?.presentData(response: .presentNextNewsFeed(model: newsfeed,lastIndex: index))
            })
        }
    }
}

