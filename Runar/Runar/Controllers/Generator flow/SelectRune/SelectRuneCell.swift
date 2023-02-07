//
//  SelectRuneCell.swift
//  Runar
//
//  Created by George Stupakov on 25/05/2022.
//

import UIKit

//MARK: Constants
private extension CGFloat {
    static let runeImageHeightAnchor = 78.0
    static let runeImageWidthAnchor = 66.0
}

class SelectRuneCell: UICollectionViewCell {

    public var model: GenerationRuneModel?
    public var indexPath: IndexPath = IndexPath()
    public var isUnavailableRune: Bool = false
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    let runeImage: UIButton = {
        let runeImage = UIButton()
        
        runeImage.contentMode = .scaleAspectFill
        
        return runeImage
    }()
    
    private func setupViews() {

        backgroundColor = .clear
        addSubview(runeImage)
        runeImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            runeImage.heightAnchor.constraint(equalToConstant: CGFloat.runeImageHeightAnchor),
            runeImage.widthAnchor.constraint(equalToConstant: CGFloat.runeImageWidthAnchor),
            runeImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            runeImage.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    public func setRune(_ rune: GenerationRuneModel, _ indexPath: IndexPath) {
        model = rune
        self.indexPath = indexPath

        runeImage.setBackgroundImage(rune.imageInfo.uiImage, for: .normal)
    }
    
    public func selectRune() {
        isSelected = true
        toggleState()
    }
    
    public func deselectRune() {
        isSelected = false
        toggleState()
    }
    
    public func toggleState() {
        runeImage.isEnabled = !self.isSelected
    }
}
