//
//  CollectionViewController.swift
//  Runar
//
//  Created by Юлия Лопатина on 17.12.20.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {
    
    private let floatingImage = UIButton()
    private let data = DataBase.runes.map {
        MainCellModel(runeId: $0.id, name: $0.name, image: $0.image)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let mainImage: UIImage? = Assets.Background.main.image
        let mainImageView: UIImageView = UIImageView(image: mainImage)
        mainImageView.contentMode = .scaleAspectFill
        collectionView.backgroundView = mainImageView
        navigationController?.navigationBar.isHidden = true
        collectionView.delaysContentTouches = false

        collectionView.register(MainCell.self, forCellWithReuseIdentifier: MainCell.reuseIdentifier)
        
        MusicViewController.shared.playCurrentSong()
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false 
    }
    
    //-------------------------------------------------
    // MARK: - UICollectionViewDataSource
    //-------------------------------------------------
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {

        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return data.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCell.reuseIdentifier, for: indexPath) as! MainCell
        cell.update(with: data[safe: indexPath.row])
        
        return cell
    }
    
    //-------------------------------------------------
    // MARK: - UICollectionViewDelegate
    //-------------------------------------------------
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let runeDescription = DataBase.runes.first(where: {
            $0.id == data[safe: indexPath.row]?.runeId
        }) else { return }
        if UserDefaults.standard.bool(forKey: runeDescription.name) == true {
            let viewModel = AlignmentViewModel(runeDescription: runeDescription)
            let viewController = AlignmentViewController()
            viewController.viewModel = viewModel
            viewController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(viewController, animated: true)
        } else {
            let viewModel = AlignmentInfoViewModel(runeDescription: runeDescription)
            let viewController = AlignmentInfoViewController()
            viewController.viewModel = viewModel
            viewController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

//-------------------------------------------------
// MARK: - Extension
//-------------------------------------------------

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.bounds.width
        let padding: CGFloat = 16
        let minimumItemSpasing: CGFloat = 16
        let availableWidth = width - (padding * 2) - minimumItemSpasing
        let itemWidth = availableWidth / 2
        let aspectRatio: CGFloat = 183 / 199
        return CGSize(width: itemWidth, height: itemWidth / aspectRatio)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 25, left: 16, bottom: 16, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}

private extension RuneDescription {
    var image: UIImage {
        switch layout {
        case .dayRune:
            return Assets.CellSettings.Runes.dayRune.image
        case .twoRunes:
            return Assets.CellSettings.Runes.twoRunes.image
        case .norns:
            return Assets.CellSettings.Runes.norns.image
        case .thorsHummer:
            return Assets.CellSettings.Runes.thorsHummer.image
        case .shortPrediction:
            return Assets.CellSettings.Runes.shortPrediction.image
        case .cross:
            return Assets.CellSettings.Runes.cross.image
        case .elementsCross:
            return Assets.CellSettings.Runes.elementsCross.image
        case .keltsCross:
            return Assets.CellSettings.Runes.keltsCross.image
        }
    }
}
