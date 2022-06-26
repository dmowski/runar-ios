//
//  TagsCollectionView.swift
//  Runar
//
//  Created by bowtie on 20.06.2022.
//

import UIKit

class TagsCollectionView: UICollectionView {

    var cells = [String]()
    
    init() {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        super.init(frame: .zero, collectionViewLayout: layout)
        
        delegate = self
        dataSource = self
        register(TagsViewCell.self, forCellWithReuseIdentifier: TagsViewCell.reuseId)
        
        backgroundColor = .clear
        //contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
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
        let cell = dequeueReusableCell(withReuseIdentifier: TagsViewCell.reuseId, for: indexPath) as! TagsViewCell
        cell.runeTag.text = cells[indexPath.row].capitalized
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 32)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let totalCellWidth = 100 * cells.count
        let totalSpacingWidth = 8 * (cells.count - 1)

        let leftInset = (frame.size.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset

        
        print(totalCellWidth)
        print(totalSpacingWidth)
        print(frame.size.width)
        print(rightInset)
        
        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//
//        //Where elements_count is the count of all your items in that
//        //Collection view...
//        let cellCount = CGFloat(cells.count)
//
//        //If the cell count is zero, there is no point in calculating anything.
//        if cellCount > 0 {
//            //let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
//            let cellWidth: CGFloat = 100.0//flowLayout.itemSize.width + flowLayout.minimumInteritemSpacing
//
//            //20.00 was just extra spacing I wanted to add to my cell.
//            let totalCellWidth = cellWidth * cellCount // * (cellCount - 1)
//            let contentWidth = collectionView.frame.size.width - collectionView.contentInset.left - collectionView.contentInset.right
//
//            if (totalCellWidth < contentWidth) {
//                //If the number of cells that exists take up less room than the
//                //collection view width... then there is an actual point to centering them.
//
//                //Calculate the right amount of padding to center the cells.
//                let padding = (contentWidth - totalCellWidth) / 2.0
//                return UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
//            } else {
//                //Pretty much if the number of cells that exist take up
//                //more room than the actual collectionView width, there is no
//                // point in trying to center them. So we leave the default behavior.
//                return UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40)
//            }
//        }
//        return UIEdgeInsets.zero
//    }
}
