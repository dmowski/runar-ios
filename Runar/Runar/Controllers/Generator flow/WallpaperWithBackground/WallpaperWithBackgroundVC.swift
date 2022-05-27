//
//  WallpaperWithBackgroundVC.swift
//  Runar
//
//  Created by Maksim Harbatsevich on 10/23/21.
//

import UIKit
import SnapKit

extension String {
    
    static let wallpapersHeader = L10n.Generator.WallpapersHeader.title
    static let wallpapersDescription = L10n.Generator.WallpapersDescription.subtitle
    static let progressName = L10n.Generator.Progress.name
    static let progressTitle = L10n.Generator.Progress.title
}

public class WallpaperWithBackgroundVC: UIViewController {

    let cellId = "wallpaperCellId"
    
    var wallpapers: [WallpaperWithBackgroundCell] = []
    var imagesWithBackground: [UIImage?]
    var selectedImage: UIImage?
    
    let subTitle: UILabel = {
        let title = UILabel()
        title.textColor = UIColor(red: 0.973, green: 0.973, blue: 0.973, alpha: 1)
        title.textAlignment = .center
        title.numberOfLines = 0
        title.lineBreakMode = .byWordWrapping
        title.text = .wallpapersDescription
        title.font = FontFamily.SFProDisplay.regular.font(size: 16)
        title.backgroundColor = .clear
        return title
    }()
    
    let selectWallpaperView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .horizontal
        
        let selectWallpaperView = UICollectionView(frame: .zero, collectionViewLayout: layout)
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
        nextButton.layer.backgroundColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1).cgColor
        nextButton.layer.cornerRadius = 5
        nextButton.isHidden = true
        nextButton.setTitle(title: .nextButtonTitle, color: UIColor(red: 0.165, green: 0.165, blue: 0.165, alpha: 1))
        return nextButton
    }()
    
    init(imagesWithBackground: [UIImage?]) {
        self.imagesWithBackground = imagesWithBackground
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    public override func viewDidLoad() {
        super.viewDidLoad()        
        RunarLayout.initBackground(for: view, with: .mainFire)

        setupBindings()
        setupViews()
        configureNavBar()
        setupWallpapers()
    }
    
    private func configureNavBar() {
        title = .wallpapersHeader
        self.navigationItem.hidesBackButton = true
        let customBackButton = UIBarButtonItem(image: Assets.backIcon.image,
                                               style: .plain, target: self,
                                               action: #selector(self.backToInitial))
        customBackButton.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        navigationItem.leftBarButtonItem = customBackButton
    }

    @objc func backToInitial(sender: UIBarButtonItem) {
        navigationController?.popToViewController(ofClass: SelectionRuneVC.self, animated: true)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    private func setupBindings() {
        self.selectWallpaperView.delegate = self
        self.selectWallpaperView.dataSource = self
        self.selectWallpaperView.register(WallpaperWithBackgroundCell.self, forCellWithReuseIdentifier: cellId)
    }

    private func setupViews() {
        self.view.addSubview(subTitle)
        subTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.equalToSuperview().offset(60)
            make.trailing.equalToSuperview().offset(-60)
        }

        self.view.addSubview(selectWallpaperView)
        selectWallpaperView.snp.makeConstraints { make in
            make.top.equalTo(subTitle.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-144)
        }

        self.view.addSubview(pageControl)
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(selectWallpaperView.snp.bottom).offset(20)
            make.height.equalTo(20)
        }

        self.view.addSubview(nextButton)
        nextButton.addTarget(self, action: #selector(self.nextButtonTapped), for: .touchUpInside)
        nextButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-40)
            make.height.equalTo(50)
        }
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
        case 0..<35:
            return 0
        case 35..<246:
            return 1
        case 246..<461:
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
        nextButton.isHidden = false
        selectedImage = wallpapers[indexPath.row].wallpaperImage.image
    }
    
    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        wallpapers[indexPath.row].deselectImage()
        nextButton.isHidden = true
    }
            
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.pageControl.currentPage = getPageNumber(by: scrollView.contentOffset.x)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: selectWallpaperView.bounds.width * 0.8, height: selectWallpaperView.bounds.height)
    }
}

private extension URL {
    static func resize(url: String, width: Int, height: Int) -> String {
        let urlOptions = url.split(separator: "&")
        
        return "\(urlOptions.first!)&width=\(width)&height=\(height)"
    }
}
