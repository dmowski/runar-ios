//
//  SelectWallpaperViewController.swift
//  Runar
//
//  Created by Maksim Harbatsevich on 10/23/21.
//

import UIKit

extension String {
    
    static let wallpapersHeader = L10n.Generator.WallpapersHeader.title
    //static let nextButtonTitle = L10n.Generator.NextButton.title
    static let progressName = L10n.Generator.Progress.name
    static let progressTitle = L10n.Generator.Progress.title
}

public class SelectWallpaperStyleViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {   
    let cellId = "wallpaperCellId"
    
    var wallpapers: [SelectWallpaperSyleCell] = []
    var wallpapersUrls: [String] = []
    var wallpapersImages: [UIImage] = []
    var isProcessFinished: Bool = false
    var isImagesCreated: Bool = false
    var selectedRunesIds: [String] = []
    var selectedWallpaperName: String!
        
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        RunarLayout.initBackground(for: view, with: .mainFire)
        
        self.selectWallpaperView.delegate = self
        self.selectWallpaperView.dataSource = self
        self.selectWallpaperView.allowsMultipleSelection = false
        self.selectWallpaperView.isPagingEnabled = false
        self.selectWallpaperView.isScrollEnabled = true
        self.selectWallpaperView.showsHorizontalScrollIndicator = false
        self.selectWallpaperView.register(SelectWallpaperSyleCell.self, forCellWithReuseIdentifier: cellId)
        
        pageControl.numberOfPages = 4
        pageControl.currentPage = 0

        setupViews()
        setupWallpapers()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.isProcessFinished = false
        self.isImagesCreated = false
        
