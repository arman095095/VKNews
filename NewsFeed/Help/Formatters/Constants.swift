//
//  Constants.swift
//  NewsFeed
//
//  Created by Arman Davidoff on 14.11.2020.
//  Copyright © 2020 Arman Davidoff. All rights reserved.
//

import UIKit

struct Constants {
    static let personImageHeight: CGFloat = 47
    static let cardViewTopInset:CGFloat = 7
    static let cardViewBottonInset: CGFloat = 11
    static let cardViewSideInset : CGFloat = 16
    static let heightTopView: CGFloat = 63
    static let heightButtonView: CGFloat = 40
    static var postsTextFont: UIFont {
        return UIFont.systemFont(ofSize: 14)
    }
    static var buttonFont: UIFont {
        return UIFont.systemFont(ofSize: 14, weight: .medium)
    }
    static let screenWidth = UIScreen.main.bounds.width
    static var screenHeight:CGFloat {
        return UIScreen.main.bounds.height - navigationBarHeight
    }
    
    static let navigationBarHeight:CGFloat = 44
    
    static var constantInsetForBigImg:CGFloat {
        if screenHeight > 800 { return screenHeight*0.278 }
        else if screenHeight < 800 && screenHeight > 600 { return screenHeight*0.125 }
        else { return 0 }
    }
}
