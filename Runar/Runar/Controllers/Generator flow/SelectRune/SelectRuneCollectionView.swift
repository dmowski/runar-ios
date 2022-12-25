//
//  RuneCollectionViewModel.swift
//  Runar
//
//  Created by Maksim Harbatsevich on 10/5/21.
//

import UIKit
import CoreData

public class SelectRuneCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate {
    
    private let cellId = "existingCellId"
    private var selectDeligate: ((SelectRuneCell) -> Void)?
    internal var selectedRunesCount: Int = 0
    private var runes: [SelectRuneCell] = []
    var selectedCells: [SelectedRuneCell] = []
    var generatorSavedInCoreData: Bool = false
    private lazy var fetchedResultsController: NSFetchedResultsController<GeneratorRuneCoreDataModel> = {
        let fetchRequest: NSFetchRequest<GeneratorRuneCoreDataModel> = GeneratorRuneCoreDataModel.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]

        let controller = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                    managedObjectContext: CoreDataManager.shared.persistentContainerForGenerator.viewContext,
                                                    sectionNameKeyPath: nil, cacheName: nil)
        return controller
    }()
    
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

    func fetchDataFromCoreData() {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("###\(#function): Failed to performFetch: \(error)")
        }

        let objects = fetchCountRunesFromCoreData()
        guard objects > 0 else { return }
        generatorSavedInCoreData = true
    }

    func fetchCountRunesFromCoreData() -> Int {
        guard let objects = fetchedResultsController.fetchedObjects else { return 0 }
        return objects.count
    }
    
    func setupRunes() {
        runes.removeAll()
        fetchDataFromCoreData()
        guard let generatorNodes = fetchedResultsController.fetchedObjects else { return }
        for (index, rune) in generatorNodes.enumerated() {

            let indexPath = IndexPath(row: index, section: 1)
            let cell = self.dequeueReusableCell(withReuseIdentifier: self.cellId, for: indexPath) as! SelectRuneCell
            
            if (cell.model == nil) {
                cell.setRune(rune, indexPath)
                cell.runeImage.addTarget(self, action: #selector(self.selectRune(runeImage:)), for: .touchUpInside)
                selectedCells.forEach { selectedCell in
                    guard selectedCell.runeName.text == cell.model?.title else { return }
                    cell.runeImage.isEnabled = false
                }
            }
            
            if SubscriptionManager.freeSubscription == true {
                if generatorSavedInCoreData || generatorNodes.count > 7 {
                    for indexUnavailable in 7..<generatorNodes.count {
                        if indexPath == IndexPath(row: indexUnavailable, section: 1) {
                            cell.unavailableRune()
                        }
                    }
                }
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
        return fetchCountRunesFromCoreData()
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
    
    func selectRune(rune: SelectRuneCell) {
        rune.selectRune()
        self.selectedRunesCount += 1
    }
    
    func getRune(at index: Int) -> SelectRuneCell {
        return self.runes[index]
    }
}
