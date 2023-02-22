//
//  RunicDrawsCollectionVC.swift
//  Runar
//
//  Created by Юлия Лопатина on 17.12.20.
//

import UIKit
import SnapKit

extension String {
    static let layoutTitle = L10n.Layouts.title
    static let layoutGeneratorTitle = L10n.Layouts.Generator.title
    static let layoutGeneratorDesc = L10n.Layouts.Generator.description
}

class RunicDrawsCollectionVC: UICollectionViewController {

    // MARK: Constants
    let topAnchorTitleCollectionView: CGFloat = 38
    let heightTitleCollectionView: CGFloat = 42

    let topAnchorGeneratorView: CGFloat = 32
    let trailingLeadingAnchorGeneratorView: CGFloat = 16
    let heightGeneratorView: CGFloat = 120

    let topAnchorGeneratorHeader: CGFloat = 25

    let topBottomAnchorImage: CGFloat = 8
    let widthImage: CGFloat = 120

    let topGeneratorDescription: CGFloat = 8
    let trailingGeneratorDescription: CGFloat = 15

    let paddingCollectionView: CGFloat = 16
    let minimumItemSpasingCollectionView: CGFloat = 16
    let aspectRatioCollectioView: CGFloat = 183 / 199

    private let data = DataBase.runes.map {
        MainCellModel(runeId: $0.id, name: $0.name, image: $0.image)
    }

    let titleCollectionView: UILabel = {
        let label = UILabel()
        let fontSizeTitleCollectionView: CGFloat = 36
        label.font = .amaticBold(size: fontSizeTitleCollectionView)
        label.textColor = .yellowPrimaryColor
        label.contentMode = .center
        let prgph = NSMutableParagraphStyle()
        prgph.lineHeightMultiple = 0.79
        label.attributedText = NSMutableAttributedString(string: .layoutTitle, attributes: [NSAttributedString.Key.paragraphStyle: prgph])

        return label
    }()

    let generatorView: UIView = {
        let generatorView = UIView()
        let cornerRadiusGeneratorView: CGFloat = 8
        let borderWidthGeneratorView: CGFloat = 1
        generatorView.layer.cornerRadius = cornerRadiusGeneratorView
        generatorView.layer.borderWidth = borderWidthGeneratorView
        generatorView.layer.borderColor = UIColor.accentTextColor.cgColor
        generatorView.layer.backgroundColor = UIColor.generatorViewBacgroundColor
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
        let label = UILabel()
        let fontSizeTitleGeneratorView: CGFloat = 24
        label.font = .amaticBold(size: fontSizeTitleGeneratorView)
        label.textColor = .textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        let prgph = NSMutableParagraphStyle()
        prgph.lineHeightMultiple = 0.79
        label.attributedText = NSMutableAttributedString(string: .layoutGeneratorTitle, attributes: [NSAttributedString.Key.paragraphStyle: prgph])
        return label
    }()

    let generatorDescription: UILabel = {
        let label = UILabel()
        let fontSizeGereatorDescription: CGFloat = 12
        label.font = .systemRegular(size: fontSizeGereatorDescription)
        label.textAlignment = .left
        label.contentMode = .scaleToFill
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .textColor
        let prgph = NSMutableParagraphStyle()
        prgph.lineHeightMultiple = 1.14
        label.attributedText = NSMutableAttributedString(string: .layoutGeneratorDesc, attributes: [NSAttributedString.Key.paragraphStyle: prgph])
        return label
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
        generatorView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.top).offset(topAnchorGeneratorView)
            make.trailing.leading.equalTo(collectionView).inset(trailingLeadingAnchorGeneratorView)
            make.height.equalTo(heightGeneratorView)
            make.centerX.equalTo(collectionView)
        }

        collectionView.addSubview(generatorButton)
        generatorButton.addTarget(self, action: #selector(self.goToGeneratorTab), for: .touchUpInside)
        generatorButton.snp.makeConstraints { make in
            make.top.equalTo(generatorView.snp.top)
            make.trailing.leading.equalTo(generatorView)
            make.bottom.equalTo(generatorView.snp.bottom)
        }

        generatorView.addSubview(generatorImage)
        generatorImage.snp.makeConstraints { make in
            make.top.equalTo(generatorView.snp.top).offset(topBottomAnchorImage)
            make.leading.equalTo(generatorView.snp.leading)
            make.bottom.equalTo(generatorView.snp.bottom).inset(topBottomAnchorImage)
            make.width.equalTo(widthImage)
        }

        generatorView.addSubview(generatorHeader)
        generatorHeader.snp.makeConstraints { make in
            make.top.equalTo(generatorView.snp.top).offset(topAnchorGeneratorHeader)
            make.leading.equalTo(generatorImage.snp.trailing)
            make.trailing.equalTo(generatorView.snp.trailing)
        }

        generatorView.addSubview(generatorDescription)
        generatorDescription.snp.makeConstraints { make in
            make.top.equalTo(generatorHeader.snp.bottom).offset(topGeneratorDescription)
            make.leading.equalTo(generatorImage.snp.trailing)
            make.trailing.equalTo(generatorView.snp.trailing).inset(trailingGeneratorDescription)
        }

        collectionView.addSubview(titleCollectionView)
        titleCollectionView.snp.makeConstraints { make in
            make.top.equalTo(generatorView.snp.bottom).offset(topAnchorTitleCollectionView)
            make.height.equalTo(heightTitleCollectionView)
            make.centerX.equalToSuperview()
        }
    }

    @IBAction private func goToGeneratorTab() {
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

        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        guard let runeDescription = DataBase.runes.first(where: {
            $0.id == data[safe: indexPath.row]?.runeId
        }) else { return }

        tapRunicDrawCell(runeDescription: runeDescription)

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.bounds.width
        let padding: CGFloat = paddingCollectionView
        let minimumItemSpasing: CGFloat = minimumItemSpasingCollectionView
        let availableWidth = width - (padding * 2) - minimumItemSpasing
        let itemWidth = availableWidth / 2
        let aspectRatio: CGFloat = aspectRatioCollectioView
        return CGSize(width: itemWidth, height: itemWidth / aspectRatio)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 250, left: 16, bottom: 16, right: 16)
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
            self.navigationController?.pushViewController(viewController, animated: true)
        } else {
            let viewModel = AlignmentInfoVM(runeDescription: runeDescription)
            let viewController = AlignmentInfoVC(viewModel: viewModel)
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

private extension UIColor {
    static let generatorViewBacgroundColor = UIColor(red: 0.063, green: 0.063, blue: 0.063, alpha: 0.35).cgColor
    static let textColor = UIColor(red: 0.882, green: 0.882, blue: 0.882, alpha: 1)
}

