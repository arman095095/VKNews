//
//  GalaryCollectionViewCell.swift
//  NewsFeed
//
//  Created by Arman Davidoff on 16.03.2020.
//  Copyright © 2020 Arman Davidoff. All rights reserved.
//

import Foundation
import UIKit

class GalaryCollectionViewCell: UICollectionViewCell {
    static let cellID = "customCellGalary"
    var postsImage : UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstreints()
        backgroundColor = .clear
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        postsImage.layer.cornerRadius = 10
        postsImage.layer.masksToBounds = true
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = CGSize(width: 2.5, height: 4)
        self.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    func setupConstreints() {
        self.addSubview(postsImage)
        postsImage.topAnchor.constraint(equalTo: topAnchor).isActive = true
        postsImage.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        postsImage.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        postsImage.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    func config(photoModel: PostImageModelForCellProtocol) {
        let photoModelURL = URL(string: photoModel.imageURLString)
        self.postsImage.sd_setImage(with: photoModelURL, completed: nil)
    }
}
