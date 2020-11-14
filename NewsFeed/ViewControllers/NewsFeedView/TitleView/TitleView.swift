//
//  TitleView.swift
//  NewsFeed
//
//  Created by Arman Davidoff on 18.03.2020.
//  Copyright © 2020 Arman Davidoff. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class TitleView: UIView {
    
    var searchTextField:CustomTextField = {
        var view = CustomTextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var avatarImageView: UIImageView = {
        var view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        UIView.layoutFittingExpandedSize
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImageView.layer.cornerRadius = avatarImageView.layer.frame.height / 2
        avatarImageView.clipsToBounds = true
    }
    
    func setup(with model: UserInfoModel) {
        guard let url = URL(string: model.imageURL) else { return }
        avatarImageView.sd_setImage(with: url) { [weak self] (_, _, _, _) in
            self?.avatarImageView.layer.cornerRadius = (self?.avatarImageView.layer.frame.height)! / 2
            self?.avatarImageView.clipsToBounds = true
        }
    }
    
    func setup() {
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.backgroundColor = .white
        addSubview(searchTextField)
        addSubview(avatarImageView)
        
        avatarImageView.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -7).isActive = true
        avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -14).isActive = true
        avatarImageView.heightAnchor.constraint(equalTo: searchTextField.heightAnchor).isActive = true
        avatarImageView.widthAnchor.constraint(equalTo: searchTextField.heightAnchor).isActive = true
        
        searchTextField.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 14).isActive = true
        searchTextField.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -7).isActive = true
        searchTextField.trailingAnchor.constraint(equalTo: avatarImageView.leadingAnchor,constant: -8).isActive = true
        searchTextField.topAnchor.constraint(equalTo: topAnchor).isActive = true
    }
    
}
