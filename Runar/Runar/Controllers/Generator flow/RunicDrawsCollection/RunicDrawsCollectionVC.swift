//
//  RunicDrawsCollectionVC.swift
//  Runar
//
//  Created by Юлия Лопатина on 17.12.20.
//

import UIKit

extension String {
    static let layoutTitle = L10n.Layouts.title
    static let layoutGeneratorTitle = L10n.Layouts.Generator.title
    static let layoutGeneratorDesc = L10n.Layouts.Generator.description
}

class RunicDrawsCollectionVC: UICollectionViewController {
    
    private let data = DataBase.runes.map {
        MainCellModel(runeId: $0.id, name: $0.name, image: $0.image)
    }
    
    let label: UILabel = {
        return UILabel.createAmatic(title: .layoutTitle, size: 36, lineHeight: 0.7, height: 42)
    }()
    
    let generatorView: UIView = {
        let generatorView = UIView()
        generatorView.layer.cornerRadius = 8
        generatorView.layer.borderWidth = 1
        generatorView.layer.borderColor = UIColor(red: 0.824, green: 0.769, blue: 0.678, alpha: 0.6).cgColor
        generatorView.layer.backgroundColor = UIColor(red: 0.063, green: 0.063, blue: 0.063, alpha: 0.35).cgColor
        generatorView.translatesAutoresizingMaskIntoConstraints = false
        return generatorView
    }()
    
    let generatorImage: UIImageView = {
        let generatorImage = UIImageView(image: Assets.runePattern.image)
        generatorImage.translatesAutoresizingMaskIntoConstraints = false
        generatorImage.contentMode = .scaleAspectFit
        return generatorImage
    }()
    
    let generatorHeader: UILabel = {
        let generatorHeader = UILabel.createAmatic(title: .layoutGeneratorTitle, size: 24, lineHeight: 0.79, height: 24)
        generatorHeader.textColor = UIColor(red: 0.882, green: 0.882, blue: 0.882, alpha: 1)
        return generatorHeader
    }()
    
    let generatorDesc: UILabel = {
        let generatorDesc = UILabel.createAmatic(title: .layoutGeneratorDesc, size: 15, lineHeight: 1.14, height: 50)
        generatorDesc.font = FontFamily.SFProDisplay.regular.font(size: 15)
        generatorDesc.textColor = UIColor(red: 0.882, green: 0.882, blue: 0.882, alpha: 1)
        generatorDesc.textAlignment = .left
        generatorDesc.contentMode = .scaleToFill
        generatorDesc.numberOfLines = 0
        generatorDesc.lineBreakMode = .byWordWrapping
        return generatorDesc
    }()
    
    let generatorButton: UIButton = {
        let generatorButton = UIButton()
        generatorButton.translatesAutoresizingMaskIntoConstraints = false
        return generatorButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(self.updateUI(_:)), name: NSNotification.Name(rawValue: "updateRunicDrawsCollectionViewAfterPurchase"), object: nil)

        navigationController?.navigationBar.isHidden = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        configureCollectionView()
        configureConstraints()
        
