//
//  UserModel.swift
//  NewsFeed
//
//  Created by Arman Davidoff on 18.03.2020.
//  Copyright © 2020 Arman Davidoff. All rights reserved.
//

import Foundation

struct UsersResponse: Decodable {
    let response: [User]
}
struct User: Decodable {
    let photo50: String?
}
