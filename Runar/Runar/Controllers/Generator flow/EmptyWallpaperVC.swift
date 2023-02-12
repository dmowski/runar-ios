//
//  EmptyWallpaperVC.swift
//  Runar
//
//  Created by Георгий Ступаков on 2/21/22.
//

import UIKit
import SnapKit

//MARK: Constants
private extension String {
    static let newVariant = L10n.Generator.EmptyWallpapersNewVariant.btnTitle
    static let wallpapersTitle = L10n.Generator.Wallpapers.title
    static let emptyWallpapersSubTitle = L10n.Generator.EmptyWallpapers.subtitle
}

private extension UIColor {
    static let contentViewBackgroundColor = UIColor(red: 0.143, green: 0.142, blue: 0.143, alpha: 0.5)
    static let newVariantButtonBackgroundColor = UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36)
}

private extension CGFloat {
    static let subTitleTopAnchor = 112.0
    static let subTitleLeadingAnchor = 30.0
    static let subTitleTrailingAnchor = -30.0
    
    static let contentViewTopAnchor = 16.0
    static let contentViewLeadingAnchor = 16.0
    static let contentViewTrailingAnchor = -16.0
    
    static let imageViewTopAnchor = 10.0
    static let imageViewLeadingAnchor = 30.0
    static let imageViewTrailingAnchor = -30.0
    static let imageViewBottomAnchor = -100.0
    
    static let newVariantButtonBottomAnchor = -32.0
    static let newVariantButtonLeadingAnchor = 90.0
    static let newVariantButtonTrailingAnchor = -90.0
    static let newVariantButtonHeightAnchor = 50.0
    
    static let nextButtonTopAnchor = 32.0
    static let nextButtonLeadingAnchor = 16.0
    static let nextButtonTrailingAnchor = -16.0
    static let nextButtonBottomAnchor = -40.0
    static let nextButtonHeightAnchor = 50.0
}

public class EmptyWallpaperVC: UIViewController {
    
    private var emptyWallpapers = [EmptyWallpaper]()
    private var currentEmptyWallpaperName: String?
    var stopDownloading: (() -> ())?
    
    let subTitle: UILabel = {
        let processingLabel = UILabel()
        processingLabel.textColor = UIColor.primaryWhiteColor
        processingLabel.textAlignment = .center
        processingLabel.numberOfLines = 0
        processingLabel.lineBreakMode = .byWordWrapping
        processingLabel.text = .emptyWallpapersSubTitle
        processingLabel.font = .systemRegular(size: 14)
        return processingLabel
    }()
    
    let contentView: UIView = {
        let contentView = UIView()
        contentView.layer.backgroundColor = UIColor.contentViewBackgroundColor.cgColor
        contentView.layer.cornerRadius = 16
        contentView.layer.shadowOffset = CGSize(width: 0, height: 10)
        contentView.layer.shadowRadius = 5
        contentView.layer.shadowOpacity = 0.75
        return contentView
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let newVariantButton: UIButton = {
        let newVariantButton = UIButton()
        newVariantButton.layer.backgroundColor = UIColor.newVariantButtonBackgroundColor.cgColor
        newVariantButton.layer.cornerRadius = 8
        newVariantButton.layer.borderWidth = 1
        newVariantButton.contentHorizontalAlignment = .center
        newVariantButton.contentEdgeInsets = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        newVariantButton.layer.borderColor = UIColor.yellowPrimaryColor.cgColor
        newVariantButton.setTitle(title: .newVariant)
        return newVariantButton
    }()
    
    let nextButton: UIButton = {
        let nextButton = UIButton()
        nextButton.layer.backgroundColor = UIColor.yellowPrimaryColor.cgColor
        nextButton.layer.cornerRadius = 5
        nextButton.setTitle(title: .nextButtonTitle, color: UIColor.primaryBlackColor)
        nextButton.contentHorizontalAlignment = .center
        nextButton.contentEdgeInsets = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        return nextButton
    }()
    
    init(emptyWallpapers: [EmptyWallpaper], stopDownloading: @escaping (() -> ())) {
        self.emptyWallpapers = emptyWallpapers
        self.stopDownloading = stopDownloading
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        RunarLayout.initBackground(for: view, with: .mainFire)
        
        currentEmptyWallpaperName = ImageFileManager.shared.getNamesImagesWithoutBackground().first
        showEmptyWallpaper(with: currentEmptyWallpaperName)
        
        setupViews()
        configureNavigationBar()
        setupImageViewSwipes()
        updateEmptyVC()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    private func setupViews() {
        view.addSubviews(subTitle)
        subTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(CGFloat.subTitleTopAnchor)
            make.leading.equalToSuperview().offset(CGFloat.subTitleLeadingAnchor)
            make.trailing.equalToSuperview().offset(CGFloat.subTitleTrailingAnchor)
        }
        
        view.addSubviews(contentView)
        contentView.snp.makeConstraints { make in
            make.top.equalTo(subTitle.snp.bottom).offset(CGFloat.contentViewTopAnchor)
            make.leading.equalToSuperview().offset(CGFloat.contentViewLeadingAnchor)
            make.trailing.equalToSuperview().offset(CGFloat.contentViewTrailingAnchor)
        }
        
        contentView.addSubviews(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(CGFloat.imageViewTopAnchor)
            make.leading.equalToSuperview().offset(CGFloat.imageViewLeadingAnchor)
            make.trailing.equalToSuperview().offset(CGFloat.imageViewTrailingAnchor)
            make.bottom.equalToSuperview().offset(CGFloat.imageViewBottomAnchor)
        }
        
        contentView.addSubviews(newVariantButton)
        newVariantButton.addTarget(self, action: #selector(self.generateNewVariant), for: .touchUpInside)
        newVariantButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(CGFloat.newVariantButtonBottomAnchor)
            make.leading.equalToSuperview().offset(CGFloat.newVariantButtonLeadingAnchor)
            make.trailing.equalToSuperview().offset(CGFloat.newVariantButtonTrailingAnchor)
            make.height.equalTo(CGFloat.newVariantButtonHeightAnchor)
        }
        
        view.addSubviews(nextButton)
        nextButton.addTarget(self, action: #selector(self.nextButtonTapped), for: .touchUpInside)
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.bottom).offset(CGFloat.nextButtonTopAnchor)
            make.leading.equalToSuperview().offset(CGFloat.nextButtonLeadingAnchor)
            make.trailing.equalToSuperview().offset(CGFloat.nextButtonTrailingAnchor)
            make.bottom.equalToSuperview().offset(CGFloat.nextButtonBottomAnchor)
            make.height.equalTo(CGFloat.nextButtonHeightAnchor)
        }
    }
    
