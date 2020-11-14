//
//  Gradient.swift
//  diffibleData
//
//  Created by Arman Davidoff on 24.02.2020.
//  Copyright © 2020 Arman Davidoff. All rights reserved.
//

import UIKit

class Gradient: UIView {
    
    var gradient = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradient(startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 1, y: 1), startColor: #colorLiteral(red: 0.7882352941, green: 0.631372549, blue: 0.9411764706, alpha: 1) ,endColor:  #colorLiteral(red: 0.4784313725, green: 0.6980392157, blue: 0.9215686275, alpha: 1))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(startPoint: CGPoint, endPoint: CGPoint, startColor:UIColor,endColor:UIColor) {
        self.init()
        setupGradient(startPoint: startPoint, endPoint: endPoint, startColor: startColor, endColor: endColor)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = bounds
        self.layer.masksToBounds = true
    }
    
    func setupGradient(startPoint: CGPoint, endPoint: CGPoint, startColor:UIColor,endColor:UIColor) {
        self.layer.addSublayer(gradient)
        gradient.colors = [startColor.cgColor,endColor.cgColor]
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
    }
    
    
}

extension UIView {
    func addGradientInView(cornerRadius: CGFloat) {
        self.backgroundColor = nil
        self.layoutIfNeeded()
        let gradient = Gradient()
        if let gradientLayer = gradient.layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.frame = self.bounds
            gradientLayer.cornerRadius = cornerRadius
            self.layer.insertSublayer(gradientLayer, at: 0)
        }
        
        
    }
    
}
