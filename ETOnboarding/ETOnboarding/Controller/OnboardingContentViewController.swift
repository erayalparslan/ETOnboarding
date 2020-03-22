//
//  OnboardingContentViewController.swift
//  ETOnboarding
//
//  Created by Eray Alparslan on 19.03.2020.
//  Copyright © 2020 Eray Alparslan. All rights reserved.
//

import UIKit

class OnboardingContentViewController: UIViewController{
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    private var index = 0
    private var image: UIImage?
    private var heading = ""
    private var subheading = ""
    private var isDarkFontsEnabled = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}


//MARK: Helper Methods
extension OnboardingContentViewController{
    func getCurrentIndex() -> Int{
        return index
    }
    
    func getBeforeIndex() -> Int{
        return index - 1
    }
    
    func getNextIndex() -> Int{
        return index + 1
    }
    
    func loadContentWith(index: Int, onboardContent: PageContent){
        self.index = index
        self.image = onboardContent.image
        self.heading = onboardContent.heading
        self.subheading = onboardContent.subHeading
    }
    
    func makeFontsDark(){
        self.isDarkFontsEnabled = true
    }
}


//MARK: Class Methods
extension OnboardingContentViewController{
    private func setup(){
        imageView.image = image
        titleLabel.text = heading
        subtitleLabel.text = subheading
        
        if isDarkFontsEnabled {
            titleLabel.textColor = .black
            subtitleLabel.textColor = .black
        }
    }
}
