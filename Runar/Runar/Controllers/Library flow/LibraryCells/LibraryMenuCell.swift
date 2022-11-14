//
//  LibraryMenuCell.swift
//  Runar
//
//  Created by Maksim Harbatsevich on 6/7/21.
//

import UIKit

public class LibraryMenuCell: LibraryCell {
    
    //MARK: - Funcs
    public override func bind(node: LibraryCoreData) -> Void {

        addArrow()
        
        if node.imageUrl != "" {
            bindTextLabel(text: node.title, font: UIFont.createMedium(withLowSize: 17, withHighSize: 22))
            textLabel?.snp.makeConstraints({ make in
                if !DeviceType.iPhoneSE && !DeviceType.isIPhone678 {
                    make.leading.equalToSuperview().offset(100)
                    make.top.equalToSuperview().offset(48)
                    make.trailing.equalToSuperview().offset(-56)
                    make.bottom.equalToSuperview().offset(-39)
                } else {
                    make.leading.equalToSuperview().offset(80)
                    make.top.equalToSuperview().offset(39)
                    make.trailing.equalToSuperview().offset(-50)
                    make.bottom.equalToSuperview().offset(-30)
                }
            })
            
            bindImageView(url: node.imageUrl!)
            imageView?.snp.makeConstraints({ make in
                if !DeviceType.iPhoneSE && !DeviceType.isIPhone678 {
                    make.leading.equalToSuperview().offset(4)
                    make.top.equalToSuperview().offset(10)
                    make.bottom.equalToSuperview()
                    make.height.equalTo(102)
                    make.width.equalTo(79)
                } else {
                    make.leading.equalToSuperview().offset(4)
                    make.top.equalToSuperview().offset(10)
                    make.bottom.equalToSuperview()
                    make.height.equalTo(80)
                    make.width.equalTo(60)
                }
            })
        } else {
            bindTextLabel(text: node.title, font: UIFont.createMedium(withLowSize: 15, withHighSize: 18))
            textLabel?.snp.makeConstraints({ make in
                if !DeviceType.iPhoneSE && !DeviceType.isIPhone678 {
                    make.leading.equalToSuperview().offset(16)
                    make.top.equalToSuperview().offset(24)
                    make.trailing.equalToSuperview().offset(-30)
                    make.bottom.equalToSuperview().offset(-24)
                } else {
                    make.leading.equalToSuperview().offset(16)
                    make.top.equalToSuperview().offset(24)
                    make.trailing.equalToSuperview().offset(-30)
                    make.bottom.equalToSuperview().offset(-24)
                }
            })
        }
    }
}
