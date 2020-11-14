//
//  CellSize.swift
//  NewsFeed
//
//  Created by Arman Davidoff on 13.03.2020.
//  Copyright © 2020 Arman Davidoff. All rights reserved.
//

import Foundation
import UIKit

class SizesCalculator {
    
    let textLabelSidesInset : CGFloat = 26
    let spacing: CGFloat = 10
    let showTextLines: CGFloat = 6
    let maxTextLines: CGFloat = 7
    
    var buttonFrame: CGRect {
        let text = "Показать полностью..."
        let height = text.height(width: textLabelWidth, font: Constants.buttonFont)
        let size =  CGSize(width: text.width(font: Constants.buttonFont), height: height)
        let point = CGPoint(x: textLabelSidesInset/2, y: Constants.heightTopView + showTextHeight)
        return CGRect(origin: point, size: size)
    }
    var maxTextHeight : CGFloat {
        return Constants.postsTextFont.lineHeight * maxTextLines
    }
    var showTextHeight : CGFloat {
        return Constants.postsTextFont.lineHeight * showTextLines
    }
    var textLabelWidth : CGFloat {
        return Constants.screenWidth - Constants.cardViewSideInset - textLabelSidesInset
    }
    var constantHeight: CGFloat {
        return Constants.heightTopView + spacing + Constants.cardViewBottonInset + Constants.heightButtonView
    }
    
    func collectionViewHeight(width:CGFloat,imageModels:[NewsFeedsViewModel.ModelForCell.PostImageModelForCell]) -> CGFloat? {
        let photoSizes = imageModels.map { (image) -> CGSize in
            let width = image.width
            let height = image.height
            return CGSize(width: width, height: height)
        }
        let withMinRatio = photoSizes.min(by: { (size1, size2) -> Bool
            in return size1.height/size1.width < size2.height/size2.width })
        guard let sizeWithMinRatio = withMinRatio else { return nil }
        let ratio = sizeWithMinRatio.width / (width - 2*GalaryCollectionViewLayout.intervalX)
        let newHeight = sizeWithMinRatio.height / ratio
        let rowsCount = GalaryCollectionViewLayout.countOfRows(countOfItems: imageModels.count)
        switch rowsCount {
            case 1: return newHeight
            case 2: return newHeight*2
            default: return newHeight
        }
    }
    
    func getImageFrameForCell(imageModels:[NewsFeedsViewModel.ModelForCell.PostImageModelForCell],text:String?,flagShowedFullText: Bool) -> CGRect {
        let size = newImageSizeCalculate(imageModels: imageModels, text: text,flagShowedFullText: flagShowedFullText)
        let position = positionImagePost(size: size, text: text,flagShowedFullText: flagShowedFullText)
        return CGRect(origin: position, size: size)
    }
    
    //mainSizes
    func getSizes(postImageModels:[NewsFeedsViewModel.ModelForCell.PostImageModelForCell],item:Item,flagShowedFullText: Bool) -> SizesProtocol {
        let imagePostFrame = getImageFrameForCell(imageModels: postImageModels, text: item.text, flagShowedFullText: flagShowedFullText)
        let buttonframe = buttonFrame(text: item.text,flagShowedFullText: flagShowedFullText)
        let postFrame = textLabelFrame(text: item.text,flagShowedFullText: flagShowedFullText)
        let heightRow = rowHeight(imageModelFrame: imagePostFrame, text: item.text,flagShowedFullText: flagShowedFullText)
        return NewsFeedsViewModel.ModelForCell.Sizes(imageFrame: imagePostFrame, buttonFrame: buttonframe, postFrame: postFrame, heightRow: heightRow)
        
    }
}

private extension SizesCalculator {
    
    func rowHeight(imageModelFrame:CGRect,text: String?,flagShowedFullText:Bool) -> CGFloat {
        if text == nil || text == "" {
            return constantHeight + imageModelFrame.height - spacing
        }
        let buttonframe = buttonFrame(text: text,flagShowedFullText: flagShowedFullText )
        if buttonframe == CGRect.zero {
            return constantHeight + imageModelFrame.height + textLabelFrame(text: text,flagShowedFullText: flagShowedFullText).height
        }
        else {
            return constantHeight + imageModelFrame.height + showTextHeight + buttonframe.size.height
        }
    }
    
