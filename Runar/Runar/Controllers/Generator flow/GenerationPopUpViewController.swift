//
//  GenerationPopUpViewController.swift
//  Runar
//
//  Created by Maksim Harbatsevich on 9/30/21.
//

import UIKit

//MARK: Add to color common class
private extension UIColor {
    static let containerViewBackgroundColor = UIColor(red: 0.118, green: 0.118, blue: 0.118, alpha: 0.75)
    static let descriptionLabelTextColor = UIColor(red: 0.882, green: 0.882, blue: 0.882, alpha: 1)
    static let submitButtonBackgroundColor = UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36)
}

//MARK: Constants
private extension CGFloat {
    static let containerViewHeight = 314.0
    
    static let escapeButtonTopAnchor = 18.0
    static let escapeButtonTrailingAnchor = 18.0
    static let escapeButtonWidth = 48.0
    
    static let imageViewTopAnchor = 20.0
    static let imageViewLeadingAnchor = 20.0
    static let imageViewWidth = 56.0
    static let imageViewHeight = 70.0
    
    static let headerLabelTopAnchor = 43.0
    static let headerLabelLeadingAnchot = 26.0
    static let headerLabelHeight = 42.0
    
    static let descriptionTextViewTopAnchor = 5.0
    static let descriptionTextViewLeadingAnchor = 32.0
    static let descriptionTextViewTrailingAnchor = 32.0
    static let descriptionTextViewWidth = 300.0
    static let descriptionTextViewHeight = 130.0
    
    static let submitButtonTopAnchor = 14.0
    static let submitButtonWidth = 156.0
    static let submitButtonHeight = 48.0
}

public class GenerationPopUpViewController: UIViewController {
    
    var runeModel: GenerationRuneModel?
    var runeView: UIView?
    var action: Dictionary<String, Selector>.Element?
    let gradientLayer = CAGradientLayer()
    
    var isHiddenTabBar: Bool = false
    
    let containerView: UIView = {
        let containerView = UIView()
                
        containerView.backgroundColor = .containerViewBackgroundColor
        containerView.layer.cornerRadius = 20
        
        return containerView
    }()
    
    let escapeButton: UIButton = {
        let escapeButton = UIButton()
        
        let image = Assets.escape.image
        escapeButton.setImage(image, for: .normal)
        
        return escapeButton
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    let headerLabel: UILabel = {
        let header = UILabel()
               
        header.font = .amaticBold(size: 36)
        header.textColor = .yellowPrimaryColor
        header.textAlignment = .center
        header.contentMode = .center
        
        return header
    }()
    
    let descriptionTextView: UITextView = {
        let view = UITextView()
               
        view.font = .systemRegular(size: 17)
        view.textColor = .descriptionLabelTextColor
        view.textAlignment = .left
        view.contentMode = .scaleToFill
        view.isSelectable = false
        view.isEditable = false
        view.indicatorStyle = .white
        view.backgroundColor = .clear
        
        return view
    }()
    
    let submitButton: UIButton = {
        let submitButton = UIButton()
        
        submitButton.layer.backgroundColor = UIColor.submitButtonBackgroundColor.cgColor
        submitButton.layer.cornerRadius = 10
        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = UIColor.yellowPrimaryColor.cgColor
        submitButton.isHidden = true
        
        return submitButton
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configureBlure()
        configureViews()
        
        view.backgroundColor = .clear
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isHiddenTabBar == false {
            tabBarController?.tabBar.isHidden = false
        } else {
            tabBarController?.tabBar.isHidden = true
        }
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    public override func viewDidLayoutSubviews() {
        configureGradientLayer()
    }
    
    public func setupView(view: UIView) {
        runeView = view
    }
    
    public func setupModel(_ model: GenerationRuneModel?) {
        runeModel = model

        guard let image = model?.imageInfo.uiImage,
              let title = model?.title,
              let description = model?.description else { return }

        imageView.image = image
        
        headerLabel.text = title
        descriptionTextView.text = description
    }
    
    public func setupAction(_ title: String, _ action: Selector) {
        self.action = (key: title, value: action)
    
        submitButton.setTitle(title: title)
        
        submitButton.removeTarget(self.parent, action: action, for: .touchUpInside)
        submitButton.addTarget(self.parent, action: action, for: .touchUpInside)
    }
    
    private func configureBlure() -> Void {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        
        blurView.alpha = 0.8
        blurView.frame = self.view.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.insertSubview(blurView, at: 0)
    }
    
    private func configureViews() -> Void {       
        view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalToSuperview()
            make.height.equalTo(CGFloat.containerViewHeight)
        }
        
        containerView.addSubview(escapeButton)
        escapeButton.addTarget(self, action: #selector(self.closeOnTap), for: .touchUpInside)
        escapeButton.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(CGFloat.escapeButtonTopAnchor)
            make.trailing.equalTo(containerView.snp.trailing).inset(CGFloat.escapeButtonTrailingAnchor)
            make.width.height.equalTo(CGFloat.escapeButtonWidth)
        }
        
        containerView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(CGFloat.imageViewTopAnchor)
            make.leading.equalTo(containerView.snp.leading).offset(CGFloat.imageViewLeadingAnchor)
            make.width.equalTo(CGFloat.imageViewWidth)
            make.height.equalTo(CGFloat.imageViewHeight)
        }
        
        containerView.addSubview(headerLabel)
        headerLabel.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(CGFloat.headerLabelLeadingAnchot)
            make.height.equalTo(CGFloat.headerLabelHeight)
            make.centerY.equalTo(imageView.snp.centerY)
        }
        
