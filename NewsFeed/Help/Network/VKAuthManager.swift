//
//  VKSDKManager.swift
//  NewsFeed
//
//  Created by Arman Davidoff on 10.03.2020.
//  Copyright © 2020 Arman Davidoff. All rights reserved.
//

import Foundation
import VKSdkFramework

protocol VKAuthManagerProtocol { //протокол для sceneDelegate, чтобы стать делегатом для VKSDKManager
    func authorizationFinished()
    func authorizationFailed()
    func shouldPresent(_ controller: UIViewController!)
}

class VKAuthManager: NSObject {
    
    static let shared = VKAuthManager()
    private let appId: String = "7662419"
    var delegate: VKAuthManagerProtocol? //Делегатом будет SceneDelegate чтобы регулировать переход по ViewControllers
    var token: String? {
        return VKSdk.accessToken()?.accessToken
    }
    var myId: String? {
        return VKSdk.accessToken()?.userId
    }
    
    private override init() {
        super.init()
        guard let vkSDK = VKSdk.initialize(withAppId: appId) else { return }
        vkSDK.register(self)
        vkSDK.uiDelegate = self
    }
    
    func wakeUpSession() {
        let scope = ["friends","wall"] //права доступа
        VKSdk.wakeUpSession(scope) { (state, error) in
            switch state {
            case .initialized:
                VKSdk.authorize(scope)  //после инициализации идет к регистрации
            case .authorized:
                self.delegate?.authorizationFinished()
            default:
                self.delegate?.authorizationFailed()
            }
        }
    }
}

extension VKAuthManager: VKSdkDelegate, VKSdkUIDelegate {
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        self.delegate?.authorizationFinished()
    }
    
    func vkSdkUserAuthorizationFailed() {
        self.delegate?.authorizationFailed()
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        self.delegate?.shouldPresent(controller)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
    }
}
