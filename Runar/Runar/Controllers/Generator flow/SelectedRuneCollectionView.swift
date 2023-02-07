//
//  SelectedRunesView.swift
//  Runar
//
//  Created by Maksim Harbatsevich on 10/3/21.
//

import UIKit

public class SelectedRuneCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate {

    private let cellId = "selectedRuneCell"
    private var deselectRuneHandler: ((IndexPath) -> Void)?
    
    override public init(frame: CGRect, collectionViewLayout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: collectionViewLayout)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupViews(){
        backgroundColor = .clear
        
        dataSource = self
        delegate = self
        allowsMultipleSelection = true
        allowsSelection = true
        clipsToBounds = false
        
        register(SelectedRuneCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func setDeselectHandler(_ handler: @escaping (IndexPath) -> Void){
        deselectRuneHandler = handler
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? SelectedRuneCell else { return UICollectionViewCell() }
        
        cell.setIndex(indexPath)
        cell.runeImage.addTarget(self, action: #selector(self.deselectRune), for: .touchUpInside)
        
        return cell
    }
    
    public func hasSelectedRunes() -> Bool {
        visibleCells.contains { (cell: UICollectionViewCell) -> Bool in
            return cell.isSelected
        }
    }
        
    @objc func deselectRune(sender: UIButton) {
        guard let cell = sender.superview as? SelectedRuneCell,
              let index = cell.selectedRune?.index else { return }
        
        cell.deselectRune()
        deselectRuneHandler?(index)
    }
    
    public func deselectAll() {
        
        guard let visibleCells = self.visibleCells as? [SelectedRuneCell] else { return }
        for cell in visibleCells {
            if cell.isSelected {
                guard let index = cell.selectedRune?.index else { return }
                cell.deselectRune()
                deselectRuneHandler?(index)
            }
        }
    }
}
