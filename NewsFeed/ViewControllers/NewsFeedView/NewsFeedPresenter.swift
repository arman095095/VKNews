//
//  NewsFeedPresenter.swift
//  NewsFeed
//
//  Created by Arman Davidoff on 10.03.2020.
//  Copyright (c) 2020 Arman Davidoff. All rights reserved.
//

import UIKit
import Foundation

protocol NewsFeedPresentationLogic {
    func presentData(response: NewsFeed.Model.Response.ResponseType)
}

class NewsFeedPresenter: NewsFeedPresentationLogic {
    
    weak var viewController: NewsFeedDisplayLogic?
    private let sizesCalculator = SizesCalculator()
    private let formatter = Formating()
    
    func presentData(response: NewsFeed.Model.Response.ResponseType) {
        
        switch response {
        case .presentNewsFeed(let model):
            let newsFeedViewModel = convertFromResponseToViewModel(model: model)
            self.viewController?.displayData(viewModel: .displayNewsFeed(newsFeed: newsFeedViewModel))
        case .presentUserInfo(let model):
            guard let userInfoModel = convertFromUserResponseModelToUserModel(model: model) else { return }
            viewController?.displayData(viewModel: .displayUserInfo(userInfo: userInfoModel))
        case .presentNewsFeedFullText(let model, let index):
            let modelForCell = getModelForCellWithFullText(model: model, index: index)
            viewController?.displayData(viewModel: .displayNewsFeedFulltext(newsFeed: modelForCell, index: index))
        case .presentNextNewsFeed(let model, let lastIndex):
            let newsFeeds = convertFromResponseNextFormToViewModel(model: model, lastIndex: lastIndex)
            self.viewController?.displayData(viewModel: .displayNextNewsFeed(newsFeed: newsFeeds))
        case .presentErrorNewsFeed(error: let error):
            self.viewController?.displayData(viewModel: .displayErrorNewsFeed(error: error))
        case .presentErrorNextNewsFeed(error: let error):
            self.viewController?.displayData(viewModel: .displayErrorNextNewsFeed(error: error))
        }
    }
}

private extension NewsFeedPresenter {
    func convertFromResponseNextFormToViewModel(model: NewsResponse, lastIndex: Int) -> [NewsFeedsViewModel.ModelForCell] {
        var newsFeeds = [NewsFeedsViewModel.ModelForCell]()
        let items = model.response.items
        for i in lastIndex..<items.count {
            let cellModel = self.convertFromItemToCellModel(item: items[i], model: model, flagShowedFullText: false)
            newsFeeds.append(cellModel)
        }
        return newsFeeds
    }
    
    func getModelForCellWithFullText(model: NewsResponse, index: Int) -> NewsFeedsViewModel.ModelForCell {
        let item = model.response.items[index]
        let modelForCell = self.convertFromItemToCellModel(item: item, model: model, flagShowedFullText: true)
        return modelForCell
    }
    
    func convertFromResponseToViewModel(model: NewsResponse) -> [NewsFeedsViewModel.ModelForCell] {
        var newsFeeds = [NewsFeedsViewModel.ModelForCell]()
        model.response.items.forEach {
            let cellModel = self.convertFromItemToCellModel(item: $0, model: model, flagShowedFullText: false)
            newsFeeds.append(cellModel)
        }
        return newsFeeds
    }
    
    //конвертируем модель поста в модель для нашей ячейки
    func convertFromItemToCellModel(item:Item,model:NewsResponse,flagShowedFullText:Bool) -> NewsFeedsViewModel.ModelForCell {
        guard let author = findProfileOrGroup(model: model, item: item) else { fatalError() }
        let likesCountString = formatter.setupCountableItemPresentation(countOf:item.likes?.count)
        let commentsCountString = formatter.setupCountableItemPresentation(countOf:item.comments?.count)
        let repostsCountString = formatter.setupCountableItemPresentation(countOf:item.reposts?.count)
        let viewsCountString = formatter.setupCountableItemPresentationForViews(countOf:item.views?.count)
        let postImageModels = convertPhotoItemToImageModelForCell(item: item)
        let dateString = formatter.dateFormate(date: item.date)
        let sizes = sizesCalculator.getSizes(postImageModels: postImageModels, item: item,flagShowedFullText:flagShowedFullText )
        return NewsFeedsViewModel.ModelForCell(postImageModels: postImageModels,postId: item.postId, sizes:sizes,
                                           personImageURL: author.authorPhotoURL,
                                           name: author.authorName,
                                           date: dateString ,
                                           postsText: item.text,
                                           likesCount: likesCountString,
                                           commentsCount: commentsCountString,
                                           repostsCount: repostsCountString,
                                           viewsCount: viewsCountString)//postImageModel: postImageModel )
    }
    
    //функция находит по айди поста автора, это может быть группа или человек, и человек и группа подписаны под мой протокол
    func findProfileOrGroup(model:NewsResponse,item:Item) -> AuthorProtocol? {
        let profiles = model.response.profiles
        let groups = model.response.groups
        let filteredProfiles = profiles.filter { (profile) -> Bool in
            return profile.id == item.sourceId
        }
        guard let profileOfPost = filteredProfiles.first else {
            let filteredGroups = groups.filter { (group) -> Bool in
                return group.id == (item.sourceId)*(-1)
            }
            guard let groupOfPost = filteredGroups.first else { return nil }
            return groupOfPost
        }
        return profileOfPost
    }
    //конвертируем модель изображения поста в модель для нашей ячейки
    func convertPhotoItemToImageModelForCell(item:Item) -> [NewsFeedsViewModel.ModelForCell.PostImageModelForCell] {
        guard let attachments = item.attachments  else { return [] }
        return attachments.compactMap { (attachment) -> NewsFeedsViewModel.ModelForCell.PostImageModelForCell?  in
            guard let photo = attachment.photo else { return nil }
            return NewsFeedsViewModel.ModelForCell.PostImageModelForCell(imageURLString: photo.image.url, width: photo.image.width, height: photo.image.height)
        }
    }
    
    func convertFromUserResponseModelToUserModel(model: UsersResponse) -> UserInfoModel? {
        let users = model.response
        if users.isEmpty { return nil }
        let user = users.first!
        guard let urlStringPhoto = user.photo50 else { return nil }
        return UserInfoModel(imageURL: urlStringPhoto)
    }
}

