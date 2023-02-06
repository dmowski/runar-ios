//
//  RuneCollectionViewModel.swift
//  Runar
//
//  Created by Maksim Harbatsevich on 10/5/21.
//

import UIKit

public class SelectRuneCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate {
    
    private let cellId = "selectRuneCell"
    private var selectDeligate: ((SelectRuneCell) -> Void)?
    internal var selectedRunesCount: Int = 0
    private var runes: [SelectRuneCell] = []

    override public init(frame: CGRect, collectionViewLayout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: collectionViewLayout)
        setupViews()
        setupRunes()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
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
            let cell = dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SelectRuneCell
            
            if (cell.model == nil) {
                cell.setRune(rune, indexPath)
                cell.runeImage.addTarget(self, action: #selector(selectRune(runeImage:)), for: .touchUpInside)
            }
            
            runes.append(cell)
        }
    }
    
    func setSelectHandler(_ action: @escaping (SelectRuneCell) -> Void) {
        selectDeligate = action
    }
        
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MemoryStorage.GenerationRunes.count
    }
                
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return runes[indexPath.row]
    }
    
    public func deselectRune(at index: IndexPath) {
        let cell = runes[index.row]
        
        cell.deselectRune()
        
        selectedRunesCount -= 1
    }
    
    @objc func selectRune(runeImage: UIButton) {
        if (selectedRunesCount < 3) {
            guard let cell = runeImage.superview as? SelectRuneCell else { return }
            selectDeligate?(cell)
        }
    }
    
    func selectRune(rune: SelectRuneCell) {
        rune.selectRune()
        selectedRunesCount += 1
    }
    
    func getRune(at index: Int) -> SelectRuneCell {
        return runes[index]
    }
}