        // TODO: - No Internet
        //        //NetworkMonitor
        //        if NetworkMonitor.shared.isConnected {
        //
        //        } else {
        //            showAllert()
        //        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @objc private func updateUI(_ notification: NSNotification) {
        self.collectionView.reloadData()
    }

    private func configureCollectionView() {
        
        let mainImageView: UIImageView = UIImageView(image: Assets.Background.main.image)
        mainImageView.contentMode = .scaleAspectFill
        collectionView.backgroundView = mainImageView
        collectionView.delaysContentTouches = false
        collectionView.register(MainCell.self, forCellWithReuseIdentifier: MainCell.reuseIdentifier)
    }
    
    private func configureConstraints() {
        
        collectionView.addSubview(generatorView)
        NSLayoutConstraint.activate([
            generatorView.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: 8),
            generatorView.leftAnchor.constraint(equalTo: collectionView.leftAnchor, constant: 16),
            generatorView.rightAnchor.constraint(equalTo: collectionView.rightAnchor, constant: 16),
            generatorView.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
            generatorView.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        collectionView.addSubview(generatorButton)
        
        generatorButton.addTarget(self, action: #selector(self.goToGeneratorTab), for: .touchUpInside)
        NSLayoutConstraint.activate([
            generatorButton.topAnchor.constraint(equalTo: generatorView.topAnchor),
            generatorButton.leftAnchor.constraint(equalTo: generatorView.leftAnchor),
            generatorButton.rightAnchor.constraint(equalTo: generatorView.rightAnchor),
            generatorButton.bottomAnchor.constraint(equalTo: generatorView.bottomAnchor)
        ])
        
        generatorView.addSubview(generatorImage)
        NSLayoutConstraint.activate([
            generatorImage.topAnchor.constraint(equalTo: generatorView.topAnchor, constant: 8),
            generatorImage.leftAnchor.constraint(equalTo: generatorView.leftAnchor),
            generatorImage.bottomAnchor.constraint(equalTo: generatorView.bottomAnchor, constant: -8),
            generatorImage.widthAnchor.constraint(equalToConstant: 120)
        ])
        
        generatorView.addSubview(generatorHeader)
        NSLayoutConstraint.activate([
            generatorHeader.topAnchor.constraint(equalTo: generatorView.topAnchor, constant: 25),
            generatorHeader.leftAnchor.constraint(equalTo: generatorImage.rightAnchor),
            generatorHeader.rightAnchor.constraint(equalTo: generatorView.rightAnchor)
        ])
        
        generatorView.addSubview(generatorDesc)
        NSLayoutConstraint.activate([
            generatorDesc.topAnchor.constraint(equalTo: generatorView.topAnchor, constant: 50),
            generatorDesc.leftAnchor.constraint(equalTo: generatorImage.rightAnchor),
            generatorDesc.rightAnchor.constraint(equalTo: generatorView.rightAnchor, constant: -8)
        ])
        
        collectionView.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: generatorView.bottomAnchor, constant: 38),
            label.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
            label.heightAnchor.constraint(equalToConstant: 42)
        ])
    }
        
    @IBAction func goToGeneratorTab() {
        self.tabBarController?.selectedIndex = 2
    }

    //TODO: - No Internet
    //    private func showAllert() {
    //        let alert = UIAlertController(title: "No Internet", message: "Runar app Requires wifi/internet connection!", preferredStyle: .alert)
    //        let action = UIAlertAction(title: "Ok", style: .default)
    //        alert.addAction(action)
    //
    //        self.present(alert, animated: true, completion: nil)
    //
    //    }
}

extension RunicDrawsCollectionVC: UICollectionViewDelegateFlowLayout {

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCell.reuseIdentifier, for: indexPath) as! MainCell
        cell.update(with: data[safe: indexPath.row])
        
        if SubscriptionManager.freeSubscription == true {
            if indexPath.row >= 3 {
                cell.unavailableRunicDraw()
            }
        } else {
            cell.availableRunicDraw()
        }

        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        guard let runeDescription = DataBase.runes.first(where: {
            $0.id == data[safe: indexPath.row]?.runeId
        }) else { return }

        if SubscriptionManager.freeSubscription == true {
            if indexPath.row >= 3 {
                SubscriptionManager.presentMonetizationVC(vc: self)
            } else {
                tapRunicDrawCell(runeDescription: runeDescription)
            }
        } else {
            tapRunicDrawCell(runeDescription: runeDescription)
        }
    }
    
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
        return UIEdgeInsets(top: 230, left: 16, bottom: 16, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    private func tapRunicDrawCell(runeDescription: RuneDescription) {
        if LocalStorage.pull(forKey: runeDescription.name) == true {
            let viewModel = AlignmentVM(runeDescription: runeDescription)
            let viewController = AlignmentVC(viewModel: viewModel)
            viewController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(viewController, animated: true)
        } else {
            let viewModel = AlignmentInfoVM(runeDescription: runeDescription)
            let viewController = AlignmentInfoVC(viewModel: viewModel)
            viewController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(viewController, animated: true)
        }
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
