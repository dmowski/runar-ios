//
//  OnboardingScreenVC.swift
//  Runar
//
//  Created by Виталий Татун on 27.07.22.
//

import UIKit

class OnboardingScreenVC: UIViewController {
    
    private var contentView = OnboardingView()
    private var onboardingModel = OnboardingSlide.slides()
    
    var currentPage = 0 {
        didSet {
            contentView.onboardingPageControl.currentPage = currentPage
            if currentPage == onboardingModel.count - 1 {
                contentView.onboardingNextSlideButton.setTitle(L10n.Onboarding.start, for: .normal)
            } else {
                contentView.onboardingNextSlideButton.setTitle(L10n.Onboarding.nextScreen, for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = contentView
        contentView.onboardingCollectionView.dataSource = self
        contentView.onboardingCollectionView.delegate = self
        contentView.onboardingViewDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
    }
}

extension OnboardingScreenVC: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onboardingModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: OnboardingScreenCell.self), for: indexPath) as! OnboardingScreenCell
        let slides = onboardingModel[indexPath.item]
        cell.configureOnboardingCell(with: slides)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 350)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}

extension OnboardingScreenVC: OnboardingViewDelegateProtocol {
    
    func skipButton() {
        
        UserDefaults.standard.set(true, forKey: "hasViewedOnboardingScreen")
        self.navigationController?.popViewController(animated: true)
    }
    
    func nextSlideButton() {
        
        contentView.onboardingCollectionView.isPagingEnabled = false
        
        if currentPage == onboardingModel.count - 1 {
            self.navigationController?.popViewController(animated: true)
            UserDefaults.standard.set(true, forKey: "hasViewedOnboardingScreen")
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            contentView.onboardingCollectionView.scrollToItem(
                at: indexPath,
                at: .centeredHorizontally,
                animated: true)
        }
        
        contentView.onboardingCollectionView.isPagingEnabled = true
    }
}
