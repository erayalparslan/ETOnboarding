//
//  ETOnboarding.swift
//  ETOnboarding
//
//  Created by Eray Alparslan on 19.03.2020.
//  Copyright © 2020 Eray Alparslan. All rights reserved.
//

import UIKit

public class ETOnboarding{
    
    
    public static func show(onViewController: UIViewController, contentList: [PageContent], isAutoSlideEnabled: Bool, backgroundColor: UIColor, backgroundImage: UIImage? = nil, isDarkFontEnabled: Bool = false){
        let viewController = UIStoryboard.onboarding.instantiateViewController(withIdentifier: OnboardingViewController.className) as! OnboardingViewController
        viewController.modalPresentationStyle = .fullScreen
        viewController.isAutoSlideEnabled = isAutoSlideEnabled
        viewController.contentList = contentList
        viewController.backgroundColor = backgroundColor
        viewController.backgroundImage = backgroundImage
        viewController.isDarkFontEnabled = isDarkFontEnabled
        onViewController.present(viewController, animated: true, completion: nil)
    }
}
