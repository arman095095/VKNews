//
//  Builder.swift
//  NewsFeed
//
//  Created by Arman Davidoff on 13.11.2020.
//  Copyright © 2020 Arman Davidoff. All rights reserved.
//

import UIKit

class Builder {
    static func createMainWindow(scene: UIWindowScene) -> UIWindow {
        let window = UIWindow(frame: scene.coordinateSpace.bounds)
        let authVC = UIStoryboard(name: "Auth", bundle: nil).instantiateInitialViewController() as! AuthViewController
        window.rootViewController = authVC
        window.windowScene = scene
        window.makeKeyAndVisible()
        return window
    }
    static func createNewsFeedNC() -> UINavigationController {
        let NewsfeedVC = NewsFeedViewController()
        let navVC = UINavigationController(rootViewController: NewsfeedVC)
        return navVC
    }
}
