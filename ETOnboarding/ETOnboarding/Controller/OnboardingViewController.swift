//
//  OnboardingViewController.swift
//  ETOnboarding
//
//  Created by Eray Alparslan on 19.03.2020.
//  Copyright © 2020 Eray Alparslan. All rights reserved.
//

import UIKit


public protocol OnboardingViewControllerDelegate{
    func didClickActionButton()
}

/// - Use display() function to display.
/// - Supply Onboarding content with display function
/// - Conform  OnboardingViewControllerDelegate protocol to get notifed about the skipping.
public class OnboardingViewController: UIViewController{
    @IBOutlet weak var onboardingContainerView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var skipButton: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    private weak var onboardingPageViewController: OnboardingPageViewController?
    public var delegate: OnboardingViewControllerDelegate?
    private var currentPageIndex = 0
    private var timer: Timer?
    var contentList = [PageContent]()
    var isAutoSlideEnabled = true
    var backgroundColor: UIColor? = .green
    var backgroundImage: UIImage? = nil
    var isDarkFontsEnabled: Bool = false
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    override public func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? OnboardingPageViewController{
            onboardingPageViewController = viewController
            onboardingPageViewController?.onboardingDelegate = self
            onboardingPageViewController?.loadContentWith(list: contentList)
        }
    }
}

//MARK: UICollectionViewDelegate
extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onboardingPageViewController?.getNumberOfPages() ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let selectedCell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectedPagingDotCollectionViewCell.className, for: indexPath) as? SelectedPagingDotCollectionViewCell, indexPath.row == currentPageIndex{
            selectedCell.updateCellWith(value: indexPath.row+1)
            return selectedCell
        }
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UnselectedPagingDotCollectionViewCell.className, for: indexPath) as? UnselectedPagingDotCollectionViewCell{
            let isFirstCell: Bool
            let isLastCell: Bool
            if indexPath.row == 0 { isFirstCell = true } else { isFirstCell = false}
            if onboardingPageViewController?.getNumberOfPages() == indexPath.row+1 { isLastCell = true } else { isLastCell = false}
            
            if isFirstCell{
                cell.updateCellWith(value: indexPath.row+1, isFirst: true)
            }
            else if isLastCell{
                cell.updateCellWith(value: indexPath.row+1, isLast: true)
            }
            else{
                cell.updateCellWith(value: indexPath.row+1)
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let selectedRatio: CGFloat = 9.857
        let unselectedRatio: CGFloat = 13.8
        let optimumSelectedSize = CGSize(width: self.view.frame.width/selectedRatio, height: self.view.frame.width/selectedRatio)
        let optimumUnselectedSize = CGSize(width: self.view.frame.width/unselectedRatio, height: self.view.frame.width/unselectedRatio)
        return indexPath.row == currentPageIndex ? optimumSelectedSize : optimumUnselectedSize
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        /*
            Uncomment below code to enable swiping on page item click

            onboardingPageViewController?.openPage(currentIndex: currentPageIndex, wantedIndex: indexPath.row)
            currentPageIndex = indexPath.row
            collectionView.reloadData()
        */
    }
}


//MARK: OnboardingPageViewControllerDelegate
extension OnboardingViewController: OnboardingPageViewControllerDelegate{
    func didUpdatePageIndex(currentIndex: Int) {
        currentPageIndex = currentIndex
        collectionView.reloadData()
        setupTimer()
    }
}


//MARK: Class Methods
extension OnboardingViewController{
    private func setupViewController(){
        setDelegates()
        registerCells()
        setupCollectionView()
        
        
        //configure
        isAutoSlideEnabled ? setupTimer() : timer?.invalidate()
        self.view.backgroundColor = backgroundColor
        if backgroundImage != nil { backgroundImageView.image = backgroundImage }
        onboardingPageViewController?.isDarkFontsEnabled = isDarkFontsEnabled
    }
    
    private func setDelegates(){
        collectionView.delegate   = self
        collectionView.dataSource = self
    }
    
    private func registerCells(){
        let selectedNib = UINib(nibName: SelectedPagingDotCollectionViewCell.className, bundle: Bundle(for: SelectedPagingDotCollectionViewCell.self))
        collectionView.register(selectedNib, forCellWithReuseIdentifier: SelectedPagingDotCollectionViewCell.className)
        
        let unSelectedNib = UINib(nibName: UnselectedPagingDotCollectionViewCell.className, bundle: Bundle(for: UnselectedPagingDotCollectionViewCell.self))
        collectionView.register(unSelectedNib, forCellWithReuseIdentifier: UnselectedPagingDotCollectionViewCell.className)
    }
    
    private func setupCollectionView(){
        let layout: UICollectionViewFlowLayout = CollectionViewCenteredFlowLayout()
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 0
        collectionView!.collectionViewLayout = layout
    }
    
    private func setupTimer(){
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(updateSliderPage), userInfo: nil, repeats: true)
    }
    
    @objc func updateSliderPage() {
        if currentPageIndex == ((onboardingPageViewController?.getNumberOfPages() ?? 0) - 1)  { currentPageIndex = -1 }
        collectionView.reloadData()
       
        
       onboardingPageViewController?.openPage(currentIndex: currentPageIndex, wantedIndex: currentPageIndex+1)
       currentPageIndex += 1
       collectionView.reloadData()
    }
}
