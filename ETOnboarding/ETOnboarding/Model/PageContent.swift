//
//  PageContent.swift
//  ETOnboarding
//
//  Created by Eray Alparslan on 19.03.2020.
//  Copyright © 2020 Eray Alparslan. All rights reserved.
//

import UIKit

public class PageContent{
    var heading: String
    var subHeading: String
    var image: UIImage?
    
    public init(heading: String, subHeading: String, imageName: String) {
        self.heading = heading
        self.subHeading = subHeading
        self.image = UIImage(named: imageName)
    }
}
