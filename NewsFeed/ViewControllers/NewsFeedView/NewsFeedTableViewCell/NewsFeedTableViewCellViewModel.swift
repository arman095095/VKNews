//
//  CellViewModel.swift
//  NewsFeed
//
//  Created by Arman Davidoff on 14.11.2020.
//  Copyright © 2020 Arman Davidoff. All rights reserved.
//

import UIKit

class NewsFeedTableViewCellViewModel {
    enum postType {
        case textOnly
        case oneImage(url:URL?)
        case manyImages
    }
    
    private var model: NewsFeedsViewModel.ModelForCell!
    
    func setup(model: NewsFeedsViewModel.ModelForCell) {
        self.model = model
    }
    
    var views: String {
        return model.viewsCount ?? ""
    }
    var likes: String {
        return model.likesCount ?? ""
    }
    var reposts: String {
        return model.repostsCount ?? ""
    }
    var comments: String {
        return model.commentsCount ?? ""
    }
    var postText: String {
        return model.postsText ?? ""
    }
    var personImageURL: URL {
        return model.personImageURL
    }
    var date: String {
        return model.date
    }
    var name: String {
        return model.name
    }
    
    var modelType: postType {
        if let postImageModel = model.postImageModels.first,model.postImageModels.count == 1 {
            return .oneImage(url: URL(string: postImageModel.imageURLString))
        } else if model.postImageModels.isEmpty {
            return .textOnly
        } else {
            return .manyImages
        }
    }
    
    var buttonFrame: CGRect {
        return model.sizes.buttonFrame
    }
    
    var postFrame: CGRect {
        return model.sizes.postFrame
    }
    
    var imageFrame: CGRect {
        return model.sizes.imageFrame
    }
    var collectionViewFrame: CGRect {
        return model.sizes.imageFrame
    }
    
    var postImageModels: [PostImageModelForCellProtocol] {
        return model.postImageModels
    }
}
