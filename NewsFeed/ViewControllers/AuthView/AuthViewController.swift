//
//  ViewController.swift
//  NewsFeed
//
//  Created by Arman Davidoff on 09.03.2020.
//  Copyright © 2020 Arman Davidoff. All rights reserved.
//

import UIKit
import VKSdkFramework

class AuthViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        // Do any additional setup after loading the view.
    }
    
    @IBAction func enterVK(_ sender: UIButton) {
        VKAuthManager.shared.wakeUpSession()
    }
    


}

