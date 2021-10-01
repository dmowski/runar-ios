//
//  GenerationPopUpViewController.swift
//  Runar
//
//  Created by Maksim Harbatsevich on 9/30/21.
//

import UIKit

public class GenerationPopUpViewController : UIViewController {
    var runeModel: GenerationRuneModel?
    var action: Dictionary<String, Selector>.Element?
        
    let containerView: UIView = {
        let containerView = UIView()
                
        containerView.backgroundColor = UIColor(red: 0.118, green: 0.118, blue: 0.118, alpha: 0.75)
        containerView.layer.cornerRadius = 20
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        return containerView
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configureBlure()
        configureView()
        
        self.view.backgroundColor = .clear
        self.tabBarController?.tabBar.isHidden = true
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    public func setupModel(_ model: GenerationRuneModel?){
        self.runeModel = model
    }
    
    public func setupAction(_ title: String, _ action: Selector){
        self.action = (key: title, value: action)
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
        
        NSLayoutConstraint.activate([
            containerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            containerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            containerView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -314),
            containerView.heightAnchor.constraint(equalToConstant: 314)
        ])
        
        let escapeButton = createEscapeBtn()
        
        escapeButton.addTarget(self, action: #selector(self.closeOnTap), for: .touchUpInside)
        
        containerView.addSubview(escapeButton)
        
        NSLayoutConstraint.activate([
            escapeButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 18),
            escapeButton.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -18),
            escapeButton.widthAnchor.constraint(equalToConstant: 48),
            escapeButton.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        let imageView = createImage(image: runeModel!.image.image)
        
        containerView.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 18),
            imageView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20),
            imageView.heightAnchor.constraint(equalToConstant: 80),
            imageView.widthAnchor.constraint(equalToConstant: 80)
        ])
        
        let title = createTitle(title: runeModel!.title, size: 36, lineHeight: 0.7)
        
        containerView.addSubview(title)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 40),
            title.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 26),
            title.heightAnchor.constraint(equalToConstant: 42)
        ])
        
        let description = createDesc(desc: runeModel!.description)
        
        containerView.addSubview(description)
        
        description.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            description.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 100),
            description.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 30),
            description.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        if (self.action != nil){
            let submitBtn = createSubmitBtn()
            
            containerView.addSubview(submitBtn)
            
            submitBtn.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                submitBtn.topAnchor.constraint(equalTo: description.bottomAnchor, constant: 24),
                submitBtn.heightAnchor.constraint(equalToConstant: 48),
                submitBtn.widthAnchor.constraint(equalToConstant: 156),
                submitBtn.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
            ])
        }
    }
    
    private func createEscapeBtn() -> UIButton {
        let escapeButton = UIButton()
        escapeButton.translatesAutoresizingMaskIntoConstraints = false
        let image = Assets.escape.image
        escapeButton.setImage(image, for: .normal)
        
        return escapeButton
    }
    
    private func createImage(image: UIImage) -> UIImageView {
        let imageView = UIImageView(image: runeModel?.image.image)
        
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }
    
    private func createTitle(title: String, size: CGFloat, lineHeight: CGFloat) -> UILabel {
        let label = UILabel()
               
        label.font = FontFamily.AmaticSC.bold.font(size: size)
        label.textColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1)
        label.textAlignment = .center
        label.contentMode = .center
        
        let prgph = NSMutableParagraphStyle()
        
        prgph.lineHeightMultiple = lineHeight
        
        label.attributedText = NSMutableAttributedString(string: title, attributes: [NSAttributedString.Key.paragraphStyle: prgph])
        
        return label
    }
    
    private func createDesc(desc: String) -> UILabel {
        let label = UILabel()
               
        label.font = FontFamily.SFProDisplay.regular.font(size: 15)
        label.textColor = UIColor(red: 0.882, green: 0.882, blue: 0.882, alpha: 1)
        label.textAlignment = .left
        label.contentMode = .scaleToFill
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        let prgph = NSMutableParagraphStyle()
        
        prgph.lineHeightMultiple = 1.12
        
        label.attributedText = NSMutableAttributedString(string: desc, attributes: [NSAttributedString.Key.paragraphStyle: prgph])
        
        return label
    }
    
    private func createSubmitBtn() -> UIButton {
        let submitBtn = UIButton()
        
        submitBtn.layer.backgroundColor = UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36).cgColor
        submitBtn.layer.cornerRadius = 10
        submitBtn.layer.borderWidth = 1
        submitBtn.layer.borderColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1).cgColor
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.79
        
        let attributedText = NSMutableAttributedString(string: self.action!.key, attributes: [
                                                        NSMutableAttributedString.Key.paragraphStyle: paragraphStyle,
                                                        NSMutableAttributedString.Key.font: FontFamily.AmaticSC.bold.font(size: 24),
                                                        NSMutableAttributedString.Key.foregroundColor: UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1)])
        
        submitBtn.setAttributedTitle(attributedText, for: .normal)
        
        submitBtn.addTarget(self, action: #selector(self.closeOnTap), for: .touchUpInside)
        submitBtn.addTarget(self.parent, action: self.action!.value, for: .touchUpInside)
        
        return submitBtn
    }
    
    @IBAction func closeOnTap (sender: UIButton!) {
        self.view.removeFromSuperview()
    }
}
