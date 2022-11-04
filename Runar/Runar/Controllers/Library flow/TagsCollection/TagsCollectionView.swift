//
//  TagsCollectionView.swift
//  Runar
//
//  Created by bowtie on 20.06.2022.
//

import UIKit
import KTCenterFlowLayout

class TagsCollectionView: UICollectionView {

    var cells = [String]()
    
    init() {
        let layout = KTCenterFlowLayout()
        layout.estimatedItemSize = KTCenterFlowLayout.automaticSize
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        super.init(frame: .zero, collectionViewLayout: layout)
        
        dataSource = self
        register(TagsCell.self, forCellWithReuseIdentifier: TagsCell.reuseId)
        
        backgroundColor = .clear
        contentInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if !(__CGSizeEqualToSize(bounds.size,self.intrinsicContentSize)){
            self.invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        return contentSize
    }
}

extension TagsCollectionView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cells.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: TagsCell.reuseId, for: indexPath) as? TagsCell else {
            return UICollectionViewCell(frame: .zero)
        }
        cell.runeTag.text = cells[indexPath.row].capitalized
        return cell
    }
}
