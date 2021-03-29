//
//  RuneDescriptionPopUp.swift
//  Runar
//
//  Created by Roman Kovtun on 5.02.21.
//

import UIKit

struct Constants {
    static let labelTextColour = UIColor(red: 210/255, green: 196/255, blue: 173/255, alpha: 1)
    static let actionButtonBackgroundColor = UIColor(red: 106/255, green: 106/255, blue: 106/255, alpha: 0.36)
    static let actionButonBorderColor = UIColor(red: 210/255, green: 196/255, blue: 173/255, alpha: 1).cgColor
    static let actionButonTitleColor = UIColor(red: 210/255, green: 196/255, blue: 173/255, alpha: 1)
}

//MARK: RuneDescriptionPopUp
//How to create popup
//runeDescriptionPopUp = RuneDescriptionPopUp.init(with: name)
//runeDescriptionPopUp.modalPresentationStyle = .overFullScreen
//runeDescriptionPopUp.modalTransitionStyle = .crossDissolve
//self.present(runeDescriptionPopUp, animated: true)
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
    
        if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
            titlelabel.font = UIFont(name: "AmaticSC-Bold", size: 35)
        } else {
            titlelabel.font = UIFont(name: "AmaticSC-Bold", size: 40)
        }
        
        titlelabel.adjustsFontSizeToFitWidth = true
        titlelabel.minimumScaleFactor = 0.9
        titlelabel.lineBreakMode = .byTruncatingTail
        titlelabel.translatesAutoresizingMaskIntoConstraints = false
        titlelabel.textColor = Constants.labelTextColour
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
        messageLabel.frame = .zero
        messageLabel.textAlignment = .left
        
        messageLabel.textColor = UIColor(red: 233/255, green: 233/255, blue: 233/255, alpha: 1)
        
        if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
            messageLabel.font = UIFont(name: "SFProDisplay-Light", size: 17)
        } else {
            messageLabel.font = UIFont(name: "SFProDisplay-Light", size: 20)
        }
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        return messageLabel
    }()
    
    //MARK: ActionButton
    let actionButton: UIButton = {
        let actionButton = UIButton()
        actionButton.frame = .zero
        actionButton.backgroundColor = Constants.actionButtonBackgroundColor
        actionButton.setTitle("Ok", for: .normal)
        
        actionButton.layer.cornerRadius = 8
        actionButton.setTitleColor(Constants.actionButonTitleColor, for: .normal)
        actionButton.layer.borderWidth = 1
        actionButton.layer.borderColor = Constants.actionButonBorderColor
        
        if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
            actionButton.titleLabel?.font = UIFont(name: "AmaticSC-Bold", size: 24)
        } else {
            actionButton.titleLabel?.font = UIFont(name: "AmaticSC-Bold", size: 30)
        }
        
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        
        return actionButton
    }()
    
    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    
    var viewModel: RuneDescriptionPopUpViewModel!
    
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
        let topConstant: CGFloat = DeviceType.iPhoneSE ? 60 : 156
        let trailingConstant: CGFloat = DeviceType.iPhoneSE ? -8 : -16
        let leadingConstant: CGFloat = DeviceType.iPhoneSE ? 8 : 16
        let bottomConstant: CGFloat = DeviceType.iPhoneSE ? -60 : -175
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: topConstant),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: trailingConstant),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingConstant),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottomConstant)
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
        actionButton.setTitle("Ok", for: .normal)
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
        let trailingConstant: CGFloat = DeviceType.iPhoneSE ? -24 : -24
        let leadingConstant: CGFloat = DeviceType.iPhoneSE ? 17 : 24
        let bottomConstant: CGFloat = DeviceType.iPhoneSE ? -16 : -37

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: topConstant),
            scrollView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: leadingConstant),
            scrollView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: trailingConstant),
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
        
        let widthAnchor: CGFloat = DeviceType.iPhoneSE ? 263 : 334

        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: scrollView.topAnchor),
            messageLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            messageLabel.widthAnchor.constraint(equalToConstant: widthAnchor),
            messageLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
}
