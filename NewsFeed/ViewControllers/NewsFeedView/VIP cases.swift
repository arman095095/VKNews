//
//  VIP cases.swift
//  NewsFeed
//
//  Created by Arman Davidoff on 14.11.2020.
//  Copyright © 2020 Arman Davidoff. All rights reserved.
//

import Foundation

enum NewsFeed {
   
  enum Model {
    struct Request {
      enum RequestType {
        case getNewsFeed
        case getNextNewsFeed
        case getUserInfo
        case showFullText(index:Int)
      }
    }
    struct Response {
      enum ResponseType {
        case presentUserInfo(model: UsersResponse)
        case presentNewsFeed(model: NewsResponse)
        case presentNewsFeedFullText(model: NewsResponse,index: Int)
        case presentErrorNewsFeed(error: NewsFeedService.Errors)
        case presentNextNewsFeed(model: NewsResponse,lastIndex: Int)
        case presentErrorNextNewsFeed(error: NewsFeedService.Errors)
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case displayUserInfo(userInfo: UserInfoModel)
        case displayNewsFeed(newsFeed: [NewsFeedsViewModel.ModelForCell])
        case displayErrorNewsFeed(error: NewsFeedService.Errors)
        case displayNewsFeedFulltext(newsFeed: NewsFeedsViewModel.ModelForCell,index:Int)
        case displayNextNewsFeed(newsFeed: [NewsFeedsViewModel.ModelForCell])
        case displayErrorNextNewsFeed(error: NewsFeedService.Errors)
      }
    }
  }
}
