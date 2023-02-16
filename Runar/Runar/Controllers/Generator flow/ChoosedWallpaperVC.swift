//
//  ChoosedWallpaperVC.swift
//  Runar
//
//  Created by Maksim Harbatsevich on 11/7/21.
//

import UIKit
import LinkPresentation
import SnapKit

//MARK: Constants
extension String {

    static let selectWallpaperTitle = L10n.Generator.SelectWallpaperHeader.title
    static let shareWallpaperTitle = L10n.Generator.ShareWallpaperHeader.title
    static let downloadAlertTitleSuccess = L10n.Generator.AlertHeaderSuccess.title
    static let downloadAlertActionTitleSuccess = L10n.Generator.AlertActionSuccess.title
    static let downloadAlertTitleError = L10n.Generator.AlertHeaderError.title
    static let downloadAlertActionTitleError = L10n.Generator.AlertActionError.title
}

//MARK: Add to color common class
private extension UIColor {
    static let wallpaperImageBorderColor = UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36)
}

//MARK: Constants
private extension CGFloat {
    static let wallpaperImageTopAnchor = 129
    static let wallpaperImageLeadingAncor = 60
    static let wallpaperImageBottomAnchor = 164
    
    static let downloadButtonLeadingAnchor = 60
    static let downloadButtonTopAnchor = 40
    static let downloadButtonHeightAnchor = 50
    
    static let shareButtonLeadingAnchor = 16
    static let shareButtonTopAnchor = 40
    static let shareButtonHeightAnchor = 50
}

public class ChoosedWallpaperVC : UIViewController, UIActivityItemSource {
    
    var selectedImage: UIImage!
    
    let wallpaperImage: UIImageView = {
        let wallpaperImage = UIImageView()
        wallpaperImage.clipsToBounds = true
        wallpaperImage.contentMode = .scaleAspectFill
        wallpaperImage.layer.cornerRadius = 16
        wallpaperImage.layer.borderWidth = 1
        wallpaperImage.layer.borderColor = UIColor.wallpaperImageBorderColor.cgColor
        return wallpaperImage
    }()
    
    let shareButton: UIButton = {
        let shareButton = UIButton()
        shareButton.layer.backgroundColor = UIColor.yellowPrimaryColor.cgColor
        shareButton.layer.cornerRadius = 5
        shareButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        shareButton.tintColor = .primaryDarkItemColor
        return shareButton
    }()
    
    let downloadButton: UIButton = {
        let downloadButton = UIButton()
        downloadButton.layer.backgroundColor = UIColor.yellowPrimaryColor.cgColor
        downloadButton.layer.cornerRadius = 5
        downloadButton.setImage(UIImage(systemName: "square.and.arrow.down"), for: .normal)
        downloadButton.tintColor = .primaryDarkItemColor
        return downloadButton
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        RunarLayout.initBackground(for: view, with: .mainFire)
        wallpaperImage.image = self.selectedImage

        setupViews()
        configureNavBar()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    private func configureNavBar() {
        navigationItem.setNavigationTitle(.selectWallpaperTitle)
        navigationItem.hidesBackButton = true
        let customBackButton = UIBarButtonItem(image: Assets.backIcon.image,
                                               style: .plain, target: self,
                                               action: #selector(self.backToInitial))
        customBackButton.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        navigationItem.leftBarButtonItem = customBackButton
    }

    @objc func backToInitial(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupViews() {
        
        self.view.addSubview(wallpaperImage)
        wallpaperImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(CGFloat.wallpaperImageTopAnchor)
            make.leading.equalToSuperview().offset(CGFloat.wallpaperImageLeadingAncor)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(CGFloat.wallpaperImageBottomAnchor)
        }
        
        self.view.addSubview(downloadButton)
        downloadButton.addTarget(self, action: #selector(self.downloadOnTap), for: .touchUpInside)
        downloadButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(CGFloat.downloadButtonLeadingAnchor)
            make.top.equalTo(wallpaperImage.snp.bottom).offset(CGFloat.downloadButtonTopAnchor)
            make.height.width.equalTo(CGFloat.downloadButtonHeightAnchor)
        }
        
        self.view.addSubview(shareButton)
        shareButton.addTarget(self, action: #selector(self.shareOnTap), for: .touchUpInside)
        shareButton.snp.makeConstraints { make in
            make.leading.equalTo(downloadButton.snp.trailing).offset(CGFloat.shareButtonLeadingAnchor)
            make.top.equalTo(wallpaperImage.snp.bottom).offset(CGFloat.shareButtonTopAnchor)
            make.height.width.equalTo(CGFloat.shareButtonHeightAnchor)
        }
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
    
    @objc func shareOnTap() {

        let activityVC = UIActivityViewController(activityItems: [self], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
    
    @objc func downloadOnTap() {

        UIImageWriteToSavedPhotosAlbum(self.selectedImage, self, #selector(self.imageDownloaded), nil)
    }
    
    @objc func imageDownloaded(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {

        if let _ = error {
            let alertController = UIAlertController(title: .downloadAlertTitleError, message: nil, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: .downloadAlertActionTitleError, style: .default))
            present(alertController, animated: true)
        } else {
            let alertController = UIAlertController(title: .downloadAlertTitleSuccess, message: nil, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: .downloadAlertActionTitleSuccess, style: .default))
            present(alertController, animated: true)
        }
    }
}
