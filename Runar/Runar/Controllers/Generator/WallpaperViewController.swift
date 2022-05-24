//
//  WallpaperViewController.swift
//  Runar
//
//  Created by Maksim Harbatsevich on 11/7/21.
//

import UIKit
import LinkPresentation

extension String {
    static let selectWallpaperTitile = L10n.Generator.SelectWallpaperHeader.titile
    static let shareWallpaperTitle = L10n.Generator.ShareWallpaperHeader.titile
    static let downloadAlertTitle = L10n.Generator.AlertHeader.titile
    static let downloadAlertActionTitile = L10n.Generator.AlertAction.titile
}

public class WallpaperViewController : UIViewController, UIActivityItemSource {
    
    var selectedImage: UIImage!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        RunarLayout.initBackground(for: view, with: .mainFire)
        
        setupViews()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
    
        configureNavigationBar()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    let wallpaperImage: UIImageView = {
        let wallpaperImage = UIImageView()
        
        wallpaperImage.contentMode = .scaleAspectFill
        wallpaperImage.layer.cornerRadius = 16
        wallpaperImage.clipsToBounds = true
        wallpaperImage.layer.borderWidth = 1
        wallpaperImage.layer.borderColor = UIColor(red: 0.824, green: 0.769, blue: 0.678, alpha: 0.6).cgColor
        
        return wallpaperImage
    }()
    
    let background: UIView = {
        let background = UIView()
        
        background.layer.backgroundColor = UIColor(red: 0.078, green: 0.078, blue: 0.078, alpha: 1).cgColor
        background.layer.cornerRadius = 5
        
        return background
    }()
    
    let downloadButton: UIButton = {
        let downloadButton = UIButton()
        
        downloadButton.layer.backgroundColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1).cgColor
        downloadButton.layer.cornerRadius = 5
        downloadButton.setImage(UIImage(systemName: "square.and.arrow.down"), for: .normal)
        downloadButton.tintColor = UIColor(red: 0.161, green: 0.161, blue: 0.161, alpha: 1)
        
        return downloadButton
    }()
    
    let shareButton: UIButton = {
        let shareButton = UIButton()
        
        shareButton.layer.backgroundColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1).cgColor
        shareButton.layer.cornerRadius = 5
        shareButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        shareButton.tintColor = UIColor(red: 0.161, green: 0.161, blue: 0.161, alpha: 1)
        
        return shareButton
    }()
        
    private func configureNavigationBar() {
        title = .selectWallpaperTitile
        self.navigationController?.navigationBar.configure()
    }
    
    private func setupViews() {
        self.view.addSubview(background)
        
        background.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: view.topAnchor, constant: 32),
            background.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            background.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            background.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
        ])
        
        self.view.addSubview(wallpaperImage)
        wallpaperImage.image = self.selectedImage
        
        wallpaperImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            wallpaperImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            wallpaperImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            wallpaperImage.widthAnchor.constraint(equalToConstant: 260),
            wallpaperImage.heightAnchor.constraint(equalToConstant: 565)
        ])
        
        self.view.addSubview(downloadButton)
        downloadButton.addTarget(self, action: #selector(self.downloadOnTap), for: .touchUpInside)
        
        downloadButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            downloadButton.leftAnchor.constraint(equalTo: wallpaperImage.leftAnchor),
            downloadButton.topAnchor.constraint(equalTo: wallpaperImage.bottomAnchor, constant: 32),
            downloadButton.widthAnchor.constraint(equalToConstant: 50),
            downloadButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        self.view.addSubview(shareButton)
        shareButton.addTarget(self, action: #selector(self.shareOnTap), for: .touchUpInside)
        
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shareButton.leftAnchor.constraint(equalTo: downloadButton.rightAnchor, constant: 16),
            shareButton.topAnchor.constraint(equalTo: wallpaperImage.bottomAnchor, constant: 32),
            shareButton.widthAnchor.constraint(equalToConstant: 50),
            shareButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    public func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return UIImage()
    }
    
    public func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        return self.selectedImage
    }
    
    public func activityViewController(_ activityViewController: UIActivityViewController, thumbnailImageForActivityType activityType: UIActivity.ActivityType?, suggestedSize size: CGSize) -> UIImage? {
        return self.selectedImage
    }
    
    public func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
        let metadata = LPLinkMetadata()
        
        metadata.title = .shareWallpaperTitle
        
        return metadata
    }
    
    @IBAction func shareOnTap() {
        let activityVC = UIActivityViewController(activityItems: [self], applicationActivities: nil)
    
        activityVC.popoverPresentationController?.sourceView = self.view
        
        self.present(activityVC, animated: true, completion: nil)
    }
    
    @IBAction func downloadOnTap() {
        UIImageWriteToSavedPhotosAlbum(self.selectedImage, self, #selector(self.imageDownloaded), nil)
    }
    
    @objc func imageDownloaded(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer){
        let alert = UIAlertController(title: .downloadAlertTitle, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: .downloadAlertActionTitile, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
