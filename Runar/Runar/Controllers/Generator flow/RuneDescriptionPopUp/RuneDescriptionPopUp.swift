//
//  RuneDescriptionPopUp.swift
//  Runar
//
//  Created by Roman Kovtun on 5.02.21.
//

import UIKit

extension UIColor {
    static let popUpLabelTextColour = UIColor(red: 210/255, green: 196/255, blue: 173/255, alpha: 1)
    static let popupActionButtonBackgroundColor = UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36)
    static let popupActionButonTitleColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1)
}

class RuneDescriptionPopUp: UIViewController {
    
    //MARK: Containerview
    let containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 0.75)
        containerView.layer.cornerRadius = 20
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor(red: 84/255, green: 84/255, blue: 88/255, alpha: 0.65).cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    //MARK: TitleLabel
    let titleLabel: UILabel = {
        let titlelabel = UILabel()
        titlelabel.frame = .zero
        titlelabel.textAlignment = .center
    
        titlelabel.font = DeviceType.iPhoneSE ?
            FontFamily.AmaticSC.bold.font(size: 35) : FontFamily.AmaticSC.bold.font(size: 40)
        titlelabel.adjustsFontSizeToFitWidth = true
        titlelabel.minimumScaleFactor = 0.9
        titlelabel.lineBreakMode = .byTruncatingTail
        titlelabel.translatesAutoresizingMaskIntoConstraints = false
        titlelabel.textColor = .popUpLabelTextColour
        return titlelabel
    }()
    
    //MARK: ScrollView
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    //MARK: MessageLabel
    let messageLabel: UILabel = {
        let messageLabel = UILabel()
        messageLabel.textAlignment = .left
        messageLabel.textColor = UIColor(red: 233/255, green: 233/255, blue: 233/255, alpha: 1)
        
        messageLabel.font = DeviceType.iPhoneSE ?
            FontFamily.SFProDisplay.light.font(size: 17) : FontFamily.SFProDisplay.light.font(size: 20)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        return messageLabel
    }()
    
    //MARK: ActionButton
    let actionButton: UIButton = {
        let actionButton = CustomButton()
        actionButton.frame = .zero
        actionButton.backgroundColor = .popupActionButtonBackgroundColor
        actionButton.setTitle("Ok", for: .normal)
        
        actionButton.layer.cornerRadius = 8
        actionButton.setTitleColor(.popupActionButonTitleColor, for: .normal)
        actionButton.layer.borderWidth = 1
        actionButton.layer.borderColor = UIColor.popupActionButonTitleColor.cgColor
        actionButton.setTitleColor(UIColor(red: 0.294, green: 0.282, blue: 0.259, alpha: 1), for: .highlighted)
        actionButton.titleLabel?.font? = DeviceType.iPhoneSE ?
            FontFamily.AmaticSC.bold.font(size: 24) : FontFamily.AmaticSC.bold.font(size: 30)
        
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        
        return actionButton
    }()
    
    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    
    var viewModel: RuneDescriptionPopUpVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        configureContainerView()
        configureTitleLabel()
        configureActionButton()
        configureScrollView()
        configureBodyLabel()
    }
    
    func configureContainerView() {
        view.addSubview(containerView)
        let height: CGFloat = DeviceType.iPhoneSE ? 448 : 565.heightDependent()
        let trailingConstant: CGFloat = DeviceType.iPhoneSE ? -8 : -16
        let leadingConstant: CGFloat = DeviceType.iPhoneSE ? 8 : 16
        
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: height),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: trailingConstant),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingConstant),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    func configureTitleLabel() {
        titleLabel.text = viewModel.runeDescription.name
        containerView.addSubview(titleLabel)
        let topConstant: CGFloat = DeviceType.iPhoneSE ? 29 : 39
        let trailingConstant: CGFloat = DeviceType.iPhoneSE ? -21.88 : -11
        let leadingConstant: CGFloat = DeviceType.iPhoneSE ? 21.25 : 11
        let bottomConstant: CGFloat = DeviceType.iPhoneSE ? 35 : 35

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: topConstant),
            titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: trailingConstant),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: leadingConstant),
            titleLabel.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: bottomConstant)
        ])
    }
    
    func configureActionButton() {
        containerView.addSubview(actionButton)
//        actionButton.setTitle("Ok", for: .normal)
        actionButton.addTarget(self , action: #selector(dismissVC), for: .touchUpInside)

        let heighConstant: CGFloat = DeviceType.iPhoneSE ? 46 : 56
        let trailingConstant: CGFloat = DeviceType.iPhoneSE ? -112.88 : -143
        let leadingConstant: CGFloat = DeviceType.iPhoneSE ? 113.71 : 145
        let bottomConstant: CGFloat = DeviceType.iPhoneSE ? -36 : -40
        
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: bottomConstant),
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: leadingConstant),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: trailingConstant),
            actionButton.heightAnchor.constraint(equalToConstant: heighConstant)
        ])
    }
    
    @objc func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
    
    func configureScrollView(){
        containerView.addSubview(scrollView)
        let topConstant: CGFloat = DeviceType.iPhoneSE ? 20.75 : 26
        let bottomConstant: CGFloat = DeviceType.iPhoneSE ? -16 : -37

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: topConstant),
            scrollView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: bottomConstant)
        ])
    }
    
    func configureBodyLabel() {
        scrollView.addSubview(messageLabel)
        messageLabel.text = viewModel.runeDescription.description
        messageLabel.lineBreakMode = .byWordWrapping
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.34
        messageLabel.attributedText = NSMutableAttributedString(string: messageLabel.text!, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        messageLabel.numberOfLines = 0
        messageLabel.sizeToFit()
        
       // let widthAnchor: CGFloat = DeviceType.iPhoneSE ? 263 : 334

        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: scrollView.topAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            messageLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
}
