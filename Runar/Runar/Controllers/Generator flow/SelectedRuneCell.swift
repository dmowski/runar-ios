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
        cell.layer.backgroundColor = UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36).cgColor
        cell.layer.borderWidth = CGFloat.cellBorderWidth
        cell.layer.cornerRadius = CGFloat.cellCornerRadius
        cell.layer.borderColor = UIColor(red: 1, green: 0.917, blue: 0.792, alpha: 0.6).cgColor
        return cell
    }()
    
    let cellIndex: UILabel = {
        let cellIndex: UILabel = UILabel()
        cellIndex.textColor = UIColor(red: 1, green: 0.917, blue: 0.792, alpha: 1)
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
        
        runeName.textColor = UIColor(red: 1, green: 0.917, blue: 0.792, alpha: 1)
        runeName.font = .systemRegular(size: 12)
        runeName.isHidden = true
        
        return runeName
    }()
    
    private func setupViews() {
        backgroundColor = .clear
        
        addSubview(cell)
        cell.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cell.widthAnchor.constraint(equalToConstant: CGFloat.cellWidthAnchor),
            cell.heightAnchor.constraint(equalToConstant: CGFloat.cellHeightAnchor),
            cell.centerXAnchor.constraint(equalTo: centerXAnchor),
            cell.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        cell.addSubview(cellIndex)
        cellIndex.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellIndex.widthAnchor.constraint(equalToConstant: CGFloat.cellIndexWidthAnchor),
            cellIndex.topAnchor.constraint(equalTo: cell.topAnchor, constant: CGFloat.cellIndexTopAnchor),
            cellIndex.bottomAnchor.constraint(equalTo: cell.bottomAnchor),
            cellIndex.centerXAnchor.constraint(equalTo: cell.centerXAnchor)
        ])
        
        addSubview(runeImage)
        runeImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            runeImage.widthAnchor.constraint(equalToConstant: CGFloat.runeImageWidthAnchor),
            runeImage.heightAnchor.constraint(equalToConstant: CGFloat.runeImageHeightAnchor),
            runeImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            runeImage.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        addSubview(runeName)
        runeName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            runeName.bottomAnchor.constraint(equalTo: runeImage.bottomAnchor, constant: CGFloat.runeNameBottomAnchor),
            runeName.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
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