    private func configureNavigationBar() {
        navigationItem.setNavigationTitle(.wallpapersTitle)
        navigationItem.hidesBackButton = true
        let customBackButton = UIBarButtonItem(image: Assets.backIcon.image,
                                               style: .plain, target: self,
                                               action: #selector(self.backToSelectionViewController))
        customBackButton.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        navigationItem.leftBarButtonItem = customBackButton
    }
    
    @objc func backToSelectionViewController(sender: UIBarButtonItem) {
        guard let viewControllers = navigationController?.viewControllers as? [UIViewController] else { return }
        navigationController?.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
    }
    
    private func updateEmptyVC() {
        guard let navigationController = self.navigationController else { return }

        var indexArray: [Int] = []

        navigationController.viewControllers.enumerated().forEach { (index, vc) in
            guard String(describing: vc).contains(String(describing: Self.self)) else { return }
            indexArray.append(index)
        }

        guard indexArray.count > 1 else { return }

        navigationController.viewControllers.remove(at: indexArray[0])
    }
    
    @objc func generateNewVariant() {
        
        let downloadedImagesNames = ImageFileManager.shared.getNamesImagesWithoutBackground()
        guard let randomElement = downloadedImagesNames.randomElement() else { return }
        currentEmptyWallpaperName = randomElement
        showEmptyWallpaper(with: randomElement)
    }
    
    private func setupImageViewSwipes() {
        imageView.isUserInteractionEnabled = true
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeftAction))
        swipeLeft.direction = .left
        self.imageView.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeRightAction))
        swipeRight.direction = .right
        self.imageView.addGestureRecognizer(swipeRight)
    }
    
    @objc private func swipeRightAction() {
        currentEmptyWallpaperName = getEmptyWallpaperBefore(element: currentEmptyWallpaperName)
        showEmptyWallpaper(with: currentEmptyWallpaperName)
    }
    
    @objc private func swipeLeftAction() {
        currentEmptyWallpaperName = getEmptyWallpaperAfter(element: currentEmptyWallpaperName)
        showEmptyWallpaper(with: currentEmptyWallpaperName)
    }
    
    @objc func nextButtonTapped() {
        let selectWallpaperStyleVC = WallpaperWithBackgroundVC()
        guard let currentEmptyWallpaperName = currentEmptyWallpaperName,
              let emptyWallpaperCurrent = emptyWallpapers.first(where: { $0.name.elementsEqual(currentEmptyWallpaperName) }) else { return }
        selectWallpaperStyleVC.emptyWallpaperUrl = emptyWallpaperCurrent.url
        self.navigationController?.pushViewController(selectWallpaperStyleVC, animated: true)
        
        guard let stopDownloading = stopDownloading else { return }
        stopDownloading()
    }
    
    private func showEmptyWallpaper(with name: String?) {
        guard let name = name,
              let image = ImageFileManager.shared.readImageFromFile(name) else { return }
        imageView.image = image
    }
    
    private func getEmptyWallpaperBefore(element name: String?) -> String? {
        
        let  namesOfDownloadedImages = ImageFileManager.shared.getNamesImagesWithoutBackground()
        
        guard let name = name else {
            let firstElement = namesOfDownloadedImages.first
            currentEmptyWallpaperName = firstElement
            return firstElement
        }
        
        guard let index = namesOfDownloadedImages.firstIndex(where: { $0.elementsEqual(name) }) else { return nil }
        
        guard index != namesOfDownloadedImages.startIndex else {
            
            let lastElement = namesOfDownloadedImages.last
            
            return lastElement
                
        }
        
        let prevIndex = namesOfDownloadedImages.index(before: index)
        let prevElement = namesOfDownloadedImages[prevIndex]
        
        return prevElement
    }
    
    private func getEmptyWallpaperAfter(element name: String?) -> String? {

        let  namesOfDownloadedImages = ImageFileManager.shared.getNamesImagesWithoutBackground()
        
        guard let name = name else {
            let firstElement = namesOfDownloadedImages.first
            currentEmptyWallpaperName = firstElement
            return firstElement
        }

        guard let index = namesOfDownloadedImages.firstIndex(where: { $0.elementsEqual(name) }) else {
            return nil
        }

        guard index != namesOfDownloadedImages.endIndex - 1 else {

            let lastElement = namesOfDownloadedImages.first

            return lastElement

        }

        let nextIndex = namesOfDownloadedImages.index(after: index)
        let nextElement = namesOfDownloadedImages[nextIndex]

        return nextElement
    }
}
