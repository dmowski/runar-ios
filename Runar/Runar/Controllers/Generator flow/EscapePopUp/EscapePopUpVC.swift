//
//  EscapePopUpVC.swift
//  Runar
//
//  Created by Roman Kovtun on 29.03.21.
//

import UIKit

extension String {
    static let yes = L10n.PopUp.yes
    static let no = L10n.PopUp.no
    static let stopAlignment = L10n.PopUp.stopAlignment
}

extension UIColor {
    static let alertActionButonTitleColor = UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1)
    static let popUpContainer = UIColor(red: 0.118, green: 0.118, blue: 0.118, alpha: 0.75)
}

class EscapePopUpVC: UIViewController {
    
    //MARK: Containerview
    let containerView: UIView = {
        let containerView = UIView()
        
        containerView.backgroundColor = .popUpContainer
        containerView.layer.cornerRadius = 20
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor(red: 0.329, green: 0.329, blue: 0.345, alpha: 0.65).cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        return containerView
    }()
    
    //MARK: TitleLabel
    let titleLabel: UILabel = {
        let titlelabel = UILabel()
        titlelabel.textAlignment = .center
        titlelabel.textColor = UIColor(red: 0.871, green: 0.871, blue: 0.871, alpha: 1)
        
        let fontSize: CGFloat = DeviceType.iPhoneSE ? 17 : 20
        titlelabel.font = .systemRegular(size: fontSize)
        titlelabel.numberOfLines = 0
        titlelabel.adjustsFontSizeToFitWidth = true
        titlelabel.minimumScaleFactor = 0.9
        titlelabel.lineBreakMode = .byTruncatingTail
        titlelabel.translatesAutoresizingMaskIntoConstraints = false
        return titlelabel
    }()
    
    //MARK: ActionButtons
    let actionButtonNo: CustomButton = {
        let actionButton = CustomButton()
        actionButton.layer.cornerRadius = 20
        actionButton.layer.maskedCorners = [.layerMinXMaxYCorner]
        actionButton.setTitleColor(.popUpContainer, for: .highlighted)
        actionButton.backgroundColor = .none
        actionButton.setTitle(.no, for: .normal)
        actionButton.setTitleColor(.alertActionButonTitleColor, for: .normal)
        let fontSize: CGFloat = DeviceType.iPhoneSE ? 14 : 17
        actionButton.titleLabel?.font = .systemRegular(size: fontSize)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        
        return actionButton
    }()
    
    let actionButtonYes: CustomButton = {
        let actionButton = CustomButton()
        actionButton.layer.cornerRadius = 20
        actionButton.layer.maskedCorners = [.layerMaxXMaxYCorner]
        actionButton.backgroundColor = .none
        actionButton.setTitle(.yes, for: .normal)
        actionButton.setTitleColor(.alertActionButonTitleColor, for: .normal)
        actionButton.setTitleColor(.popUpContainer, for: .highlighted)
        
        let fontSize: CGFloat = DeviceType.iPhoneSE ? 14 : 17
        actionButton.titleLabel?.font = .systemRegular(size: fontSize)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        
        return actionButton
    }()
    
    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    
    var root: UIViewController!
    
    public func setRoot(root: UIViewController) {
        self.root = root
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        configureContainerView()
        configureTitleLabel()
        configureActionButtonNo()
        configureActionButtonYes()
    }
    
    func configureContainerView() {
        view.addSubview(containerView)
        let heightConstant: CGFloat = DeviceType.iPhoneSE ? 137 : 173
        let leadingConstant: CGFloat = DeviceType.iPhoneSE ? 24 : 36
        
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: heightConstant),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingConstant),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -leadingConstant)
        ])
        
        let strokeHorizontal: UIView = {
            let stroke = UIView()
            stroke.bounds = containerView.bounds.insetBy(dx: -0.4, dy: -0.4)
            stroke.center = containerView.center
            containerView.addSubview(stroke)
            containerView.bounds = containerView.bounds.insetBy(dx: -0.4, dy: -0.4)
            stroke.layer.borderWidth = 0.8
            stroke.layer.borderColor = UIColor(red: 0.329, green: 0.329, blue: 0.345, alpha: 0.65).cgColor
            stroke.translatesAutoresizingMaskIntoConstraints = false
            return stroke
        }()
        
        let strokeHorizontalTopConstant: CGFloat = DeviceType.iPhoneSE ? 96.75 : 130
        let strokeHorizontalHeighConstant: CGFloat = 1

        NSLayoutConstraint.activate([
            strokeHorizontal.topAnchor.constraint(equalTo: containerView.topAnchor, constant: strokeHorizontalTopConstant),
            strokeHorizontal.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            strokeHorizontal.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            strokeHorizontal.heightAnchor.constraint(equalToConstant: strokeHorizontalHeighConstant)
        ])
        
        let strokeVertical: UIView = {
            let stroke = UIView()
            stroke.bounds = containerView.bounds.insetBy(dx: -0.4, dy: -0.4)
            stroke.center = containerView.center
            containerView.addSubview(stroke)
            containerView.bounds = containerView.bounds.insetBy(dx: -0.4, dy: -0.4)
            stroke.layer.borderWidth = 0.8
            stroke.layer.borderColor = UIColor(red: 0.329, green: 0.329, blue: 0.345, alpha: 0.65).cgColor
            stroke.translatesAutoresizingMaskIntoConstraints = false
            return stroke
        }()
        
        let strokeVerticalHeighConstant: CGFloat = DeviceType.iPhoneSE ? 40 : 43


        NSLayoutConstraint.activate([
            strokeVertical.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            strokeVertical.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            strokeVertical.widthAnchor.constraint(equalToConstant: 1),
            strokeVertical.heightAnchor.constraint(equalToConstant: strokeVerticalHeighConstant)
        ])
    }
    
    func configureTitleLabel() {
        titleLabel.text = .stopAlignment
        containerView.addSubview(titleLabel)
        let topConstant: CGFloat = DeviceType.iPhoneSE ? 30 : 48
        let trailingConstant: CGFloat = DeviceType.iPhoneSE ? -11.5 : -14
        let leadingConstant: CGFloat = DeviceType.iPhoneSE ? 11.5 : 14

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: topConstant),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: trailingConstant),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: leadingConstant),
        ])
    }
    
    func configureActionButtonNo() {
        containerView.addSubview(actionButtonNo)
        actionButtonNo.addTarget(self , action: #selector(dismissVC), for: .touchUpInside)

        let heighConstant: CGFloat = DeviceType.iPhoneSE ? 40 : 43
        
        NSLayoutConstraint.activate([
            actionButtonNo.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            actionButtonNo.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            actionButtonNo.trailingAnchor.constraint(equalTo: containerView.centerXAnchor),
            actionButtonNo.heightAnchor.constraint(equalToConstant: heighConstant)
        ])
    }
    
    func configureActionButtonYes() {
        containerView.addSubview(actionButtonYes)
        actionButtonYes.addTarget(self , action: #selector(self.escapeOnTap), for: .touchUpInside)

        let heighConstant: CGFloat = DeviceType.iPhoneSE ? 40 : 43

        NSLayoutConstraint.activate([
            actionButtonYes.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            actionButtonYes.leadingAnchor.constraint(equalTo: containerView.centerXAnchor),
            actionButtonYes.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            actionButtonYes.heightAnchor.constraint(equalToConstant: heighConstant)
        ])
    }
    
    @objc func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func escapeOnTap (sender: UIButton!) {
        dismiss(animated: false, completion: nil)
        self.root.navigationController?.popToRootViewController(animated: true)
    }
}
