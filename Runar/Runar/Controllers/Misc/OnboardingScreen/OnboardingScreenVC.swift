//
//  OnboardingScreenVC.swift
//  Runar
//
//  Created by Виталий Татун on 27.07.22.
//

import UIKit

class OnboardingScreenVC: UIViewController {
    
    let onboardingSkipButton = UIButton()
    var onboardingCollectionView: UICollectionView!
    let onboardingNextSlideButton = CustomButton()
    let onboardingPageControl = UIPageControl()
    
    var currentPage = 0 {
        didSet {
            onboardingPageControl.currentPage = currentPage
            if currentPage == onboardingSlides.count - 1 {
                onboardingNextSlideButton.setTitle(L10n.Onboarding.skip, for: .normal)
            } else {
                onboardingNextSlideButton.setTitle(L10n.Onboarding.nextScreen, for: .normal)
            }
        }
    }
    
    
    var onboardingSlides: [OnboardingSlide] = [
        OnboardingSlide(title: "О чем приложение", description: "Получай ответы на волнующие вопросы с помощью рун", image: UIImage(named: "about")!),
        OnboardingSlide(title: "Как гадать", description: "Выбирай один из восьми раскладов и смотри толкование своей судьбы", image: UIImage(named: "howTo")!),
        OnboardingSlide(title: "Толкование", description: "Смотри интерпретацию каждого расклада с указанием уровня удачи", image: UIImage(named: "explanation")!),
        OnboardingSlide(title: "Избранное", description: "Сохраняй понравившиеся толкования и значения рун в Избранное", image: UIImage(named: "favorites")!),
        OnboardingSlide(title: "Генератор", description: "Смотри интерпретацию каждого расклада с указанием уровня удачи", image: UIImage(named: "generator")!),
        OnboardingSlide(title: "Библиотека", description: "Заходи в Библиотеку знаний, изучай сказки, мифологию и историю рун", image: UIImage(named: "library")!)
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Runar.RunarLayout.initBackground(for: view, with: .mainFire)
        
        configureSkipButton()
        configureOnboardingCollectioView()
        configureNextSlideButton()
        configureOnboardingPageControll()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func configureSkipButton() {
        onboardingSkipButton.backgroundColor = .clear
        onboardingSkipButton.setTitle(L10n.Onboarding.skip, for: .normal)
        onboardingSkipButton.titleLabel?.font = UIFont(name: "SFProText-Regular", size: 15)
        onboardingSkipButton.titleLabel?.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7)
        self.view.addSubview(onboardingSkipButton)
        onboardingSkipButton.addTarget(self, action: #selector(goToMainScreen), for: .touchUpInside)
        onboardingSkipButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(24)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    private func configureOnboardingCollectioView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.register(OnboardingScreenCell.self, forCellWithReuseIdentifier: String(describing: OnboardingScreenCell.self))
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(onboardingSkipButton.snp.bottom).offset(114)
            make.height.equalTo(350)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        self.onboardingCollectionView = collectionView
    }
    private func configureNextSlideButton() {
        let radiusConstant: CGFloat = DeviceType.iPhoneSE ? 6.58 : 8
        onboardingNextSlideButton.layer.cornerRadius = radiusConstant
        let borderConstant: CGFloat = DeviceType.iPhoneSE ? 0.82 : 1
        onboardingNextSlideButton.layer.borderWidth = borderConstant
        onboardingNextSlideButton.setTitle(L10n.Onboarding.nextScreen, for: .normal)
        onboardingNextSlideButton.backgroundColor = UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36)
        onboardingNextSlideButton.layer.borderColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1).cgColor
        onboardingNextSlideButton.translatesAutoresizingMaskIntoConstraints = false
        let fontConstant: CGFloat = DeviceType.iPhoneSE ? 24 : 30
        onboardingNextSlideButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: fontConstant)
        onboardingNextSlideButton.setTitleColor(UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1), for: .normal)
        onboardingNextSlideButton.setTitleColor(UIColor(red: 0.294, green: 0.282, blue: 0.259, alpha: 1), for: .highlighted)
        
        self.view.addSubview(onboardingNextSlideButton)
        onboardingNextSlideButton.addTarget(self, action: #selector(goToNextSlide), for: .touchUpInside)
        
        onboardingNextSlideButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(184)
            make.centerX.equalToSuperview()
            make.width.equalTo(264)
            make.height.equalTo(48)
        }
    }
    private func configureOnboardingPageControll() {
        onboardingPageControl.numberOfPages = 6
        onboardingPageControl.currentPageIndicatorTintColor = UIColor(red: 1, green: 0.753, blue: 0.275, alpha: 1)
        onboardingPageControl.isUserInteractionEnabled = false
        self.view.addSubview(onboardingPageControl)
        onboardingPageControl.snp.makeConstraints { make in
            make.top.equalTo(onboardingNextSlideButton.snp.bottom).offset(60)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc func goToMainScreen() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func goToNextSlide() {
        onboardingCollectionView.isPagingEnabled = false
        
        if currentPage == onboardingSlides.count - 1 {
            self.navigationController?.popViewController(animated: true)
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            onboardingCollectionView.scrollToItem(
                at: indexPath,
                at: .centeredHorizontally,
                animated: true)
            print("slide to \(currentPage)")
        }
        onboardingCollectionView.isPagingEnabled = true
    }
}
extension OnboardingScreenVC: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onboardingSlides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: OnboardingScreenCell.self), for: indexPath) as! OnboardingScreenCell
        let slides = onboardingSlides[indexPath.item]
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
        print("now you're on slide \(currentPage)")
    }
    
    
}

