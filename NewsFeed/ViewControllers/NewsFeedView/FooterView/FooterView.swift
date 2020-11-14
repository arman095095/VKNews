//
//  FooterView.swift
//  NewsFeed
//
//  Created by Arman Davidoff on 20.03.2020.
//  Copyright © 2020 Arman Davidoff. All rights reserved.
//

import Foundation
import UIKit

protocol Footer: class {
    
    var activityIndicator: UIActivityIndicatorView { get }
    var postsCountLabel: UILabel { get }
    
    func start(count:Int)
    func stop(count:Int,info: String)
    
}

class FooterView: UIView,Footer {
    
    
    var postsCountLabel: UILabel = {
        var view = UILabel()
        view.numberOfLines = 0
        view.textAlignment = .center
        view.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        view.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var activityIndicator: UIActivityIndicatorView = {
        var view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.hidesWhenStopped = true
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        addSubview(postsCountLabel)
        addSubview(activityIndicator)
        setupConstreints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func start(count: Int) {
        
        postsCountLabel.text = String.localizedStringWithFormat(NSLocalizedString("news feed cells count", comment: ""), count)
        activityIndicator.startAnimating()
    }
    func stop(count:Int,info: String) {
        postsCountLabel.text = String.localizedStringWithFormat(NSLocalizedString("news feed cells count", comment: ""), count) + "\n" + info
        activityIndicator.stopAnimating()
    }
    
    func setupConstreints() {
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.topAnchor.constraint(equalTo: bottomAnchor,constant: 5).isActive = true
        postsCountLabel.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor,constant: 5).isActive = true
        postsCountLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
    }
}
