//
//  SelectWallpapersViewController.swift
//  Runar
//
//  Created by Maksim Harbatsevich on 10/29/21.
//

import UIKit

extension String {
    static let selectWallpapersTitile = L10n.Generator.SelectWallpapersHeader.titile
}

public class SelectWallpapersViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    let cellId = "wallpaperCellId"
    
    var wallpapers: [SelectWallpaperCell] = []
    var wallpapersUrls: [String] = []
    var wallpaperImages: [UIImage] = []
    var selectedIndex: Int!
    var selectedImage: UIImage!
        
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        RunarLayout.initBackground(for: view, with: .mainFire)
        
        self.selectWallpaperView.delegate = self
        self.selectWallpaperView.dataSource = self
        self.selectWallpaperView.allowsMultipleSelection = false
        self.selectWallpaperView.isPagingEnabled = false
        self.selectWallpaperView.isScrollEnabled = true
        self.selectWallpaperView.showsVerticalScrollIndicator = false
        
        self.selectWallpaperView.register(SelectWallpaperCell.self, forCellWithReuseIdentifier: cellId)
        
        setupViews()
        setupWallpapers()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        configureNavigationBar()
    }
        
    let selectWallpaperView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: 165, height: 290)
        layout.minimumLineSpacing = 12
        layout.scrollDirection = .vertical
        
        let selectWallpaperView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        selectWallpaperView.backgroundColor = .clear
        
        return selectWallpaperView
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
        title = .selectWallpapersTitile
        self.navigationController?.navigationBar.configure()
    }
    
    private func setupViews() {
        self.view.addSubview(selectWallpaperView)
        
        selectWallpaperView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            selectWallpaperView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            selectWallpaperView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            selectWallpaperView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            selectWallpaperView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
        ])
        
        self.view.addSubview(nextButton)
        
        nextButton.addTarget(self, action: #selector(self.nextOnTap), for: .touchUpInside)

        nextButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            nextButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            nextButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        ])
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.wallpapers.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return self.wallpapers[indexPath.row]
    }
       
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.wallpapers[indexPath.row].selectImage()
        self.nextButton.isHidden = false
        self.selectedIndex = indexPath.row
    }
    
    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        self.wallpapers[indexPath.row].deselectImage()
        self.nextButton.isHidden = true
    }
    
    func setupWallpapers(){
        for index in 0..<self.wallpaperImages.count {
            let wallpaperCell = self.selectWallpaperView.dequeueReusableCell(withReuseIdentifier: cellId, for: IndexPath(row: index, section: 1)) as! SelectWallpaperCell
            
            wallpaperCell.setupWallpaper(id: index, image: self.wallpaperImages[index])
            
            self.wallpapers.append(wallpaperCell)
        }
    }
    
    @IBAction func nextOnTap() {
        let url = URL.resize(url: self.wallpapersUrls[self.selectedIndex], width: 720, height: 1280)
        
        let wallpaperVC = WallpaperViewController()
        
        wallpaperVC.selectedImage = UIImage.create(fromUrl: url)
        
        self.navigationController?.pushViewController(wallpaperVC, animated: false)
    }
}

class SelectWallpaperCell: UICollectionViewCell {
    public var wallpaperId: Int!
    
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
    
    func setupViews(){
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
    
    func setupWallpaper(id: Int, image: UIImage?){
        self.wallpaperId = id
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

private extension URL {
    static func resize(url: String, width: Int, height: Int) -> String {
        let urlOptions = url.split(separator: "&")
        
        return "\(urlOptions.first!)&width=\(width)&height=\(height)"
    }
}
