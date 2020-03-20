//
//  UIStoryboardExtension.swift
//  ETOnboarding
//
//  Created by Eray Alparslan on 19.03.2020.
//  Copyright © 2020 Eray Alparslan. All rights reserved.
//
import UIKit

extension UIStoryboard {
    static var main: UIStoryboard {
        let bundle = Bundle.main
        guard let storyboardName = bundle.object(forInfoDictionaryKey: "UIMainStoryboardFile") as? String else {
            fatalError("No main storyboard set in your app.")
        }
        return  UIStoryboard(name: storyboardName, bundle: bundle)
    }
    
    static var onboarding: UIStoryboard{
        return UIStoryboard(name: "Onboarding", bundle: Bundle(identifier: "com.erayalparslan.ETOnboarding"))
    }
   
}