    func positionImagePost(size:CGSize,text: String?,flagShowedFullText: Bool) -> CGPoint {
        var center = CGFloat(integerLiteral: 0)
        let textHeight = textLabelFrame(text: text,flagShowedFullText: flagShowedFullText).height
        if size.width < Constants.screenWidth - Constants.cardViewSideInset {
            center = (Constants.screenWidth - Constants.cardViewSideInset - size.width)/2
        }
        if text == nil || text == "" {
            return CGPoint(x: center, y: Constants.heightTopView)
        }
        let buttonframe = buttonFrame(text: text,flagShowedFullText: flagShowedFullText)
        if buttonframe == CGRect.zero {
            return CGPoint(x: center, y: (Constants.heightTopView + spacing + textHeight)) }
        else {
            return CGPoint(x: center, y: (Constants.heightTopView + spacing + showTextHeight + buttonframe.size.height))
        }
    }
    
    func correctImageHeightForScreen(imageOldSize: CGSize, textHeight: CGFloat,flagShowedFullText: Bool,flagForCollectionView:Bool = false) -> CGSize {
        var textHeight = textHeight
        if flagShowedFullText { textHeight = showTextHeight }
        if imageOldSize.height > Constants.screenHeight - (textHeight + constantHeight + Constants.constantInsetForBigImg) {
            let ratio = imageOldSize.height / (Constants.screenHeight - (textHeight + constantHeight + Constants.constantInsetForBigImg))
            if !flagForCollectionView {
                let newWidth = imageOldSize.width / ratio
                return CGSize(width: newWidth, height: Constants.screenHeight - (textHeight + constantHeight+Constants.constantInsetForBigImg)) }
            else {
                return CGSize(width: imageOldSize.width, height: Constants.screenHeight - (textHeight + constantHeight+Constants.constantInsetForBigImg))
            }
        }
        else { return imageOldSize }
    }
    
    func newImageSizeCalculate(imageModels:[NewsFeedsViewModel.ModelForCell.PostImageModelForCell],text: String?,flagShowedFullText: Bool) -> CGSize {
        if imageModels.isEmpty { return CGSize.zero }
        let textFrame = textLabelFrame(text: text,flagShowedFullText: flagShowedFullText)
        if let imageModel = imageModels.first, imageModels.count == 1 {
            let imageModelWidth = CGFloat(integerLiteral: imageModel.width)
            let imageModelHeight = CGFloat(integerLiteral: imageModel.height)
            if imageModelWidth > Constants.screenWidth - Constants.cardViewSideInset {
                let ratio = imageModelWidth / (Constants.screenWidth - Constants.cardViewSideInset)
                let newHeight = imageModelHeight / ratio
                let size = CGSize(width: Constants.screenWidth - Constants.cardViewSideInset, height: newHeight)
                return correctImageHeightForScreen(imageOldSize: size, textHeight: textFrame.height,flagShowedFullText: flagShowedFullText)
            }
            else {
                let size = CGSize(width: imageModelWidth, height: imageModelHeight)
                return correctImageHeightForScreen(imageOldSize: size, textHeight: textFrame.height,flagShowedFullText: flagShowedFullText)
            }
        }
        
        let width = Constants.screenWidth - Constants.cardViewSideInset
        let height = collectionViewHeight(width: width, imageModels: imageModels)!
        let collectionViewSize = CGSize(width: width, height: height)
        return correctImageHeightForScreen(imageOldSize: collectionViewSize, textHeight: textFrame.height, flagShowedFullText: flagShowedFullText,flagForCollectionView: true)
        
    }
    
    func textLabelTestHeight(text:String?) -> CGFloat {
        guard let text = text else { return 0 }
        return text.height(width: textLabelWidth, font: Constants.postsTextFont)
    }
    
    func textLabelFrame(text:String?,flagShowedFullText: Bool) -> CGRect {
        if text == nil || text == "" { return CGRect.zero }
        if textLabelTestHeight(text: text) > maxTextHeight && !flagShowedFullText {
            return CGRect(origin: CGPoint(x: textLabelSidesInset/2, y: Constants.heightTopView), size: CGSize(width: textLabelWidth, height: showTextHeight) )
        }
        return CGRect(origin: CGPoint(x: textLabelSidesInset/2, y: Constants.heightTopView), size: CGSize(width: textLabelWidth, height: textLabelTestHeight(text: text)))
    }
    func buttonFrame(text:String?,flagShowedFullText: Bool) -> CGRect {
        if textLabelTestHeight(text: text) > maxTextHeight && !flagShowedFullText {
            return buttonFrame
        }
        return CGRect.zero
    }
}
