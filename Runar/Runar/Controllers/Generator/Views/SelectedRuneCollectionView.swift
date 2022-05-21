//
//  SelectedRunesView.swift
//  Runar
//
//  Created by Maksim Harbatsevich on 10/3/21.
//

import UIKit

public class SelectedRuneCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate {
    private let cellId = "selectedCellId"
    private var deselectRuneHandler: ((IndexPath) -> Void)?
    
    override public init(frame: CGRect, collectionViewLayout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: collectionViewLayout)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        backgroundColor = .clear
        
        dataSource = self
        delegate = self
        allowsMultipleSelection = true
        allowsSelection = true
        
        register(SelectedRuneCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func setDeselectHandler(_ handler: @escaping (IndexPath) -> Void){
        self.deselectRuneHandler = handler
    }
           
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    public func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return false
    }
        
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SelectedRuneCell
        
        cell.setIndex(indexPath)
        cell.runeImage.addTarget(self, action: #selector(self.deselectRune), for: .touchUpInside)
        
        return cell
    }
    
    public func hasSelectedRunes() -> Bool {
        self.visibleCells.contains { (cell: UICollectionViewCell) -> Bool in
            return cell.isSelected
        }
    }
        
    @IBAction func deselectRune(sender: UIButton) {
        let cell = sender.superview as! SelectedRuneCell
        let index = cell.selectedRune!.index
        
        cell.deselectRune()
        
        self.deselectRuneHandler!(index)
    }
    
    public func deselectAll() {
        for cell in (self.visibleCells as! [SelectedRuneCell]) {
            if cell.isSelected {
                let index = cell.selectedRune!.index
                cell.deselectRune()
                self.deselectRuneHandler!(index)
            }
        }
    }
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
        fatalError("init(coder:) has not been implemented")
    }
    
    let cell: UILabel = {
        let cell: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 57, height: 77))
        cell.layer.backgroundColor = UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36).cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 14
        cell.layer.borderColor = UIColor(red: 1, green: 0.917, blue: 0.792, alpha: 0.6).cgColor
        return cell
    }()
    
    let cellIndex: UILabel = {
        let cellIndex: UILabel = UILabel()
        cellIndex.textColor = UIColor(red: 1, green: 0.917, blue: 0.792, alpha: 1)
        cellIndex.font = FontFamily.AmaticSC.bold.font(size: 38)
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
        
        runeName.textColor = UIColor(red: 1, green: 0.817, blue: 0.792, alpha: 1)
        runeName.font = FontFamily.SFProDisplay.regular.font(size: 12)
        runeName.isHidden = true
        
        return runeName
    }()
    
    private func setupViews(){
        backgroundColor = .clear
        
        addSubview(cell)
        cell.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cell.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            cell.heightAnchor.constraint(equalToConstant: 77),
            cell.widthAnchor.constraint(equalToConstant: 57),
            cell.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        cell.addSubview(cellIndex)
        cellIndex.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellIndex.widthAnchor.constraint(equalToConstant: 14),
            cellIndex.topAnchor.constraint(equalTo: cell.topAnchor, constant: 14),
            cellIndex.bottomAnchor.constraint(equalTo: cell.bottomAnchor),
            cellIndex.centerXAnchor.constraint(equalTo: cell.centerXAnchor)
        ])
        
        addSubview(runeImage)
        runeImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            runeImage.topAnchor.constraint(equalTo: topAnchor),
            runeImage.heightAnchor.constraint(equalToConstant: 102),
            runeImage.widthAnchor.constraint(equalToConstant: 81),
            runeImage.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        addSubview(runeName)
        runeName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            runeName.topAnchor.constraint(equalTo: runeImage.bottomAnchor),
            runeName.bottomAnchor.constraint(equalTo: bottomAnchor),
            runeName.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    public func setIndex(_ index: IndexPath) {
        self.indexPath = index
        cellIndex.attributedText = UILabel.getAttributedText(text: String(index.row + 1), lineHeight: 0.7)
    }
           
    public func selectRune(_ rune: SelectedRuneModel) {
        self.selectedRune = rune
        
        self.isSelected = true
        
        self.toggleRune()
    }
    
    public func deselectRune(){
        self.selectedRune = nil
        
        self.isSelected = false
        
        self.toggleRune()
    }

    public func toggleRune() {
        self.runeImage.isHidden = !self.isSelected
        self.runeName.isHidden = !self.isSelected
        self.cell.isHidden = self.isSelected
        self.cellIndex.isHidden = self.isSelected
        
        self.runeImage.setBackgroundImage(self.selectedRune?.image ?? .none, for: .normal)
        self.runeName.text = self.selectedRune?.title ?? .none
    }
}

class SelectedRuneModel {
    let title: String
    let image: UIImage
    let index: IndexPath
    let id: String
    
    init(title: String, image: UIImage, index: IndexPath, id: String) {
        self.title = title
        self.image = image
        self.index = index
        self.id = id
    }
}
