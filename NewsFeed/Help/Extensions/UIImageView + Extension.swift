//
//  UIImageViewExtension.swift
//  diffibleData
//
//  Created by Arman Davidoff on 25.02.2020.
//  Copyright © 2020 Arman Davidoff. All rights reserved.
//

import UIKit

extension UIImageView {
    func setupForSystemImageColor(color:UIColor) {
        let template = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = template
        self.tintColor = color
    }
}
