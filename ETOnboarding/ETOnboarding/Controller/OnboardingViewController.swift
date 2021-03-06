//
//  OnboardingViewController.swift
//  ETOnboarding
//
//  Created by Eray Alparslan on 19.03.2020.
//  Copyright © 2020 Eray Alparslan. All rights reserved.
//

import UIKit


public protocol ETOnboardingDelegate{
    func didClickActionButton()
}

/// - Use display() function to display.
/// - Supply Onboarding content with display function
/// - Conform  OnboardingViewControllerDelegate protocol to get notifed about the skipping.
public class OnboardingViewController: UIViewController{
    @IBOutlet weak var onboardingContainerView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    private weak var onboardingPageViewController: OnboardingPageViewController?
    
    @IBOutlet weak var bottomView: UIView!
    public var delegate: ETOnboardingDelegate?
    private var currentPageIndex = 0
    private var timer: Timer?
    var contentList = [PageContent]()
    var isAutoSlideEnabled = true
    var slideDuration: TimeInterval = 3
    var backgroundColor: UIColor? = .green
    var backgroundImage: UIImage? = nil
    var isDarkFontEnabled: Bool = false
    var isPageControlActionEnabled: Bool = true
    var buttonTitle = "SKIP"
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    override public func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? OnboardingPageViewController{
            onboardingPageViewController = viewController
            onboardingPageViewController?.onboardingDelegate = self
            onboardingPageViewController?.loadContentWith(list: contentList)
            onboardingPageViewController?.isDarkFontsEnabled = isDarkFontEnabled
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
            selectedCell.updateCellWith(value: indexPath.row+1, isDarkFontEnabled: isDarkFontEnabled)
            return selectedCell
        }
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UnselectedPagingDotCollectionViewCell.className, for: indexPath) as? UnselectedPagingDotCollectionViewCell{
            let isFirstCell: Bool
            let isLastCell: Bool
            if indexPath.row == 0 { isFirstCell = true } else { isFirstCell = false}
            if onboardingPageViewController?.getNumberOfPages() == indexPath.row+1 { isLastCell = true } else { isLastCell = false}
            
            if isFirstCell{
                cell.updateCellWith(value: indexPath.row+1, isDarkFontEnabled: isDarkFontEnabled, isFirst: true)
            }
            else if isLastCell{
                cell.updateCellWith(value: indexPath.row+1, isDarkFontEnabled: isDarkFontEnabled, isLast: true)
            }
            else{
                cell.updateCellWith(value: indexPath.row+1 , isDarkFontEnabled: isDarkFontEnabled)
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
        if isPageControlActionEnabled{
            onboardingPageViewController?.openPage(currentIndex: currentPageIndex, wantedIndex: indexPath.row)
            currentPageIndex = indexPath.row
            collectionView.reloadData()
        }
        else{
            return
        }
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
        setupActionButton()
    }
    
    @objc private func actionButtonClicked(){
        self.dismiss(animated: true) {
            self.delegate?.didClickActionButton()
        }
    }
    
    private func setDelegates(){
        collectionView.delegate   = self
        collectionView.dataSource = self
    }
    
    private func setupActionButton(){
        let actionButton = StandartButton(frame: .zero)
        actionButton.setTitle(value: buttonTitle)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        bottomView.addSubview(actionButton)
        actionButton.backgroundColor = .white
        actionButton.widthAnchor.constraint(equalTo: bottomView.widthAnchor, multiplier: 0.8).isActive = true
        actionButton.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -25).isActive = true
        actionButton.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor, constant: 0).isActive = true
        actionButton.heightAnchor.constraint(equalTo: actionButton.widthAnchor, multiplier: 1/5).isActive = true
        
        actionButton.layer.cornerRadius = 13
        actionButton.tintColor = .black
        actionButton.button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        actionButton.addShadow()
        actionButton.button.addTarget(self, action: #selector(actionButtonClicked), for: .touchUpInside)
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
        timer = Timer.scheduledTimer(timeInterval: slideDuration, target: self, selector: #selector(updateSliderPage), userInfo: nil, repeats: true)
    }
    
    @objc func updateSliderPage() {
        if currentPageIndex == ((onboardingPageViewController?.getNumberOfPages() ?? 0) - 1)  { currentPageIndex = -1 }
        collectionView.reloadData()
       
        
       onboardingPageViewController?.openPage(currentIndex: currentPageIndex, wantedIndex: currentPageIndex+1)
       currentPageIndex += 1
       collectionView.reloadData()
    }
}
