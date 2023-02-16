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
    
    static let imageViewTopAnchor = 18.0
    static let imageViewLeadingAnchor = 20.0
    static let imageViewWidth = 80.0
    
    static let headerLabelTopAnchor = 40.0
    static let headerLabelLeadingAnchot = 26.0
    static let headerLabelHeight = 42.0
    
    static let descriptionLabelTopAnchor = 100.0
    static let descriptionLabelLeadingAnchor = 30.0
    static let descriptionLabelWidth = 300.0
    static let descriptionLabelHeight = 130.0
    
    static let submitButtonTopAnchor = 14.0
    static let submitButtonWidth = 156.0
    static let submitButtonHeight = 48.0
}

public class GenerationPopUpViewController: UIViewController {
    
    var runeModel: GenerationRuneModel?
    var runeView: UIView?
    var action: Dictionary<String, Selector>.Element?
    
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
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
               
        label.font = .systemRegular(size: 15)
        label.textColor = .descriptionLabelTextColor
        label.textAlignment = .left
        label.contentMode = .scaleToFill
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label
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
        configureView()
        
        self.view.backgroundColor = .clear
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isHiddenTabBar == false {
            self.tabBarController?.tabBar.isHidden = false
        } else {
            self.tabBarController?.tabBar.isHidden = true
        }
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    public func setupView(view: UIView) {
        self.runeView = view
    }
    
    public func setupModel(_ model: GenerationRuneModel?) {
        self.runeModel = model

        guard let image = model?.imageInfo.uiImage,
              let title = model?.title,
              let description = model?.description else { return }

        self.imageView.image = image
        self.headerLabel.attributedText = UILabel.getAttributedText(text: title, lineHeight: 0.7)
        self.descriptionLabel.attributedText = UILabel.getAttributedText(text: description, lineHeight: 1.12)
    }
    
    public func setupPopUp(image: UIImage, header: String, description: String) {
        
        self.imageView.image = image
        self.headerLabel.attributedText = UILabel.getAttributedText(text: header, lineHeight: 0.7)
        self.descriptionLabel.attributedText = UILabel.getAttributedText(text: description, lineHeight: 1.12)
    }
    
    public func setupAction(_ title: String, _ action: Selector) {
        self.action = (key: title, value: action)
        
        self.submitButton.setTitle(title: title)
        
        self.submitButton.removeTarget(self.parent, action: action, for: .touchUpInside)
        self.submitButton.addTarget(self.parent, action: action, for: .touchUpInside)
    }
    
    private func configureBlure() -> Void {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        
        blurView.alpha = 0.8
        blurView.frame = self.view.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.insertSubview(blurView, at: 0)
    }
    
    private func configureView() -> Void{       
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
            make.width.height.equalTo(CGFloat.imageViewWidth)
        }
        
        containerView.addSubview(headerLabel)
        headerLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(CGFloat.headerLabelTopAnchor)
            make.leading.equalTo(containerView.snp.trailing).offset(CGFloat.headerLabelLeadingAnchot)
            make.height.equalTo(CGFloat.headerLabelHeight)
        }
        
        containerView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(CGFloat.descriptionLabelTopAnchor)
            make.leading.equalTo(containerView.snp.leading).offset(CGFloat.descriptionLabelLeadingAnchor)
            make.width.equalTo(CGFloat.descriptionLabelWidth)
            make.height.equalTo(CGFloat.descriptionLabelHeight)
        }
        
        containerView.addSubview(submitButton)
        submitButton.addTarget(self, action: #selector(self.closeOnTap), for: .touchUpInside)
        submitButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(CGFloat.submitButtonTopAnchor)
            make.width.equalTo(CGFloat.submitButtonWidth)
            make.height.equalTo(CGFloat.submitButtonHeight)
        }
    }
    
    @objc func closeOnTap (sender: UIButton!) {
        self.close()
    }
    
    public func close() {
        self.view.removeFromSuperview()
    }
}
