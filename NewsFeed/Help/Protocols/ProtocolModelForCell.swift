//
//  ProtocolModelForCell.swift
//  NewsFeed
//
//  Created by Arman Davidoff on 15.03.2020.
//  Copyright © 2020 Arman Davidoff. All rights reserved.
//

import Foundation
import UIKit

protocol SizesProtocol {
    var buttonFrame: CGRect { get }
    var postFrame: CGRect { get }
    var heightRow: CGFloat { get }
    var imageFrame: CGRect { get }
}

protocol PostImageModelForCellProtocol {
    var imageURLString: String {get }
    var width: Int { get }
    var height: Int { get }
}

protocol CustomCellDelegate: class {
    func showFullText(cell:NewsFeedTableViewCell)
}



