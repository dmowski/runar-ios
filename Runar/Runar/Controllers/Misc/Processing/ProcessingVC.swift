//
//  ProcessingVC.swift
//  Runar
//
//  Created by Юлия Лопатина on 5.02.21.
//

import UIKit

extension String {
    static let lyod = L10n.Music.lyod
    static let blackRook = L10n.Music.blackRook
    static let myMotherTold = L10n.Music.myMotherTold
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

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        fillContent()
        doAnimation()
        
        generateWallpapers()
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

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }

    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
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
        self.downloadEmptyWallpapers(emptyWallpapers)
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
            self.delegate?.navigationController?.popViewController(animated: false)
            let emptyWallpaperViewController = EmptyWallpaperVC(emptyWallpapers: self.emptyWallpapers) {
                self.queue.cancelAllOperations()
            }
            self.delegate?.navigationController?.pushViewController(emptyWallpaperViewController, animated: true)
            
            
        })
        configureShapeLayer()
        backgroundLayer.layer.addSublayer(shapeLayer)
        shapeLayer.add(basicAnimation, forKey: nil)
        CATransaction.commit()
    }
    
    private var backgroundFire: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Assets.Background.mainFire.image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private var backgroundLayer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = true
        return view
    }()
    
    var container: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.clipsToBounds = false
        container.layer.backgroundColor = UIColor(red: 0.078, green: 0.078, blue: 0.078, alpha: 1).cgColor
        container.layer.cornerRadius = 5
        container.layer.bounds = container.bounds
        container.layer.position = container.center
        container.isHidden = true
        return container
    }()
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        let radiusConstant: CGFloat = DeviceType.iPhoneSE ? 83.5 : 147.heightDependent()
        imageView.layer.cornerRadius = radiusConstant
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private func configureShapeLayer() {
        let radiusConstant: CGFloat = DeviceType.iPhoneSE ? 83.5 : 147.heightDependent()
        let startAngle: CGFloat = -0.25 * 2 * .pi
        let endAngle: CGFloat = startAngle + 2 * .pi
        let circularPath = UIBezierPath(arcCenter: imageView.center, radius: radiusConstant, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        shapeLayer.path = circularPath.cgPath
    }
    
    private var shapeLayer: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeEnd = 0
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1).cgColor
        shapeLayer.lineWidth = 2
        return shapeLayer
    }()
    
    private var basicAnimation: CABasicAnimation = {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.fromValue = 0
        basicAnimation.toValue = 1
        basicAnimation.duration = 7
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        return basicAnimation
    }()

    private var nameLabel: UILabel = {
        let label = UILabel()
        let fontConstant: CGFloat = DeviceType.iPhoneSE ? 45 : 55
        label.font = FontFamily.AmaticSC.bold.font(size: fontConstant)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor =  UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1)
        label.textAlignment = .center
        label.attributedText = NSMutableAttributedString(string: label.text ?? "", attributes: [NSAttributedString.Key.kern: -1.1])
        return label
    }()
    
    private var startButton: UIButton = {
        let startButton = UIButton()
        startButton.backgroundColor = UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36)
        startButton.layer.borderColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1).cgColor
        startButton.layer.cornerRadius = 8
        startButton.layer.borderWidth = 1
        startButton.setTitle(L10n.goToTheSite, for: .normal)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        let fontConstant: CGFloat = DeviceType.iPhoneSE ? 24 : 30
        startButton.titleLabel?.font = FontFamily.AmaticSC.bold.font(size: fontConstant)
        startButton.setTitleColor(UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1), for: .normal)
        startButton.setTitleColor(UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1), for: .highlighted)
        return startButton
    }()
    
    @objc private func startButtonOnTap() {
        guard let url = URL(string: link) else {return}
        UIApplication.shared.open(url)
    }
    
    private var vectorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Assets.vector.image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private var processingLabel: UILabel = {
        var processingLabel = UILabel()
        processingLabel.text = L10n.layoutProcessing
        processingLabel.translatesAutoresizingMaskIntoConstraints = false
        let fontConstant: CGFloat = DeviceType.iPhoneSE ? 14 : 16
        processingLabel.font = FontFamily.Roboto.light.font(size: fontConstant)
        
        processingLabel.textColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1)
        processingLabel.textAlignment = .center
        return processingLabel
    }()

    private var adName: UILabel = {
        let adName = UILabel()
        let nameFontConstant: CGFloat = DeviceType.iPhoneSE ? 10 : 24
        adName.font = FontFamily.SFProDisplay.regular.font(size: nameFontConstant)
        adName.textColor = UIColor(red: 0.855, green: 0.855, blue: 0.855, alpha: 1)
        adName.textAlignment = .center
        adName.translatesAutoresizingMaskIntoConstraints = false
        return adName
    }()
    
    private var adText: UILabel = {
        let adText = UILabel()
        adText.textColor = UIColor(red: 0.855, green: 0.855, blue: 0.855, alpha: 1)
        let addFontConst: CGFloat =  DeviceType.iPhoneSE ? 14 : 16
        adText.font = FontFamily.SFProDisplay.light.font(size: addFontConst)
        adText.textAlignment = .center
        adText.translatesAutoresizingMaskIntoConstraints = false
        return adText
    }()
    
    private func configureUI() {
        view.addSubviews(backgroundFire, container, backgroundLayer, nameLabel, startButton, vectorImageView, processingLabel, imageView, adName, adText)
        startButton.addTarget(self, action: #selector(startButtonOnTap), for: .touchUpInside)
        
        let imageViewHeightConstant: CGFloat = DeviceType.iPhoneSE ? 167 : 294.heightDependent()
        let imageViewTopConstant: CGFloat = DeviceType.iPhoneSE ? 70 : 93.heightDependent()
        
        let nameLabelTop: CGFloat = DeviceType.iPhoneSE ? 35 : 57.heightDependent()
        let nameLabelHeight: CGFloat = DeviceType.iPhoneSE ? 75 : 90
        
        let startHeightConstant: CGFloat = DeviceType.iPhoneSE ? 46 : 56
        let buttonWidthConsatnt: CGFloat = DeviceType.iPhoneSE ? 210 : 255
        
        let vectorTop: CGFloat = DeviceType.iPhoneSE ? 17.25 : 21
        let vectorTrailing: CGFloat = DeviceType.iPhoneSE ? -18.76 : -22.84
        let vectorWidth: CGFloat = DeviceType.iPhoneSE ? 15.74 : 19.16
        let vectorHeight: CGFloat = DeviceType.iPhoneSE ? 10.68 : 13
        
        let processingTop: CGFloat = DeviceType.iPhoneSE ? 6 : 15.heightDependent()
        
        let adNameTop: CGFloat = DeviceType.iPhoneSE ? 16 : 24.heightDependent()
        let adTextTop: CGFloat = DeviceType.iPhoneSE ? 0 : 4.heightDependent()
        let adHeight: CGFloat = DeviceType.iPhoneSE ? 17 : 25
        
        NSLayoutConstraint.activate([
            backgroundFire.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundFire.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundFire.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -1),
            backgroundFire.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            backgroundLayer.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundLayer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundLayer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundLayer.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            nameLabel.topAnchor.constraint(equalTo: backgroundFire.topAnchor, constant: nameLabelTop),
            nameLabel.heightAnchor.constraint(equalToConstant: nameLabelHeight),
            nameLabel.centerXAnchor.constraint(equalTo: backgroundFire.centerXAnchor),
            
            startButton.bottomAnchor.constraint(equalTo: backgroundFire.bottomAnchor, constant: -40.heightDependent()),
            startButton.widthAnchor.constraint(equalToConstant: buttonWidthConsatnt),
            startButton.heightAnchor.constraint(equalToConstant: startHeightConstant),
            startButton.centerXAnchor.constraint(equalTo: backgroundFire.centerXAnchor),
            
            vectorImageView.topAnchor.constraint(equalTo: startButton.topAnchor, constant: vectorTop),
            vectorImageView.trailingAnchor.constraint(equalTo: startButton.trailingAnchor, constant: vectorTrailing),
            vectorImageView.widthAnchor.constraint(equalToConstant: vectorWidth),
            vectorImageView.heightAnchor.constraint(equalToConstant: vectorHeight),
            
            processingLabel.leadingAnchor.constraint(equalTo: backgroundFire.leadingAnchor, constant: 50),
            processingLabel.trailingAnchor.constraint(equalTo: backgroundFire.trailingAnchor, constant: -50),
            processingLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: processingTop),
            processingLabel.heightAnchor.constraint(equalToConstant: 17),
            
            container.topAnchor.constraint(equalTo: processingLabel.bottomAnchor, constant: 10),
            container.rightAnchor.constraint(equalTo: backgroundFire.rightAnchor, constant: -16),
            container.bottomAnchor.constraint(equalTo: backgroundFire.bottomAnchor, constant: -18),
            container.leftAnchor.constraint(equalTo: backgroundFire.leftAnchor, constant: 16),
            
            imageView.topAnchor.constraint(equalTo: processingLabel.bottomAnchor, constant: imageViewTopConstant),
            imageView.bottomAnchor.constraint(equalTo: imageView.topAnchor, constant: imageViewHeightConstant),
            imageView.centerXAnchor.constraint(equalTo: backgroundFire.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: imageViewHeightConstant),
            
            adName.leadingAnchor.constraint(equalTo: backgroundFire.leadingAnchor, constant: 60),
            adName.trailingAnchor.constraint(equalTo: backgroundFire.trailingAnchor, constant: -60),
            adName.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: adNameTop),
            adName.bottomAnchor.constraint(equalTo: adName.topAnchor, constant: adHeight),
            
            adText.leadingAnchor.constraint(equalTo: backgroundFire.leadingAnchor, constant: 60),
            adText.trailingAnchor.constraint(equalTo: backgroundFire.trailingAnchor, constant: -60),
            adText.topAnchor.constraint(equalTo: adName.bottomAnchor, constant: adTextTop),
            adText.bottomAnchor.constraint(equalTo: adText.topAnchor, constant: adHeight)
        ])
    }
    
    private var link = ""
    
    private func fillContent() {
        nameLabel.text = viewModel.name
        
        if (viewModel.title != nil){
            processingLabel.text = viewModel.title
        }
        
        switch MusicViewController.shared.currentSoundsIndex {
        case 0:
            imageView.image = Assets.led.image
            adName.text = String.lyod
            adText.text = String.myMotherTold
            link = "https://lyod1.bandcamp.com/releases"
        case 1:
            imageView.image = Assets.led.image
            adName.text = String.lyod
            adText.text = String.blackRook
            link = "https://lyod1.bandcamp.com/releases"
        case 2:
            imageView.image = Assets.danheim.image
            adName.text = "Danheim"
            adText.text = "Runar"
            link = "https://danheimmusic.com"
        case 3:
            imageView.image = Assets.danheim.image
            adName.text = "Danheim"
            adText.text = "Kala"
            link = "https://danheimmusic.com"
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
