//
//  TopWithDescriptionView.swift
//  Runar
//
//  Created by Юлия Лопатина on 21.03.21.
//

import UIKit

final class TopWithDescriptionView: UIView {
    
    // MARK: Constants
    
    let trailingLeadingAnchorDescriptionView = 24
    let topTrailingCloseButton = 10
    let heightWidthCloseButton = 48
    
    private var topLineView: TopLineView?
    private var descriptionView: DescriptionView?
    private var runeType: RuneType?
    private var runeTime: String?
    private var luck: String?
    var close: (()->())?
    
    private var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(Assets.escape.image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    convenience init(runeType: RuneType, runeTime: String, luck: String) {
        self.init(frame: .zero)
        topLineView = TopLineView(runeType: runeType, runeTime: runeTime, luck: luck)
        descriptionView = DescriptionView(runeType: runeType)
        configureView()
        setUpCloseConstr()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        guard let topLineView = topLineView,
              let descriptionView = descriptionView else {return}
        self.addSubview(topLineView)
        self.addSubview(descriptionView)

        topLineView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        descriptionView.snp.makeConstraints { make in
            make.top.equalTo(topLineView.snp.bottom)
            make.trailing.leading.equalToSuperview().inset(trailingLeadingAnchorDescriptionView)
            make.bottom.equalToSuperview()
        }
    }
    
    private func setUpCloseConstr() {
        self.addSubview(closeButton)
        closeButton.addTarget(self, action: #selector(buttonOnClose), for: .touchUpInside)

        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(topTrailingCloseButton)
            make.height.width.equalTo(heightWidthCloseButton)
            make.trailing.equalToSuperview().inset(topTrailingCloseButton)
        }
    }
    
    @objc private func buttonOnClose() {
        guard let close = close else {return}
        close()
    }
}
