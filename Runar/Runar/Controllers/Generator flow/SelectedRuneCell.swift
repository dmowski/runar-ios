//
//  SelectedRuneCell.swift
//  Runar
//
//  Created by George Stupakov on 25/05/2022.
//

import UIKit

//MARK: Constants
private extension CGFloat {
    static let cellBorderWidth = 1.0
    static let cellCornerRadius = 14.0
    static let cellWidthAnchor = 56.0
    static let cellHeightAnchor = 74.0
    
    static let cellIndexWidthAnchor = 14.0
    static let cellIndexTopAnchor = 14.0
    
    static let runeImageWidthAnchor = 88.0
    static let runeImageHeightAnchor = 109.0
    
    static let runeNameBottomAnchor = 5.0
}

//MARK: Add to color common class
private extension UIColor {
    static let cellBackgroundColor = UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36)
    static let textColor = UIColor(red: 1, green: 0.917, blue: 0.792, alpha: 0.6)
}

class SelectedRuneCell: UICollectionViewCell {

    public var enabled: Bool = true
    public var indexPath: IndexPath = IndexPath()
    public var selectedRune: SelectedRuneModel?
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    let cell: UILabel = {
        let cell: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 45, height: 63))
        cell.layer.backgroundColor = UIColor.cellBackgroundColor.cgColor
        cell.layer.borderWidth = .cellBorderWidth
        cell.layer.cornerRadius = .cellCornerRadius
        cell.layer.borderColor = UIColor.textColor.cgColor
        return cell
    }()
    
    let cellIndex: UILabel = {
        let cellIndex: UILabel = UILabel()
        cellIndex.textColor = .textColor
        cellIndex.font = .amaticBold(size: 36)
        cellIndex.textAlignment = .center
        return cellIndex
    }()
    
    let runeImage: UIButton = {
        let runeImage = UIButton()
        
        runeImage.contentMode = .scaleAspectFill
        runeImage.isHidden = true
        runeImage.isUserInteractionEnabled = true
        
        return runeImage
    }()
    
    let runeName: UILabel = {
        let runeName = UILabel()
        
        runeName.textColor = .textColor
        runeName.font = .systemRegular(size: 12)
        runeName.isHidden = true
        
        return runeName
    }()
    
    private func setupViews() {
        backgroundColor = .clear
        
        addSubview(cell)
        cell.snp.makeConstraints { make in
            make.width.equalTo(CGFloat.cellWidthAnchor)
            make.height.equalTo(CGFloat.cellHeightAnchor)
            make.centerX.centerY.equalToSuperview()
        }
        
        cell.addSubview(cellIndex)
        cellIndex.snp.makeConstraints { make in
            make.width.equalTo(CGFloat.cellIndexWidthAnchor)
            make.top.equalTo(cell.snp.top).offset(CGFloat.cellIndexTopAnchor)
            make.bottom.equalTo(cell.snp.bottom)
            make.centerX.equalTo(cell.snp.centerX)
        }
        
        addSubview(runeImage)
        runeImage.snp.makeConstraints { make in
            make.width.equalTo(CGFloat.runeImageWidthAnchor)
            make.height.equalTo(CGFloat.runeImageHeightAnchor)
            make.centerX.centerY.equalToSuperview()
        }
        
        addSubview(runeName)
        runeName.snp.makeConstraints { make in
            make.bottom.equalTo(runeImage.snp.bottom).offset(CGFloat.runeNameBottomAnchor)
            make.centerX.equalToSuperview()
        }
    }
    
    public func setIndex(_ index: IndexPath) {
        indexPath = index
        cellIndex.attributedText = UILabel.getAttributedText(text: String(index.row + 1), lineHeight: 0.7)
    }
           
    public func selectRune(_ rune: SelectedRuneModel) {
        selectedRune = rune
        runeImage.startSparksAnimation(top: -50)
        isSelected = true
        toggleRune()
    }
    
    public func deselectRune() {
        selectedRune = nil
        isSelected = false
        toggleRune()
    }

    public func toggleRune() {
        runeImage.isHidden = !isSelected
        runeName.isHidden = !isSelected
        cell.isHidden = isSelected
        cellIndex.isHidden = isSelected
        
        runeImage.setBackgroundImage(selectedRune?.image ?? .none, for: .normal)
        runeName.text = selectedRune?.title ?? .none
    }
}
