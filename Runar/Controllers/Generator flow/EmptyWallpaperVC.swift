//
//  EmptyWallpaperVC.swift
//  Runar
//
//  Created by Георгий Ступаков on 2/21/22.
//

import UIKit
import SnapKit

extension String {
    static let newVariant = L10n.Generator.EmptyWallpapersNewVariant.btnTitle
    static let wallpapersTitele = L10n.Generator.Wallpapers.title
    static let emptyWallpapersSubTitele = L10n.Generator.EmptyWallpapers.subtitle
    static let nextButtonTitle = L10n.Generator.NextButton.title
}

public class EmptyWallpaperVC: UIViewController {
    
    private var emptyWallpapers = [EmptyWallpaper]()
    
    private var emptyWallpaperCurrentIndex = 0 {
        didSet {
            let emptyWallpaperName = emptyWallpapers[emptyWallpaperCurrentIndex].name
            imageView.image = ImageFileManager.shared.readImageFromFile(emptyWallpaperName)
        }
    }
    
    let mainTitle: UILabel = {
        let title = UILabel()
        title.textColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1)
        title.textAlignment = .center
        title.numberOfLines = 0
        title.lineBreakMode = .byWordWrapping
        title.text = .wallpapersTitele
        title.font = FontFamily.AmaticSC.bold.font(size: 55)
        title.backgroundColor = .clear
        return title
    }()
    
    let subTitle: UILabel = {
        let processingLabel = UILabel()
        processingLabel.textColor = UIColor(red: 0.973, green: 0.973, blue: 0.973, alpha: 1)
        processingLabel.textAlignment = .center
        processingLabel.numberOfLines = 0
        processingLabel.lineBreakMode = .byWordWrapping
        processingLabel.text = .emptyWallpapersSubTitele
        processingLabel.font = FontFamily.Roboto.regular.font(size: 16)
        return processingLabel
    }()
    
    let contentView: UIView = {
        let contentView = UIView()
        contentView.layer.backgroundColor = UIColor(red: 0.143, green: 0.142, blue: 0.143, alpha: 0.5).cgColor
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
        newVariantButton.layer.backgroundColor = UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36).cgColor
        newVariantButton.layer.cornerRadius = 8
        newVariantButton.layer.borderWidth = 1
        newVariantButton.contentHorizontalAlignment = .center
        newVariantButton.contentEdgeInsets = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        newVariantButton.layer.borderColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1).cgColor
        newVariantButton.setTitle(title: .newVariant)
        return newVariantButton
    }()
    
    let nextButton: UIButton = {
        let nextButton = UIButton()
        nextButton.layer.backgroundColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1).cgColor
        nextButton.layer.cornerRadius = 5
        nextButton.setTitle(title: .nextButtonTitle)
        nextButton.setTitle(title: .nextButtonTitle, color: UIColor(red: 0.165, green: 0.165, blue: 0.165, alpha: 1))
        nextButton.contentHorizontalAlignment = .center
        nextButton.contentEdgeInsets = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        return nextButton
    }()
    
    init(emptyWallpapers: [EmptyWallpaper]) {
        self.emptyWallpapers = emptyWallpapers
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        RunarLayout.initBackground(for: view, with: .mainFire)
        
        imageView.image = ImageFileManager.shared.readImageFromFile(emptyWallpapers[emptyWallpaperCurrentIndex].name)
        
        setupViews()
        setupImageViewSwipes()
        updateEmptyVC()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = false
    }
    
    private func setupViews() {
        view.addSubviews(mainTitle)
        mainTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview().offset(60)
            make.trailing.equalToSuperview().offset(-60)
        }
        
        view.addSubviews(subTitle)
        subTitle.snp.makeConstraints { make in
            make.top.equalTo(mainTitle.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
        }
        
        view.addSubviews(contentView)
        contentView.snp.makeConstraints { make in
            make.top.equalTo(subTitle.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        contentView.addSubviews(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.bottom.equalToSuperview().offset(-100)
        }
        
        contentView.addSubviews(newVariantButton)
        newVariantButton.addTarget(self, action: #selector(self.generateNewVariant), for: .touchUpInside)
        newVariantButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-32)
            make.leading.equalToSuperview().offset(90)
            make.trailing.equalToSuperview().offset(-90)
            make.height.equalTo(50)
        }
        
        view.addSubviews(nextButton)
        nextButton.addTarget(self, action: #selector(self.nextButtonTapped), for: .touchUpInside)
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-40)
            make.height.equalTo(50)
        }
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
        emptyWallpaperCurrentIndex = (0..<emptyWallpapers.count).randomElement() ?? 0
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
        if emptyWallpaperCurrentIndex == 0 {
            emptyWallpaperCurrentIndex = emptyWallpapers.count - 1
        } else {
            emptyWallpaperCurrentIndex -= 1
        }
    }
    
    @objc private func swipeLeftAction() {
        if emptyWallpaperCurrentIndex == emptyWallpapers.count - 1 {
            emptyWallpaperCurrentIndex = 0
        } else {
            emptyWallpaperCurrentIndex += 1
        }
    }
    
    @objc func nextButtonTapped() {
        let selectWallpaperStyleVC = WallpaperWithBackgroundVC()
        selectWallpaperStyleVC.emptyWallpaperUrl = self.emptyWallpapers[self.emptyWallpaperCurrentIndex].url
        self.navigationController?.pushViewController(selectWallpaperStyleVC, animated: true)
    }
}