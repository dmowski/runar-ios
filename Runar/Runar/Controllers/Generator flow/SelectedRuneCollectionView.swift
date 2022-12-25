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
        clipsToBounds = false
        
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
        
    @objc func deselectRune(sender: UIButton) {
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
