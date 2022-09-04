//
//  ChoosedWallpaperVC.swift
//  Runar
//
//  Created by Maksim Harbatsevich on 11/7/21.
//

import UIKit
import LinkPresentation
import SnapKit

extension String {

    static let selectWallpaperTitile = L10n.Generator.SelectWallpaperHeader.title
    static let shareWallpaperTitle = L10n.Generator.ShareWallpaperHeader.title
    static let downloadAlertTitle = L10n.Generator.AlertHeader.title
    static let downloadAlertActionTitile = L10n.Generator.AlertAction.title
}

public class ChoosedWallpaperVC : UIViewController, UIActivityItemSource {
    
    var selectedImage: UIImage!
    
    let wallpaperImage: UIImageView = {
        let wallpaperImage = UIImageView()
        wallpaperImage.clipsToBounds = true
        wallpaperImage.contentMode = .scaleAspectFill
        wallpaperImage.layer.cornerRadius = 16
        wallpaperImage.layer.borderWidth = 1
        wallpaperImage.layer.borderColor = UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36).cgColor
        return wallpaperImage
    }()
    
    let shareButton: UIButton = {
        let shareButton = UIButton()
        shareButton.layer.backgroundColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1).cgColor
        shareButton.layer.cornerRadius = 5
        shareButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        shareButton.tintColor = UIColor(red: 0.161, green: 0.161, blue: 0.161, alpha: 1)
        return shareButton
    }()
    
    let downloadButton: UIButton = {
        let downloadButton = UIButton()
        downloadButton.layer.backgroundColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1).cgColor
        downloadButton.layer.cornerRadius = 5
        downloadButton.setImage(UIImage(systemName: "square.and.arrow.down"), for: .normal)
        downloadButton.tintColor = UIColor(red: 0.161, green: 0.161, blue: 0.161, alpha: 1)
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
        title = .selectWallpaperTitile
        self.navigationItem.hidesBackButton = true
        let customBackButton = UIBarButtonItem(image: Assets.backIcon.image,
                                               style: .plain, target: self,
                                               action: #selector(self.backToInitial))
        customBackButton.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        navigationItem.leftBarButtonItem = customBackButton
    }

    @objc func backToInitial(sender: UIBarButtonItem) {
        //navigationController?.popToViewController(ofClass: SelectionRuneVC.self, animated: true) // TODO: choose
        navigationController?.popViewController(animated: true)
    }
    
    private func setupViews() {
        
        self.view.addSubview(wallpaperImage)
        wallpaperImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
            make.bottom.equalToSuperview().offset(-110)
        }
        
        self.view.addSubview(downloadButton)
        downloadButton.addTarget(self, action: #selector(self.downloadOnTap), for: .touchUpInside)
        downloadButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(50)
            make.bottom.equalToSuperview().offset(-40)
            make.height.width.equalTo(50)
        }
        
        self.view.addSubview(shareButton)
        shareButton.addTarget(self, action: #selector(self.shareOnTap), for: .touchUpInside)
        shareButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(120)
            make.bottom.equalToSuperview().offset(-40)
            make.height.width.equalTo(50)
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

        let alert = UIAlertController(title: .downloadAlertTitle, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: .downloadAlertActionTitile, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