        containerView.addSubview(descriptionTextView)
        descriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(CGFloat.descriptionTextViewTopAnchor)
            make.leading.equalTo(containerView.snp.leading).offset(CGFloat.descriptionTextViewLeadingAnchor)
            make.trailing.equalTo(containerView.snp.trailing).inset(CGFloat.descriptionTextViewTrailingAnchor)
            make.width.equalTo(CGFloat.descriptionTextViewWidth)
            make.height.equalTo(CGFloat.descriptionTextViewHeight)
        }
        
        containerView.addSubview(submitButton)
        submitButton.addTarget(self, action: #selector(self.closeOnTap), for: .touchUpInside)
        submitButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionTextView.snp.bottom).offset(CGFloat.submitButtonTopAnchor)
            make.width.equalTo(CGFloat.submitButtonWidth)
            make.height.equalTo(CGFloat.submitButtonHeight)
            make.centerX.equalToSuperview()
        }
    }
    
    private func configureGradientLayer() {
        descriptionTextView.delegate = self
        gradientLayer.delegate = self
        gradientLayer.frame = descriptionTextView.bounds
        
        gradientLayer.colors = [
            UIColor.black.withAlphaComponent(0).cgColor,
            UIColor.white.cgColor,
            UIColor.white.cgColor,
            UIColor.black.withAlphaComponent(0).cgColor
        ]
        
        let topInset = descriptionTextView.textContainerInset.top
        let bottomInset = descriptionTextView.textContainerInset.bottom
        
        let firstLocation = NSNumber(value: 0.0)
        let secondLocation = NSNumber(value: topInset / descriptionTextView.frame.height)
        let thirdLocation = NSNumber(value: 1.0 - bottomInset / descriptionTextView.frame.height)
        let fourthLocation = NSNumber(value: 1.0)
        
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.locations = [
            firstLocation,
            secondLocation,
            thirdLocation,
            fourthLocation
        ]
        descriptionTextView.layer.mask = gradientLayer
    }
    
    @objc func closeOnTap (sender: UIButton!) {
        close()
    }
    
    public func close() {
        view.removeFromSuperview()
    }
}

extension GenerationPopUpViewController: UITextViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        gradientLayer.frame = descriptionTextView.bounds
    }
}

extension GenerationPopUpViewController: CALayerDelegate {
    public func action(for layer: CALayer, forKey event: String) -> CAAction? {
        return NSNull()
    }
}
