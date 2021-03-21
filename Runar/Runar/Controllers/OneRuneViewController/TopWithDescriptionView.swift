//
//  TopWithDescriptionView.swift
//  Runar
//
//  Created by Юлия Лопатина on 21.03.21.
//

import UIKit

final class TopWithDescriptionView: UIView {

    override init(frame: CGRect) {
        super.init(frame:frame)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    convenience init(runeType: RuneType, runeTime: String) {
        self.init(frame: .zero)
        topLineView = TopLineView(runeType: runeType, runeTime: runeTime)
        descriptionView = DescriptionView(runeType: runeType)
        configureView()
        setUpCloseConstr()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    private var topLineView: TopLineView?
    private var descriptionView: DescriptionView?
    private var runeType: RuneType?
    private var runeTime: String?
    var close: (()->())?

    private func configureView() {
        guard let topLineView = topLineView,
              let descriptionView = descriptionView else {return}
        self.addSubview(topLineView)
        self.addSubview(descriptionView)
        NSLayoutConstraint.activate([
            topLineView.topAnchor.constraint(equalTo: self.topAnchor),
            topLineView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            topLineView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            topLineView.heightAnchor.constraint(equalToConstant: 153.heightDependent()),
            
            descriptionView.topAnchor.constraint(equalTo: topLineView.bottomAnchor),
            descriptionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            descriptionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            descriptionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24)
        ])
    }
    
    //MARK: - CloseButton
    
    private var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(Assets.escape.image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonOnClose), for: .touchUpInside)
        return button
    }()
    
    @objc private func buttonOnClose() {
        guard let close = close else {return}
        close()
    }
    
    private func setUpCloseConstr() {
        self.addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 10.heightDependent()),
            closeButton.heightAnchor.constraint(equalToConstant: 48.heightDependent()),
            closeButton.widthAnchor.constraint(equalToConstant: 48.heightDependent()),
            closeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10.heightDependent())
        ])
    }
}
