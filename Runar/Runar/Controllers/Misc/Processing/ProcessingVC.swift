//
//  ProcessingVC.swift
//  Runar
//
//  Created by Юлия Лопатина on 5.02.21.
//

import UIKit

//MARK: Constants
extension String {
    static let lyod = L10n.Music.lyod
    static let blackRook = L10n.Music.blackRook
    static let myMotherTold = L10n.Music.myMotherTold
    static let bandcampLink = "https://lyod1.bandcamp.com/releases"
    static let danheimMusicLink = "https://danheimmusic.com"
    static let danheimText = "Danheim"
    static let kalaText = "Kala"
    static let runarText = "Runar"
}

//MARK: Add to color common class
private extension UIColor {
    static let startButtonBackgroundColor = UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36)
    static let processingLabelTextColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1)
    static let titleLabelTextColor = UIColor(red: 0.855, green: 0.855, blue: 0.855, alpha: 1)
}

//MARK: Constants
private extension CGFloat {
    
    static let processingLabelTopAnchor = 27.0
    
    static let imageViewHeight = DeviceType.iPhoneSE ? 167.0 : 250.0
    static let imageViewTopAnchor = 32.0
    
    static let titleLabelTopAnchor = DeviceType.iPhoneSE ? 32.0 : 72.0
    
    static let subtitleLabelTopAnchor = DeviceType.iPhoneSE ? 12.0 : 28.0
    
    static let goToTheSiteButtonHeight = 48.0
    static let goToTheSiteButtonWidth = 254.0
    static let goToTheSiteButtonBottomAnchor = 49.0
    
    static let arrowImageViewTrailingAnchor = 16.0
    static let arrowImageViewWidth = 24.0
}

enum Images: String {
    case choosedWallpapersWithBlackHorizontal
    case choosedWallpapersWithDarkVertical
    case choosedWallpapersWithWpForest
    case choosedWallpapersWithWpBark
}

struct EmptyWallpaper {
    let name: String
    let url: String
}

class ProcessingVC: UIViewController {
    
    let queue = OperationQueue()
    let operation = Operation()
    
    var viewModel: ProcessingVM!
    var emptyWallpapers = [EmptyWallpaper]()
    
    var ifGenerateWallpapers: Bool?
    var runesIds: [String]?
    var delegate: UIViewController?
    
    private var link = ""
    
    private let processingLabel: UILabel = {
        var processingLabel = UILabel()
        processingLabel.text = L10n.layoutProcessing
        processingLabel.font = .systemLight(size: 14)
        
        processingLabel.textColor = UIColor.processingLabelTextColor
        processingLabel.textAlignment = .center
        return processingLabel
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let shapeView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()

    private let shapeLayer: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeEnd = 0
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.yellowSecondaryColor.cgColor
        shapeLayer.lineWidth = 2
        return shapeLayer
    }()
    
    private let basicAnimation: CABasicAnimation = {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.fromValue = 0
        basicAnimation.toValue = 1
        basicAnimation.duration = 15
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        return basicAnimation
    }()
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .boldSystemFont(ofSize: 26)
        titleLabel.textColor = .titleLabelTextColor
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
    private let subtitleLabel: UILabel = {
        let subtitleLabel = UILabel()
        subtitleLabel.textColor = .yellowPrimaryColor
        subtitleLabel.font = .systemLight(size: 20)
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 0
        return subtitleLabel
    }()
    
