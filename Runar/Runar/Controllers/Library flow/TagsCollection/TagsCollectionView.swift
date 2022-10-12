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
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        super.init(frame: .zero, collectionViewLayout: layout)
        
        delegate = self
        dataSource = self
        register(TagsCell.self, forCellWithReuseIdentifier: TagsCell.reuseId)
        
        backgroundColor = .clear
        contentInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
    }
    
    private func estimateFrameForText(text: String) -> CGRect {
        
        let widthMax = 250
        let height = 32
        let size = CGSize(width: widthMax, height: height)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.light)]

        return NSString(string: text).boundingRect(with: size, options: options, attributes: attributes, context: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TagsCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cells.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: TagsCell.reuseId, for: indexPath) as! TagsCell
        cell.runeTag.text = cells[indexPath.row].capitalized
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let padding: CGFloat = 32
        let text = cells[indexPath.item]
        return CGSize(width: estimateFrameForText(text: text).width + padding, height: 32)
    }
}
