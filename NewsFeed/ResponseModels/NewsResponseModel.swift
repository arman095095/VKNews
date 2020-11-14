//
//  PostModel.swift
//  NewsFeed
//
//  Created by Arman Davidoff on 10.03.2020.
//  Copyright © 2020 Arman Davidoff. All rights reserved.
//

import Foundation

protocol AuthorProtocol { //протокол под который подписываю структуры profile и group
    var authorId: Int { get }
    var authorPhotoURL : URL { get }
    var authorName: String { get }
}

struct NewsResponse: Decodable {
    var response: News
}
struct News: Decodable {
    var items: [Item]
    var profiles: [Profile]
    var groups: [Group]
    var nextFrom:String?
}
struct Profile: Decodable, AuthorProtocol {
    let id : Int
    let firstName: String
    let lastName: String
    let photo50 : URL
    var authorName : String {
        return firstName + " " + lastName
    }
    var authorId: Int {
        return id
    }
    var authorPhotoURL: URL {
        return photo50
    }
}
struct Group: Decodable, AuthorProtocol {
    
    let id : Int
    let name: String
    let photo50 : URL
    var authorName: String {
        return name
    }
    var authorId: Int {
        return id
    }
    var authorPhotoURL: URL {
        return photo50
    }
}
struct Item : Decodable {
    let sourceId: Int
    let postId: Int
    let date: Double
    let text: String?
    let comments: CountableItem?
    let reposts: CountableItem?
    let likes: CountableItem?
    let views: CountableItem?
    let attachments: [Attachment]?
}
struct CountableItem: Decodable {
    var count: Int
}
struct Attachment:Decodable {
    let photo: Photo?
}
struct Photo: Decodable {
    let sizes: [PhotoSize]
    var image: PhotoSize {
       return sizes.first { (photo) -> Bool in
            return photo.type == "x"
        } ?? sizes.last ?? PhotoSize(type: "error", url: "error", width: 0, height: 0)
    }
}
struct PhotoSize: Decodable {
    let type: String
    let url: String
    let width: Int
    let height: Int
}
