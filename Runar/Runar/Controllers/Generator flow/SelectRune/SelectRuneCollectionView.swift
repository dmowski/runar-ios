//
//  RuneCollectionViewModel.swift
//  Runar
//
//  Created by Maksim Harbatsevich on 10/5/21.
//

import UIKit

public class SelectRuneCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate {
    private let cellId = "existingCellId"
    private var selectDeligate: ((SelectRuneCell) -> Void)?
    internal var selectedRunesCount: Int = 0
    private var runes: [SelectRuneCell] = []
    
    override public init(frame: CGRect, collectionViewLayout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: collectionViewLayout)
        setupViews()
        setupRunes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = .clear
        
        dataSource = self
        delegate = self
        allowsMultipleSelection = true
        
        register(SelectRuneCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func setupRunes() {
        for (index, rune) in MemoryStorage.GenerationRunes.enumerated() {
            let indexPath = IndexPath(row: index, section: 1)
            let cell = self.dequeueReusableCell(withReuseIdentifier: self.cellId, for: indexPath) as! SelectRuneCell
            
            if (cell.model == nil){
                cell.setRune(rune, indexPath)
                cell.runeImage.addTarget(self, action: #selector(self.selectRune(runeImage:)), for: .touchUpInside)
            }
            
            runes.append(cell)
        }
    }
    
    func setSelectHandler(_ action: @escaping (SelectRuneCell) -> Void) {
        self.selectDeligate = action
    }
        
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MemoryStorage.GenerationRunes.count
    }
                
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return self.runes[indexPath.row]
    }
    
    public func deselectRune(at index: IndexPath) {
        let cell = self.runes[index.row]
        
        cell.deselectRune()
        
        self.selectedRunesCount -= 1
    }
    
    @objc func selectRune(runeImage: UIButton) {
        if (self.selectedRunesCount < 3) {
            let cell = runeImage.superview as! SelectRuneCell
            
            self.selectDeligate!(cell)
        }
    }
    
    func selectRune(rune: SelectRuneCell){
        rune.selectRune()
        self.selectedRunesCount += 1
    }
    
    func getRune(at index: Int) -> SelectRuneCell {
        return self.runes[index]
    }
}
