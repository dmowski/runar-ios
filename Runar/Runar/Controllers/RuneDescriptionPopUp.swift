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
    
    let containerView = AlertContainerView()
    let titleLabel = TitleLabel(textAlignment: .center, fontSize: 20)
    let messageLabel = BodyLabel(textAlignment: .left)
    let actionButton = SampleButton(backgroundColor: Constants.actionButtonBackgroundColor, title: "Ok")
    
    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    
    var viewModel: RuneDescriptionPopUpViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        view.addSubview(containerView)
        view.addSubview(titleLabel)
        view.addSubview(actionButton)
        view.addSubview(messageLabel)
        configureContainerView()
        configureTitleLabel()
        configureActionButton()
        configureBodyLabel()
    }
    
    func configureContainerView() {
        if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
            NSLayoutConstraint.activate([
                containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
                containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
                containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
                containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60)
            ])
        } else {
            NSLayoutConstraint.activate([
                containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 156),
                containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -175)
            ])
        }
    }
    
    func configureTitleLabel() {
        titleLabel.text = viewModel.runeDescription.description
        
//        if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
//            NSLayoutConstraint.activate([
//                titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 34.88),
//                titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
//                titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -387.75)
//            ])
//        } else {
//            NSLayoutConstraint.activate([
//                titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 44),
//                titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
//                titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -486)
//            ])
//        }
        
        NSLayoutConstraint.activate([
                        titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 44),
                        titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 35),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 11),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: -11),
            
                    ])
        
    }
    
    func configureActionButton() {
        actionButton.setTitle("Ok", for: .normal)
        actionButton.addTarget(self , action: #selector(dismissVC), for: .touchUpInside)
        
        if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
            NSLayoutConstraint.activate([
                actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -366),
                actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 113.71),
                actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -112.88),
                actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -366)
            ])
        } else {
            NSLayoutConstraint.activate([
                actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -469),
                actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 145),
                actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -143),
                actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -40)
            ])
        }
    }
    
   @objc func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
    
    func configureBodyLabel() {
        messageLabel.text = viewModel.runeDescription.description
        messageLabel.lineBreakMode = .byWordWrapping
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.34
        messageLabel.attributedText = NSMutableAttributedString(string: messageLabel.text!, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        messageLabel.numberOfLines = 0
        messageLabel.sizeToFit()
        
        if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0{
            NSLayoutConstraint.activate([
                messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 17.75),
                messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 17),
                messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
                messageLabel.bottomAnchor.constraint(lessThanOrEqualTo: actionButton.topAnchor, constant: -98)
            ])
        } else {
            NSLayoutConstraint.activate([
                messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 21),
                messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
                messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
                messageLabel.bottomAnchor.constraint(lessThanOrEqualTo: actionButton.topAnchor, constant: -37)
            ])
        }
    }
}

//MARK: BodyLabel
class BodyLabel: UILabel {

    override init(frame: CGRect) {
         super.init(frame: frame)
         configure()
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
    convenience init(textAlignment: NSTextAlignment) {
         self.init(frame: .zero)
         self.textAlignment = textAlignment
        
     }
     
     private func configure() {
        textColor = UIColor(red: 233/255, green: 233/255, blue: 233/255, alpha: 1)
        
        if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
        font = UIFont(name: "SFProDisplay-Light", size: 17)
        } else {
            font = UIFont(name: "SFProDisplay-Light", size: 20)
        }
        translatesAutoresizingMaskIntoConstraints = false
     }
}

//MARK: SampleButton

class SampleButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   convenience init(backgroundColor: UIColor, title: String) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
    }
    
    private func configure() {
        layer.cornerRadius = 8
        setTitleColor(Constants.actionButonTitleColor, for: .normal)
        layer.borderWidth = 1
        layer.borderColor = Constants.actionButonBorderColor
        
        if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
            titleLabel?.font = UIFont(name: "AmaticSC-Bold", size: 24)
        } else {
            titleLabel?.font = UIFont(name: "AmaticSC-Bold", size: 30)
        }
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setBackground(backgroundColor: UIColor, title: String) {
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
    }
}

//MARK: TitleLabel

class TitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
    self.init(frame: .zero)
        self.textAlignment = textAlignment
    
        if UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0 {
            self.font = UIFont(name: "AmaticSC-Bold", size: 35)
        } else {
            self.font = UIFont(name: "AmaticSC-Bold", size: 40)
        }
    }
    
    private func configure() {
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
        self.textColor = Constants.labelTextColour
    }
}

//MARK: AlertContainerView

class AlertContainerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        backgroundColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 0.75)
        layer.cornerRadius = 20
        layer.borderWidth = 1
        layer.borderColor = UIColor(red: 84/255, green: 84/255, blue: 88/255, alpha: 0.65).cgColor
        translatesAutoresizingMaskIntoConstraints = false
    }
}

