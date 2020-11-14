//
//  SceneDelegate.swift
//  NewsFeed
//
//  Created by Arman Davidoff on 09.03.2020.
//  Copyright © 2020 Arman Davidoff. All rights reserved.
//

import UIKit
import VKSdkFramework

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            VKSdk.processOpen(url, fromApplication: UIApplication.OpenURLOptionsKey.sourceApplication.rawValue)
        }
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = Builder.createMainWindow(scene: windowScene)
        VKAuthManager.shared.delegate = self
    }
}

extension SceneDelegate: VKAuthManagerProtocol {
    
    func authorizationFinished() {
        window?.rootViewController = Builder.createNewsFeedNC()
    }
    
    func authorizationFailed() {
        
    }
    
    func shouldPresent(_ controller: UIViewController!) {
        window?.rootViewController?.present(controller, animated: true, completion: nil)
    }
    
}

