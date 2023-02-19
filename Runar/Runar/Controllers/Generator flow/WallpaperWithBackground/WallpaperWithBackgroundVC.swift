//
//  WallpaperWithBackgroundVC.swift
//  Runar
//
//  Created by Maksim Harbatsevich on 10/23/21.
//

import UIKit
import SnapKit

//MARK: Constants
extension String {
    static let wallpapersHeader = L10n.Generator.WallpapersHeader.title
    static let wallpapersDescription = L10n.Generator.WallpapersDescription.subtitle
    static let progressName = L10n.Generator.Progress.name
    static let generateProgressTitle = L10n.Generator.ProgressGenerator.title
    static let nextButtonTitle = L10n.Generator.NextButton.title
}

private extension CGFloat {
    static let subTitleTopAnchor = 27
    static let subTitleLeadingAnchor = 16
    
    static let selectWallpaperViewTopAnchor = 32.0
    static let selectWallpaperBottomAnchor = 144.0
    
    static let pageControlTopAnchor = 20.0
    static let pageControlHeightAnchor = 20.0
    
    static let nextButtonLeadingAnchor = 16.0
    static let nextButtonBottomAnchor = 40.0
    static let nextButtonHeightAnchor = 50.0
}

public class WallpaperWithBackgroundVC: UIViewController {

    let cellId = "wallpaperCellId"
    
    var emptyWallpaperUrl: String?
    var wallpapers: [WallpaperWithBackgroundCell] = []
    var imagesWithBackground: [UIImage?] = []
    var selectedImage: UIImage?
    var isSelected: Bool = false
    var indexPath: Int?
    
    let subTitle: UILabel = {
        let title = UILabel()
        title.textColor = .primaryWhiteColor
        title.textAlignment = .center
        title.numberOfLines = 1
        title.text = .wallpapersDescription
        title.font = .amaticBold(size: 24)
        title.backgroundColor = .clear
        title.adjustsFontSizeToFitWidth = true
        return title
    }()
    
    let selectWallpaperView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .horizontal
        
