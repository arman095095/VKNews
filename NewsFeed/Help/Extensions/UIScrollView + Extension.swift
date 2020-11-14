//
//  UIScrollView.swift
//  diffibleData
//
//  Created by Arman Davidoff on 02.03.2020.
//  Copyright © 2020 Arman Davidoff. All rights reserved.
//

import UIKit

extension UIScrollView {
    var isAtBottom:Bool {
        return contentOffset.y >= verticalOffsetForBottom
    }
    var verticalOffsetForBottom: CGFloat {
        return contentSize.height + contentInset.bottom - bounds.height
    }
}
