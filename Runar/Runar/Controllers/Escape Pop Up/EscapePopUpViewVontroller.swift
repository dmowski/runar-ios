//
//  EscapePopUpViewVontroller.swift
//  Runar
//
//  Created by Roman Kovtun on 29.03.21.
//

import UIKit

extension String {
    static let yes = "Да"
    static let no = "Нет"
    static let stopAlignment = "Завершить расклад?"
}

extension UIColor {
    static let alertActionButonTitleColor = UIColor(red: 0.937, green: 0.804, blue: 0.576, alpha: 1)
}

class EscapePopUpViewController: UIViewController {
    
    //MARK: Containerview
    let containerView: UIView = {
        let containerView = UIView()
        
        containerView.backgroundColor = UIColor(red: 0.118, green: 0.118, blue: 0.118, alpha: 0.75)
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
        
        let fontConstant: CGFloat = DeviceType.iPhoneSE ? 17 : 20
        titlelabel.font = FontFamily.SFProDisplay.regular.font(size: fontConstant)
        
        titlelabel.adjustsFontSizeToFitWidth = true
        titlelabel.minimumScaleFactor = 0.9
        titlelabel.lineBreakMode = .byTruncatingTail
        titlelabel.translatesAutoresizingMaskIntoConstraints = false
        return titlelabel
    }()
    
    //MARK: ActionButtons
    let actionButtonNo: UIButton = {
        let actionButton = UIButton()
        actionButton.frame = .zero
        actionButton.backgroundColor = .none
        actionButton.setTitle(.no, for: .normal)
        actionButton.setTitleColor(.alertActionButonTitleColor, for: .normal)
        
        let fontConstant: CGFloat = DeviceType.iPhoneSE ? 14 : 17
        actionButton.titleLabel?.font = FontFamily.SFProDisplay.regular.font(size: fontConstant)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        
        return actionButton
    }()
    
    let actionButtonYes: UIButton = {
        let actionButton = UIButton()
        actionButton.frame = .zero
        actionButton.backgroundColor = .none
        actionButton.setTitle(.yes, for: .normal)
        actionButton.setTitleColor(.alertActionButonTitleColor, for: .normal)
        
        let fontConstant: CGFloat = DeviceType.iPhoneSE ? 14 : 17
        actionButton.titleLabel?.font = FontFamily.SFProDisplay.regular.font(size: fontConstant)
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
        
        let strokeVerticalHeighConstant: CGFloat = DeviceType.iPhoneSE ? 39 : 42


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
        let topConstant: CGFloat = DeviceType.iPhoneSE ? 40.01 : 55
        let trailingConstant: CGFloat = DeviceType.iPhoneSE ? -11.5 : -14
        let leadingConstant: CGFloat = DeviceType.iPhoneSE ? 11.5 : 14
        let bottomConstant: CGFloat = DeviceType.iPhoneSE ? -72.3 : -87

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: topConstant),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: trailingConstant),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: leadingConstant),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: bottomConstant)
        ])
        
    }
    
    func configureActionButtonNo() {
        containerView.addSubview(actionButtonNo)
        actionButtonNo.addTarget(self , action: #selector(dismissVC), for: .touchUpInside)

        let heighConstant: CGFloat = DeviceType.iPhoneSE ? 22.3 : 28
        let trailingConstant: CGFloat = DeviceType.iPhoneSE ? -141.91 : -181.16
        let leadingConstant: CGFloat = DeviceType.iPhoneSE ? 6.42 : 5.06
        let bottomConstant: CGFloat = DeviceType.iPhoneSE ? -9.37 : -8
        
        NSLayoutConstraint.activate([
            actionButtonNo.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: bottomConstant),
            actionButtonNo.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: leadingConstant),
            actionButtonNo.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: trailingConstant),
            actionButtonNo.heightAnchor.constraint(equalToConstant: heighConstant)
        ])
    }
    
    func configureActionButtonYes() {
        containerView.addSubview(actionButtonYes)
        actionButtonYes.addTarget(self , action: #selector(self.escapeOnTap), for: .touchUpInside)

        let heighConstant: CGFloat = DeviceType.iPhoneSE ? 22.3 : 28
        let trailingConstant: CGFloat = DeviceType.iPhoneSE ? -6.42 : -11.06
        let leadingConstant: CGFloat = DeviceType.iPhoneSE ? 141.19 : 175.16
        let bottomConstant: CGFloat = DeviceType.iPhoneSE ? -9.37 : -8
        
        NSLayoutConstraint.activate([
            actionButtonYes.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: bottomConstant),
            actionButtonYes.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: leadingConstant),
            actionButtonYes.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: trailingConstant),
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
