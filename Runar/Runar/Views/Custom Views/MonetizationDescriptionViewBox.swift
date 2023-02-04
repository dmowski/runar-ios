//
//  MonetizationDescriptionViewBox.swift
//  Runar
//
//  Created by George Stupakov on 21/07/2022.
//

import UIKit
import SnapKit

public class MonetizationDescriptionViewBox: UIView {
    
    internal let checkbox = UIImageView()
    internal let label = UILabel()
    
    init(text: String) {
        super.init(frame: .zero)

        self.label.text = text
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {

        setupImageCheckbox()
        setupLabel()
    }

    private func setupImageCheckbox() {

        checkbox.image = Assets.checkBox.image
        checkbox.contentMode = .scaleAspectFill
        addSubview(checkbox)
        checkbox.snp.makeConstraints { make in
            make.size.equalTo(22)
        }
    }
    
    private func setupLabel() {

        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = .systemRegular(size: 15)
        label.textAlignment = .left
        addSubview(label)
        label.snp.makeConstraints { make in
            make.leading.equalTo(checkbox.snp.trailing).offset(11)
            make.centerY.equalTo(checkbox)
        }
    }
}
