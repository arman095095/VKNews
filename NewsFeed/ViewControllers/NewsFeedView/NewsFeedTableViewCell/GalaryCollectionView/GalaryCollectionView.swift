//
//  GalaryCollectionView.swift
//  NewsFeed
//
//  Created by Arman Davidoff on 16.03.2020.
//  Copyright © 2020 Arman Davidoff. All rights reserved.
//

import Foundation
import UIKit

class GalaryCollectionView: UICollectionView {
    
    var photoModels = [PostImageModelForCellProtocol]()
    
    init() {
        let layout = GalaryCollectionViewLayout()
        super.init(frame: CGRect.zero, collectionViewLayout: layout)
        delegate = self
        dataSource = self
        backgroundColor = #colorLiteral(red: 0.9539752603, green: 0.9483039975, blue: 0.9583345056, alpha: 1)
        if let layout = collectionViewLayout as? GalaryCollectionViewLayout {
            layout.delegate = self
        }
        register(GalaryCollectionViewCell.self, forCellWithReuseIdentifier: GalaryCollectionViewCell.cellID)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(photoModels: [PostImageModelForCellProtocol]) {
        self.photoModels = photoModels
        contentOffset = CGPoint.zero
        showsHorizontalScrollIndicator = false
        reloadData()
    }
}

extension GalaryCollectionView:UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalaryCollectionViewCell.cellID, for: indexPath) as! GalaryCollectionViewCell
        cell.config(photoModel: photoModels[indexPath.row])
        return cell
    }
    
    
    
}

extension GalaryCollectionView: GalaryCollectionViewLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, cellSizeAtIndexPath indexPath: IndexPath) -> CGSize {
        let width = photoModels[indexPath.item].width
        let height = photoModels[indexPath.item].height
        return CGSize(width: width, height: height)
    }
    
    
}
