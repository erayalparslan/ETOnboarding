//
//  OnboardingPageViewController.swift
//  ETOnboarding
//
//  Created by Eray Alparslan on 19.03.2020.
//  Copyright © 2020 Eray Alparslan. All rights reserved.
//

import UIKit

protocol OnboardingPageViewControllerDelegate: class{
    func didUpdatePageIndex(currentIndex: Int)
}

class OnboardingPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource{
    private var currentIndex = 0
    private var onboardingContentList = [PageContent]()
    weak var onboardingDelegate: OnboardingPageViewControllerDelegate?
    var isDarkFontsEnabled = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    public func loadContentWith(list: [PageContent]){
        onboardingContentList.removeAll()
        onboardingContentList.append(contentsOf: list)
    }
}


//MARK: UIPageViewControllerDelegate, UIPageViewControllerDataSource
extension OnboardingPageViewController{
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed, let contentViewController = pageViewController.viewControllers?.first as? OnboardingContentViewController{
            onboardingDelegate?.didUpdatePageIndex(currentIndex: contentViewController.getCurrentIndex())
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let viewController = viewController as? OnboardingContentViewController{
            return contentViewController(at: viewController.getBeforeIndex())
        }
        else{
            print("‼️ Error casting UIViewController to OnboardingContentViewController")
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let viewController = viewController as? OnboardingContentViewController{
            return contentViewController(at: viewController.getNextIndex())
        }
        else{
            print("‼️ Error casting UIViewController to OnboardingContentViewController")
            return nil
        }
    }
}


//MARK: Helper Methods
extension OnboardingPageViewController{
    func getNumberOfPages() -> Int{
        return onboardingContentList.count
    }
    
    func openPage(currentIndex: Int, wantedIndex: Int){
        guard currentIndex != wantedIndex else { return }
        
        if let contentViewController = contentViewController(at: wantedIndex){
            let direction: NavigationDirection = currentIndex < wantedIndex ? .forward : .reverse
            setViewControllers([contentViewController], direction: direction, animated: true, completion: nil)
        }
    }
}


//MARK: Class Methods
extension OnboardingPageViewController{
    private func contentViewController(at index: Int) -> OnboardingContentViewController?{
        if index < 0 || index >= onboardingContentList.count{
            return nil
        }
        if let viewController = UIStoryboard.onboarding.instantiateViewController(withIdentifier: OnboardingContentViewController.className) as? OnboardingContentViewController{
            viewController.loadContentWith(index: index, onboardContent: onboardingContentList[index])
            viewController.makeFontsDark()
            return viewController
        }
        return nil
    }
    
    private func setupViewController(){
        dataSource = self
        delegate   = self
        if let firstContentViewController = contentViewController(at: 0){
            setViewControllers([firstContentViewController], direction: .forward, animated: true, completion: nil)
        }
    }
}
