//
//  SelectWallpaperViewController.swift
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

public class SelectWallpaperStyleViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    let cellId = "wallpaperCellId"
    
    var wallpapers: [SelectWallpaperStyleCell] = []
    var wallpapersUrls: [String] = []
    var wallpapersImages: [UIImage] = []
    var isProcessFinished: Bool = false
    var isImagesCreated: Bool = false
    var selectedRunesIds: [String] = []
    var selectedWallpaperName: String!
    
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
        
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        RunarLayout.initBackground(for: view, with: .mainFire)
        title = .wallpapersHeader
                
        setupBindings()
        setupViews()
        setupWallpapers()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.isProcessFinished = false
        self.isImagesCreated = false
    }
    
    private func setupBindings() {
        self.selectWallpaperView.delegate = self
        self.selectWallpaperView.dataSource = self
        self.selectWallpaperView.register(SelectWallpaperStyleCell.self, forCellWithReuseIdentifier: cellId)
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
        for (index, wallpaper) in MemoryStorage.GenerationWallpapertsStyles.enumerated() {
            let wallpaperCell = self.selectWallpaperView.dequeueReusableCell(withReuseIdentifier: cellId, for: IndexPath(row: index, section: 1)) as! SelectWallpaperStyleCell
            
            wallpaperCell.setup(name: wallpaper.name, image: UIImage.create(fromUrl: wallpaper.imageUrl))
            
            self.wallpapers.append(wallpaperCell)
        }
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return self.wallpapers[indexPath.row]
    }
       
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.wallpapers[indexPath.row].selectImage()
        self.selectedWallpaperName = self.wallpapers[indexPath.row].wallpaperName
        self.nextButton.isHidden = false
        self.wallpapersUrls = []
        self.wallpapersImages = []
    }
    
    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        self.wallpapers[indexPath.row].deselectImage()
        self.nextButton.isHidden = true
    }
            
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.pageControl.currentPage = getPageNumber(by: scrollView.contentOffset.x)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: selectWallpaperView.bounds.width * 0.7, height: selectWallpaperView.bounds.height)
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
        
    }
}
    
//    @IBAction func nextOnTap() {
//        let viewModel = ProcessingViewModel(name: .progressName, title: .progressTitle) { [weak self] in
//            self?.isProcessFinished = true
//            if (self?.navigationController?.topViewController is ProcessingViewController) {
//                if (!self!.wallpapersImages.isEmpty) {
//                    self?.goToSelectWallpapers()
//                } else if(self!.isImagesCreated){
//                    self!.navigationController?.popViewController(animated: false)
//                }
//            }
//        }
//
//        let data = RunarApi.getWallpapersData(runsIds: self.selectedRunesIds, style: self.selectedWallpaperName)
//        guard let _wallpapersUrls = try? JSONDecoder().decode([String].self, from: data!) else {
//            fatalError("Runes is empty")
//        }
//
//        self.wallpapersUrls = _wallpapersUrls
//
//        let processCV = ProcessingViewController()
//        processCV.viewModel = viewModel
//        processCV.hidesBottomBarWhenPushed = true
//        processCV.navigationController?.navigationBar.configure()
//        processCV.container.isHidden = false
//
//        let duration = Int(Double(_wallpapersUrls.count) * 0.65)
//        if (duration > 15) {
//            processCV.changeAnimationDuration(duration: duration)
//        }
//
//        self.navigationController?.pushViewController(processCV, animated: true)
//
//        if (self.wallpapersImages.isEmpty) {
//            self.isImagesCreated = self.wallpapersUrls.count == 0
//            if (!self.isImagesCreated) {
//                DispatchQueue.bacground(task: {
//                    return _wallpapersUrls.map({ (url) -> UIImage in
//                        return UIImage.create(fromUrl: url)!
//                    })
//                }, withCompletion: { (images) in
//                    self.wallpapersImages = images!
//                    self.isImagesCreated = true
//
//                    if (self.isProcessFinished) {
//                        self.goToSelectWallpapers()
//                    }
//                })
//            }
//        }
//    }
    
//    func goToSelectWallpapers() -> Void {
//        self.navigationController?.popViewController(animated: false)
//        let selectWallpapersController = SelectWallpapersViewController()
//
//        selectWallpapersController.wallpapersUrls = self.wallpapersUrls
//        selectWallpapersController.wallpaperImages = self.wallpapersImages
//
//        self.navigationController?.pushViewController(selectWallpapersController, animated: false)
//    }

//private extension UINavigationBar {
//    func configure() -> Void {
//        self.isTranslucent = false
//        self.prefersLargeTitles = false
//        self.tintColor = .libraryTitleColor
//        self.backgroundColor = .navBarBackground
//        self.barTintColor = .navBarBackground
//        self.titleTextAttributes = [NSAttributedString.Key.font: FontFamily.SFProDisplay.regular.font(size: 20),
//                                         NSAttributedString.Key.foregroundColor: UIColor.white]
//        self.backItem?.backButtonTitle = .back
//    }
//}

//extension DispatchQueue {
//    static func bacground(task action: @escaping ()-> [UIImage]?, withCompletion completion: (([UIImage]?)-> Void)? = nil){
//        DispatchQueue.global(qos: .background).async {
//            let data = action()
//            if let completion = completion {
//                DispatchQueue.main.asyncAfter(deadline: .now()) {
//                    completion(data)
//                }
//            }
//        }
//    }
//}