        configureNavigationBar()
    }
    
    let header: UILabel = {
        let title = UILabel(frame: CGRect(x: 0, y: 0, width: 252, height: 44))
        
        title.textColor = UIColor(red: 0.973, green: 0.973, blue: 0.973, alpha: 1)
        title.textAlignment = .center
        title.numberOfLines = 0
        title.lineBreakMode = .byWordWrapping
        title.text = .wallpapersHeader
        title.font = FontFamily.SFProDisplay.regular.font(size: 17)
        title.backgroundColor = .clear
        
        return title
    }()
    
    let selectWallpaperView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: 197, height: 400)
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .horizontal
        
        let selectWallpaperView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        selectWallpaperView.backgroundColor = .clear
        
        return selectWallpaperView
    }()
    
    let pageControl: UIPageControl = {
        let page = UIPageControl()
        
        page.backgroundColor = .clear
        
        return page
    }()
    
    let nextButton: UIButton = {
        let nextButton = UIButton()
        
        nextButton.layer.backgroundColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1).cgColor
        nextButton.layer.cornerRadius = 10
        nextButton.isHidden = true
        nextButton.setTitle(title: .nextButtonTitle, color: UIColor(red: 0.165, green: 0.165, blue: 0.165, alpha: 1))
        
        return nextButton
    }()
    
    private func configureNavigationBar() {
        title = .wallpapersTitele
        self.navigationController?.navigationBar.configure()
    }
    
    private func setupViews() {
        self.view.addSubview(header)
        
        header.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            header.heightAnchor.constraint(equalToConstant: 50),
            header.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32),
            header.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
                
        self.view.addSubview(selectWallpaperView)
        
        selectWallpaperView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            selectWallpaperView.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 16),
            selectWallpaperView.heightAnchor.constraint(equalToConstant: 402),
            selectWallpaperView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32),
            selectWallpaperView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            selectWallpaperView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)
        ])
        
        self.view.addSubview(pageControl)
                
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.topAnchor.constraint(equalTo: selectWallpaperView.bottomAnchor, constant: 20),
            pageControl.heightAnchor.constraint(equalToConstant: 20),
            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
                
        self.view.addSubview(nextButton)
        
        nextButton.addTarget(self, action: #selector(self.nextOnTap), for: .touchUpInside)

        nextButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextButton.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 10),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            nextButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            nextButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        ])
    }
    
    func setupWallpapers() {
        for (index, wallpaper) in MemoryStorage.GenerationWallpapertsStyles.enumerated() {
            let wallpaperCell = self.selectWallpaperView.dequeueReusableCell(withReuseIdentifier: cellId, for: IndexPath(row: index, section: 1)) as! SelectWallpaperSyleCell
            
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
    
    @IBAction func nextOnTap() {
        let viewModel = ProcessingViewModel(name: .progressName, title: .progressTitle) { [weak self] in
            self?.isProcessFinished = true
            if (self?.navigationController?.topViewController is ProcessingViewController) {
                if (!self!.wallpapersImages.isEmpty) {
                    self?.goToSelectWallpapers()
                } else if(self!.isImagesCreated){
                    self!.navigationController?.popViewController(animated: false)
                }
            }
        }
        
        let data = RunarApi.getWallpapersData(runsIds: self.selectedRunesIds, style: self.selectedWallpaperName)
        guard let _wallpapersUrls = try? JSONDecoder().decode([String].self, from: data!) else {
            fatalError("Runes is empty")
        }
        
        self.wallpapersUrls = _wallpapersUrls
        
        let processCV = ProcessingViewController()
        processCV.viewModel = viewModel
        processCV.hidesBottomBarWhenPushed = true
        processCV.navigationController?.navigationBar.configure()
        processCV.container.isHidden = false
        
        let duration = Int(Double(_wallpapersUrls.count) * 0.65)
        if (duration > 15) {
            processCV.changeAnimationDuration(duration: duration)
        }
        
        self.navigationController?.pushViewController(processCV, animated: true)
        
        if (self.wallpapersImages.isEmpty) {
            self.isImagesCreated = self.wallpapersUrls.count == 0
            if (!self.isImagesCreated) {
                DispatchQueue.bacground(task: {
                    return _wallpapersUrls.map({ (url) -> UIImage in
                        return UIImage.create(fromUrl: url)!
                    })
                }, withCompletion: { (images) in
                    self.wallpapersImages = images!
                    self.isImagesCreated = true
                    
                    if (self.isProcessFinished) {
                        self.goToSelectWallpapers()
                    }
                })
            }
        }
    }
    
    func goToSelectWallpapers() -> Void {
        self.navigationController?.popViewController(animated: false)
        let selectWallpapersController = SelectWallpapersViewController()
        
        selectWallpapersController.wallpapersUrls = self.wallpapersUrls
        selectWallpapersController.wallpaperImages = self.wallpapersImages
        
        self.navigationController?.pushViewController(selectWallpapersController, animated: false)
    }
}

class SelectWallpaperSyleCell: UICollectionViewCell {
    public var wallpaperName: String!
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        layer.borderWidth = 1
        layer.borderColor = UIColor(red: 0.161, green: 0.161, blue: 0.161, alpha: 1).cgColor
        layer.cornerRadius = 8
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let selectedCheckbox: UIImageView = {
        let check = UIImageView(image: Assets.selectedCircle.image)
        
        check.contentMode = .scaleAspectFit
        check.isHidden = true
        
        return check
    }()
    
    let wallpaperImage: UIImageView = {
        let wallpaperImage = UIImageView()
        
        wallpaperImage.contentMode = .scaleAspectFill
        wallpaperImage.layer.cornerRadius = 8
        wallpaperImage.clipsToBounds = true
        
        return wallpaperImage
    }()
    
    func setupViews() {
        self.addSubview(wallpaperImage)
        
        self.wallpaperImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            wallpaperImage.topAnchor.constraint(equalTo: self.topAnchor),
            wallpaperImage.rightAnchor.constraint(equalTo: self.rightAnchor),
            wallpaperImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            wallpaperImage.leftAnchor.constraint(equalTo: self.leftAnchor)
        ])
        
        self.addSubview(selectedCheckbox)
        
        self.selectedCheckbox.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            selectedCheckbox.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            selectedCheckbox.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            selectedCheckbox.heightAnchor.constraint(equalToConstant: 22),
            selectedCheckbox.widthAnchor.constraint(equalToConstant: 22)
        ])
    }
    
    func selectImage(){
        layer.borderColor = UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1).cgColor
        selectedCheckbox.isHidden = false
    }
    
    func deselectImage(){
        layer.borderColor = UIColor(red: 0.161, green: 0.161, blue: 0.161, alpha: 1).cgColor
        selectedCheckbox.isHidden = true
    }
    
    func setup(name: String, image: UIImage?){
        self.wallpaperName = name
        self.wallpaperImage.image = image
    }
}

private extension UINavigationBar {
    func configure() -> Void {
        self.isTranslucent = false
        self.prefersLargeTitles = false
        self.tintColor = .libraryTitleColor
        self.backgroundColor = .navBarBackground
        self.barTintColor = .navBarBackground
        self.titleTextAttributes = [NSAttributedString.Key.font: FontFamily.SFProDisplay.regular.font(size: 17),
                                         NSAttributedString.Key.foregroundColor: UIColor.white]
        
        self.backItem?.backButtonTitle = .back
    }
}

extension DispatchQueue {
    static func bacground(task action: @escaping ()-> [UIImage]?, withCompletion completion: (([UIImage]?)-> Void)? = nil){
        DispatchQueue.global(qos: .background).async {
            let data = action()
            if let completion = completion {
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    completion(data)
                }
            }
        }
    }
}