    private let goToTheSiteButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .startButtonBackgroundColor
        button.layer.borderColor = UIColor.yellowPrimaryColor.cgColor
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.setTitle(L10n.goToTheSite, for: .normal)
        button.titleLabel?.font = .amaticBold(size: 24)
        button.setTitleColor(.yellowPrimaryColor, for: .normal)
        button.setTitleColor(.yellowSecondaryColor, for: .highlighted)
        return button
    }()
    
    private let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Assets.vector.image
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        RunarLayout.initBackground(for: view, with: .mainFire)
        configureViews()
        configureNavigationBar()
        fillContent()
        doAnimation()
        generateWallpapers()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        tabBarController?.tabBar.isHidden = true
    }
    
    private func generateWallpapers() {

        if ifGenerateWallpapers == true {
            
            if let runesIds = runesIds {
                DispatchQueue.global(qos: .userInitiated).async {
                    self.generateEmptyWallpapers(runesIds: runesIds)
                }
            } else {
                fatalError("RunesIds is empty")
            }
        }
    }
    
    private func generateEmptyWallpapers(runesIds: [String]) {

        guard let data = RunarApi.getEmptyWallpapersData(runsIds: runesIds) else { return }
        guard let emptyWallpapersUrls = try? JSONDecoder().decode([String].self, from: data) else { return }
        
        for url in emptyWallpapersUrls {
            
            if let separated = url.split(separator: "/").last {
                let name = String(separated)
                
                if name.elementsEqual("undefined") { continue }
                
                let emptyWallpaper = EmptyWallpaper(name: String(separated), url: url)
                emptyWallpapers.append(emptyWallpaper)
            }
        }
        downloadEmptyWallpapers(emptyWallpapers)
    }
    
    private func downloadEmptyWallpapers(_ emptyWallpapers: [EmptyWallpaper]) {
        
        ImageFileManager.shared.removeImagesFromMemory()
        
        queue.maxConcurrentOperationCount = 5
        queue.underlyingQueue = .global(qos: .userInitiated)
        
        for emptyWallpaper in emptyWallpapers {
            let operation = DownloadOperation()
            operation.emptyWallpaper = emptyWallpaper
            queue.addOperation(operation)
        }
    }
    
    private func doAnimation() {
        view.layoutIfNeeded()

        CATransaction.begin()
        CATransaction.setCompletionBlock({
            
            self.viewModel.closeTransition()
            let emptyWallpaperViewController = EmptyWallpaperVC(emptyWallpapers: self.emptyWallpapers) {
                self.queue.cancelAllOperations()
            }
            self.delegate?.navigationController?.pushViewController(emptyWallpaperViewController, animated: true)
        })
        
        configureShapeLayer()
        shapeLayer.add(basicAnimation, forKey: nil)
        CATransaction.commit()
    }
    
    private func configureShapeLayer() {
        let radiusConstant = CGFloat.imageViewHeight / 2
        let startAngle: CGFloat = -0.5 * .pi
        let endAngle: CGFloat = startAngle + 2 * .pi
        let arcCenter = CGPoint(x: shapeView.frame.width / 2, y: shapeView.frame.height / 2)
        let circularPath = UIBezierPath(arcCenter: arcCenter, radius: radiusConstant, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        shapeLayer.path = circularPath.cgPath
    }

    private func configureViews() {
        view.addSubview(processingLabel)
        processingLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(CGFloat.processingLabelTopAnchor)
            make.centerX.equalToSuperview()
        }
        
        view.addSubviews(imageView)
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(CGFloat.imageViewHeight)
            make.top.equalTo(processingLabel.snp.bottom).offset(CGFloat.imageViewTopAnchor)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(shapeView)
        shapeView.layer.addSublayer(shapeLayer)
        shapeView.snp.makeConstraints { make in
            make.leading.top.bottom.trailing.equalTo(imageView)
        }

        view.addSubview(goToTheSiteButton)
        goToTheSiteButton.addTarget(self, action: #selector(goToTheSiteButtonOnTap), for: .touchUpInside)
        goToTheSiteButton.snp.makeConstraints { make in
            make.width.equalTo(CGFloat.goToTheSiteButtonWidth)
            make.height.equalTo(CGFloat.goToTheSiteButtonHeight)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(CGFloat.goToTheSiteButtonBottomAnchor)
        }
        
        view.addSubview(arrowImageView)
        arrowImageView.snp.makeConstraints { make in
            make.width.height.equalTo(CGFloat.arrowImageViewWidth)
            make.centerY.equalTo(goToTheSiteButton)
            make.trailing.equalTo(goToTheSiteButton.snp.trailing).inset(CGFloat.arrowImageViewTrailingAnchor)
        }
        
        view.addSubviews(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(CGFloat.titleLabelTopAnchor)
            make.centerX.equalToSuperview()
        }
        
        view.addSubviews(subtitleLabel)
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(CGFloat.subtitleLabelTopAnchor)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc private func goToTheSiteButtonOnTap() {
        guard let url = URL(string: link) else { return }
        UIApplication.shared.open(url)
    }
    
    private func configureNavigationBar() {
        navigationItem.setNavigationTitle(viewModel.name)
        navigationItem.hidesBackButton = true
    }
    
    private func fillContent() {
        
        if let processingTitle = viewModel.title {
            processingLabel.text = processingTitle
        }
        
        switch MusicViewController.shared.currentSoundsIndex {
        case 0:
            imageView.image = Assets.led.image
            titleLabel.text = .lyod
            subtitleLabel.text = .myMotherTold
            link = .bandcampLink
        case 1:
            imageView.image = Assets.blackRook.image
            titleLabel.text = .lyod
            subtitleLabel.text = .blackRook
            link = .bandcampLink
        case 2:
            imageView.image = Assets.danheim.image
            titleLabel.text = .danheimText
            subtitleLabel.text = .runarText
            link = .danheimMusicLink
        case 3:
            imageView.image = Assets.danheim.image
            titleLabel.text = .danheimText
            subtitleLabel.text = .kalaText
            link = .danheimMusicLink
        default:
            imageView.image = nil
        }
    }
    
    func changeAnimationDuration(duration: Int) {
        basicAnimation.duration = CFTimeInterval(duration)
    }
}

class DownloadOperation: Operation {
    var emptyWallpaper: EmptyWallpaper?
    
    override func main() {
        
        guard let emptyWallpaper = emptyWallpaper,
              let image = UIImage.create(fromUrl: emptyWallpaper.url) else { return }

        ImageFileManager.shared.writeImageToFile(image: image, fileName: emptyWallpaper.name)
    }
}