        let selectWallpaperView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        selectWallpaperView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 30, right: 16)
        selectWallpaperView.showsHorizontalScrollIndicator = false
        selectWallpaperView.allowsMultipleSelection = false
        selectWallpaperView.isPagingEnabled = false
        selectWallpaperView.isScrollEnabled = true
        selectWallpaperView.backgroundColor = .clear
        
        return selectWallpaperView
    }()
    
    let pageControl: UIPageControl = {
        let page = UIPageControl()
        page.backgroundColor = .clear
        page.numberOfPages = 4
        page.currentPage = 0
        return page
    }()

    let nextButton: UIButton = {
        let nextButton = UIButton()
        nextButton.layer.backgroundColor = UIColor.yellowPrimaryColor.cgColor
        nextButton.layer.cornerRadius = 5
        nextButton.isHidden = true
        nextButton.setTitle(title: .nextButtonTitle, color: UIColor.primaryBlackColor)
        return nextButton
    }()
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        view.color = .white
        view.isHidden = true
        return view
    }()
        
    public override func viewDidLoad() {
        super.viewDidLoad()        
        RunarLayout.initBackground(for: view, with: .mainFire)
        
        setupActivityIndicator()
        startActivityIndicator()
        setupViewController()
        
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        navigationController?.setStatusBar(backgroundColor: .navBarBackground)
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = true
        navigationController?.deletStatusBarView()
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unselectedSet()
    }
    
    private func configureNavBar() {
        self.navigationItem.setNavigationTitle(.wallpapersHeader)
        self.navigationItem.hidesBackButton = true
        if isSelected == true {
            let customBackLabel = UIBarButtonItem(title: L10n.Tabbar.cancel,
                                                  style: .done, target: self,
                                                  action: #selector(self.unselectedTapped))
            customBackLabel.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            navigationItem.leftBarButtonItem = customBackLabel
        } else {
            let customBackButton = UIBarButtonItem(image: Assets.backIcon.image,
                                                   style: .plain, target: self,
                                                   action: #selector(self.backToInitial))
            customBackButton.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            navigationItem.leftBarButtonItem = customBackButton
        }
    }
    
    private func setupActivityIndicator() {
        self.view.addSubviews(activityIndicatorView)
        activityIndicatorView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func startActivityIndicator() {
        activityIndicatorView.startAnimating()
        activityIndicatorView.isHidden = false
    }
    
    private func stopActivityIndicator() {
        activityIndicatorView.stopAnimating()
        activityIndicatorView.isHidden = true
    }
    
    private func setupViewController() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.downloadingWallpapers()

            DispatchQueue.main.async {
                self.stopActivityIndicator()
                
                self.imagesWithBackground = ImageFileManager.shared.getImagesWithBackground()
                self.setupBindings()
                self.setupViews()
                self.configureNavBar()
                self.setupWallpapers()
            }
        }
    }
    
    private func setupBindings() {
        self.selectWallpaperView.delegate = self
        self.selectWallpaperView.dataSource = self
        self.selectWallpaperView.register(WallpaperWithBackgroundCell.self, forCellWithReuseIdentifier: cellId)
    }

    private func setupViews() {
        
        self.view.addSubview(subTitle)
        subTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(CGFloat.subTitleTopAnchor)
            make.leading.trailing.equalToSuperview().inset(CGFloat.subTitleLeadingAnchor)
        }
        
        self.view.addSubview(selectWallpaperView)
        selectWallpaperView.snp.makeConstraints { make in
            make.top.equalTo(subTitle.snp.bottom).offset(CGFloat.selectWallpaperViewTopAnchor)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(CGFloat.selectWallpaperBottomAnchor)
        }

        self.view.addSubview(pageControl)
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(selectWallpaperView.snp.bottom).offset(CGFloat.pageControlTopAnchor)
            make.height.equalTo(CGFloat.pageControlHeightAnchor)
        }

        self.view.addSubview(nextButton)
        nextButton.addTarget(self, action: #selector(self.nextButtonTapped), for: .touchUpInside)
        nextButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(CGFloat.nextButtonLeadingAnchor)
            make.bottom.equalToSuperview().inset(CGFloat.nextButtonBottomAnchor)
            make.height.equalTo(CGFloat.nextButtonHeightAnchor)
        }
    }
    
    @objc func unselectedTapped(sender: UIBarButtonItem) {
        unselectedSet()
    }
    
    func unselectedSet() {
        guard let indexPath = self.indexPath else { return }
        wallpapers[indexPath].deselectImage()
        isSelected = false
        nextButton.isHidden = true
        configureNavBar()
    }

    @objc func backToInitial(sender: UIBarButtonItem) {
        navigationController?.popToViewController(ofClass: SelectionRuneVC.self, animated: true)
    }
    
    func setupWallpapers() {
        
        for (index, wallpaper) in imagesWithBackground.enumerated() {
            let wallpaperCell = self.selectWallpaperView.dequeueReusableCell(withReuseIdentifier: cellId,
                                                                             for: IndexPath(row: index, section: 1)) as! WallpaperWithBackgroundCell
            wallpaperCell.setup(image: wallpaper)
            wallpapers.append(wallpaperCell)
        }
    }

    private func getPageNumber(by position: CGFloat) -> Int {
        switch Int(position) {
        case 0..<235:
            return 0
        case 235..<446:
            return 1
        case 446..<661:
            return 2
        default:
            return Int(position / 123.25)
        }
    }
    
    @objc func nextButtonTapped() {
        let wallpaperVC = ChoosedWallpaperVC()
        wallpaperVC.selectedImage = selectedImage
        self.navigationController?.pushViewController(wallpaperVC, animated: true)
    }
    
    private func downloadingWallpapers() {
        guard let emptyWallpaperUrl = emptyWallpaperUrl else { return }
        let wallpapersURL = emptyWallpaperUrl.replacingOccurrences(of: "empty-wallpapers", with: "wallpapers")
        let wallpapersURLblackHorizontal = wallpapersURL + String(".png?style=blackHorizontal&width=720&height=1280")
        let wallpapersURLdarkVertical = wallpapersURL + String(".png?style=darkVertical&width=720&height=1280")
        let wallpapersURLwpForest = wallpapersURL + String(".png?style=wpForest&width=720&height=1280")
        let wallpapersURLwpBark = wallpapersURL + String(".png?style=wpBark&width=720&height=1280")

        var choosedWallpapersWithBlackHorizontal: UIImage?
        var choosedWallpapersWithDarkVertical: UIImage?
        var choosedWallpapersWithWpForest: UIImage?
        var choosedWallpapersWithWpBark: UIImage?

        choosedWallpapersWithBlackHorizontal = UIImage.create(fromUrl: wallpapersURLblackHorizontal)
        choosedWallpapersWithDarkVertical = UIImage.create(fromUrl: wallpapersURLdarkVertical)
        choosedWallpapersWithWpForest = UIImage.create(fromUrl: wallpapersURLwpForest)
        choosedWallpapersWithWpBark = UIImage.create(fromUrl: wallpapersURLwpBark)
        
        ImageFileManager.shared.writeImageToFile(image: choosedWallpapersWithBlackHorizontal,
                                                 fileName: Images.choosedWallpapersWithBlackHorizontal.rawValue)
        ImageFileManager.shared.writeImageToFile(image: choosedWallpapersWithDarkVertical,
                                                 fileName: Images.choosedWallpapersWithDarkVertical.rawValue)
        ImageFileManager.shared.writeImageToFile(image: choosedWallpapersWithWpForest,
                                                 fileName: Images.choosedWallpapersWithWpForest.rawValue)
        ImageFileManager.shared.writeImageToFile(image: choosedWallpapersWithWpBark,
                                                 fileName: Images.choosedWallpapersWithWpBark.rawValue)
    }
}

extension WallpaperWithBackgroundVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return wallpapers[indexPath.row]
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        wallpapers[indexPath.row].selectImage()
        self.indexPath = indexPath.row
        nextButton.isHidden = false
        selectedImage = wallpapers[indexPath.row].wallpaperImage.image
        isSelected = true
        configureNavBar()
    }
    
    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        wallpapers[indexPath.row].deselectImage()
        nextButton.isHidden = true
    }
            
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.pageControl.currentPage = getPageNumber(by: scrollView.contentOffset.x)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: selectWallpaperView.bounds.width * 0.8, height: selectWallpaperView.bounds.height - 30)
    }
}

private extension URL {
    static func resize(url: String, width: Int, height: Int) -> String {
        let urlOptions = url.split(separator: "&")
        
        return "\(urlOptions.first!)&width=\(width)&height=\(height)"
    }
}
