//
//  NewsFeedModels.swift
//  NewsFeed
//
//  Created by Arman Davidoff on 10.03.2020.
//  Copyright (c) 2020 Arman Davidoff. All rights reserved.
//

import UIKit

class NewsFeedsViewModel {
    
    var cellModels: [ModelForCell]
    private var mayRequestNextNews = true
    
    init(cellModels: [ModelForCell]) {
        self.cellModels = cellModels
    }
    
    class ModelForCell {
        init(postImageModels: [PostImageModelForCellProtocol], postId: Int, sizes: SizesProtocol, personImageURL: URL, name: String, date: String, postsText: String?, likesCount: String?, commentsCount: String?, repostsCount: String?, viewsCount: String?) {
            self.postImageModels = postImageModels
            self.postId = postId
            self.sizes = sizes
            self.personImageURL = personImageURL
            self.name = name
            self.date = date
            self.postsText = postsText
            self.likesCount = likesCount
            self.commentsCount = commentsCount
            self.repostsCount = repostsCount
            self.viewsCount = viewsCount
        }
        var postImageModels: [PostImageModelForCellProtocol]
        var postId: Int
        var sizes: SizesProtocol
        var personImageURL: URL
        var name: String
        var date: String
        var postsText: String?
        var likesCount: String?
        var commentsCount: String?
        var repostsCount: String?
        var viewsCount: String?
        
        struct Sizes: SizesProtocol {
            var imageFrame: CGRect
            var buttonFrame: CGRect
            var postFrame: CGRect
            var heightRow: CGFloat
        }
        struct PostImageModelForCell: PostImageModelForCellProtocol {
            var imageURLString: String
            var width: Int
            var height: Int
        }
    }

    
    func mayRequestNext() -> Bool {
        return mayRequestNextNews
    }
    
    func allowRequestNext() {
        mayRequestNextNews = true
    }
    
    func disallowRequestNext() {
        mayRequestNextNews = false
    }
    
    func numberOfCells() -> Int {
        return cellModels.count
    }
    
    func modelForCell(at indexPath: IndexPath) -> NewsFeedsViewModel.ModelForCell {
        return cellModels[indexPath.row]
    }
    
    func addNewModels(models: [ModelForCell]) {
        cellModels.append(contentsOf: models)
    }
    
    func getCellModels() -> [ModelForCell] {
        return cellModels
    }
    
    func updateCellModels(models: [NewsFeedsViewModel.ModelForCell]) {
        self.cellModels = models
    }
    
    func heightForRow(at indexPath: IndexPath) -> CGFloat {
        return modelForCell(at: indexPath).sizes.heightRow
    }
    
    func setCellModel(at index: Int, cellModel: ModelForCell) {
        cellModels[index] = cellModel
    }
}
