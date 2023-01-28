//
//  GenerationPopUpViewController.swift
//  Runar
//
//  Created by Maksim Harbatsevich on 9/30/21.
//

import UIKit

public class GenerationPopUpViewController: UIViewController {
    
    var runeModel: GenerationRuneModel?
    var runeView: UIView?
    var action: Dictionary<String, Selector>.Element?
    
    var isHiddenTabBar: Bool = false
    
    let containerView: UIView = {
        let containerView = UIView()
                
        containerView.backgroundColor = UIColor(red: 0.118, green: 0.118, blue: 0.118, alpha: 0.75)
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
    
    let header: UILabel = {
        let header = UILabel()
               
        header.font = FontFamily.AmaticSC.bold.font(size: 36)
        header.textColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1)
        header.textAlignment = .center
        header.contentMode = .center
        
        return header
    }()
    
    let desc: UILabel = {
        let desc = UILabel()
               
        desc.font = FontFamily.SFProDisplay.regular.font(size: 15)
        desc.textColor = UIColor(red: 0.882, green: 0.882, blue: 0.882, alpha: 1)
        desc.textAlignment = .left
        desc.contentMode = .scaleToFill
        desc.numberOfLines = 0
        desc.lineBreakMode = .byWordWrapping
        
        return desc
    }()
    
    let submitButton: UIButton = {
        let submitButton = UIButton()
        
        submitButton.layer.backgroundColor = UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36).cgColor
        submitButton.layer.cornerRadius = 10
        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1).cgColor
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
        self.header.attributedText = UILabel.getAttributedText(text: title, lineHeight: 0.7)
        self.desc.attributedText = UILabel.getAttributedText(text: description, lineHeight: 1.12)
    }
    
    public func setupPopUp(image: UIImage, header: String, description: String) {
        
        self.imageView.image = image
        self.header.attributedText = UILabel.getAttributedText(text: header, lineHeight: 0.7)
        self.desc.attributedText = UILabel.getAttributedText(text: description, lineHeight: 1.12)
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
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            containerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 314)
        ])
        
        escapeButton.addTarget(self, action: #selector(self.closeOnTap), for: .touchUpInside)
        
        containerView.addSubview(escapeButton)
        
        escapeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            escapeButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 18),
            escapeButton.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -18),
            escapeButton.widthAnchor.constraint(equalToConstant: 48),
            escapeButton.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        containerView.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 18),
            imageView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20),
            imageView.heightAnchor.constraint(equalToConstant: 80),
            imageView.widthAnchor.constraint(equalToConstant: 80)
        ])
        
        containerView.addSubview(header)
        
        header.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 40),
            header.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 26),
            header.heightAnchor.constraint(equalToConstant: 42)
        ])
        
        containerView.addSubview(desc)
        
        desc.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            desc.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 100),
            desc.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 30),
            desc.widthAnchor.constraint(equalToConstant: 300),
            desc.heightAnchor.constraint(equalToConstant: 130)
        ])
        
        containerView.addSubview(submitButton)
    
        submitButton.addTarget(self, action: #selector(self.closeOnTap), for: .touchUpInside)
        
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            submitButton.topAnchor.constraint(equalTo: desc.bottomAnchor, constant: 14),
            submitButton.heightAnchor.constraint(equalToConstant: 48),
            submitButton.widthAnchor.constraint(equalToConstant: 156),
            submitButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
    }
    
    @objc func closeOnTap (sender: UIButton!) {
        self.close()
    }
    
    public func close() {
        self.view.removeFromSuperview()
    }
}
