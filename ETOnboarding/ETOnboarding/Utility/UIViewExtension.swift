//
//  UIViewExtension.swift
//  ETOnboarding
//
//  Created by Eray Alparslan on 23.03.2020.
//  Copyright © 2020 Eray Alparslan. All rights reserved.
//

import UIKit

extension UIView{
    public func addShadow(radius: CGFloat = 5, offset: CGSize = CGSize(width: 0, height: 3), opacity: Float = 0.5){
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
    }
    
    public func removeShadow(){
        layer.masksToBounds = true
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 0
        layer.shadowOpacity = 0
    }
}
