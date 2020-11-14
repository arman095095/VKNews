//
//  CustomTextFieldForSearch.swift
//  NewsFeed
//
//  Created by Arman Davidoff on 18.03.2020.
//  Copyright © 2020 Arman Davidoff. All rights reserved.
//

import Foundation
import UIKit

class CustomTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        layer.cornerRadius = 10
        layer.masksToBounds = true
        font = UIFont.systemFont(ofSize: 14)
        textColor = .black
        placeholder = "Поиск"
        clearButtonMode = .whileEditing
        borderStyle = .none
        backgroundColor = #colorLiteral(red: 0.9194131494, green: 0.9139476418, blue: 0.9236142635, alpha: 1)
        
        let imageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        imageView.setupForSystemImageColor(color: #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1))
        leftView = imageView
        leftViewMode = .always
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.leftViewRect(forBounds: bounds)
        rect.origin.x += 12
        return rect
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 36, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 36, dy: 0)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 36, dy: 0)
    }
}
