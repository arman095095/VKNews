//
//  CustomLayout.swift
//  NewsFeed
//
//  Created by Arman Davidoff on 17.03.2020.
//  Copyright © 2020 Arman Davidoff. All rights reserved.
//

import Foundation
import UIKit

protocol GalaryCollectionViewLayoutDelegate:class {
    func collectionView(_ collectionView: UICollectionView,cellSizeAtIndexPath indexPath: IndexPath) -> CGSize
}


class GalaryCollectionViewLayout:UICollectionViewLayout {
  
    var cache = [UICollectionViewLayoutAttributes]()
    weak var delegate: GalaryCollectionViewLayoutDelegate!
    
    var contentWidth:CGFloat = 0
    static var interval: CGFloat = 11
    static var intervalX: CGFloat = 10
    var contentHeight: CGFloat {
        guard let collectionViewFrameHeight = collectionView?.frame.height else { return 0 }
        return collectionViewFrameHeight
    }
    var rowCount: Int = 0
    static func countOfRows(countOfItems: Int) -> Int {
        if countOfItems < 5 { return 1 }
        else  { return 2 }
    }
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        cache = []
        contentWidth = 0
        guard let collectionView = collectionView else { return }
        let countItems = collectionView.numberOfItems(inSection: 0)
        rowCount = GalaryCollectionViewLayout.countOfRows(countOfItems: countItems)
        let inset = GalaryCollectionViewLayout.interval * CGFloat(rowCount - 1) / CGFloat(rowCount)
        let newImageHeight:CGFloat = (collectionView.frame.size.height - 2*GalaryCollectionViewLayout.interval) / CGFloat(rowCount) - inset
        var imageSizes = [CGSize]()
        for i in 0..<countItems {
            let indexPath = IndexPath(item: i, section: 0)
            let imageSize = delegate.collectionView(collectionView, cellSizeAtIndexPath: indexPath)
            imageSizes.append(imageSize)
        }
        let newImageSizes = imageSizes.map { (oldSize) -> CGSize in
            let ratio = oldSize.height / newImageHeight
            let newHeight = newImageHeight
            let newWidth = oldSize.width / ratio
            return CGSize(width: newWidth, height: newHeight)
        }
        
        var row = 0
        var xOffsets = [CGFloat](repeating: 0.0, count: rowCount)
        var yOffsets : [CGFloat] {
            var yoffsets = [CGFloat]()
            for row in 0..<rowCount {
                let yOffset = CGFloat(row+1)*GalaryCollectionViewLayout.interval + CGFloat(row)*newImageHeight
                yoffsets.append(yOffset)
            }
            return yoffsets
        }
        var imagePoints = [CGPoint]()
        
        for i in 0..<countItems {
            let imagePoint = CGPoint(x: xOffsets[row] + GalaryCollectionViewLayout.intervalX, y: yOffsets[row])
            xOffsets[row] += (newImageSizes[i].width + GalaryCollectionViewLayout.intervalX)
            imagePoints.append(imagePoint)
            row += 1
            if row >= rowCount {
                row = 0
            }
            
        }
        contentWidth = xOffsets.max()! + GalaryCollectionViewLayout.intervalX
        
        for i in 0..<countItems {
            let point = imagePoints[i]
            let size = newImageSizes[i]
            let indexPath = IndexPath(item: i, section: 0)
            let atribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            atribute.frame = CGRect(origin: point, size: size)
            cache.append(atribute)
        }
        
        
    }
        
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attatibute in cache {
            if attatibute.frame.intersects(rect) {
                visibleLayoutAttributes.append(attatibute)
            }
        }
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
    
}
