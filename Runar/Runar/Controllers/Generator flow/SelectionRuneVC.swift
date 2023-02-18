//
//  SelectionRuneVC.swift
//  Runar
//
//  Created by Maksim Harbatsevich on 10/1/21.
//

import UIKit
import SnapKit
import KTCenterFlowLayout

//MARK: Constants
private extension String {
    static let selectedRunesTitle = L10n.Generator.SelectedRunes.title
    static let randomButtonTitle = L10n.Generator.RandomButton.title
    static let generateButtonTitle = L10n.Generator.GenerateButton.title
    static let generateRunesTitle = L10n.Generator.GenerateRunes.title
    static let runeSelectTitle = L10n.Generator.select
}

//MARK: Constants
private extension CGFloat {
    static let buttonCornerRadius = 10.0
    
    static let selectedRunesViewTopAnchor = 43.0
    static let selectedRunesViewHeightAnchor = 132.0
    static let selectedRuneCellWidthAnchor = 56.0
    static let selectedRuneCellHeightAnchor = 110.0
    
    static let randomButtonTopAnchor = 26.0
    static let randomButtonHeightAnchor = 48.0
    static let randomButtonWidthAnchor = 212.0
    static let randomButtonBorderWidthAnchor = 1.0
    
    static let generateButtonTopAnchor = 26.0
    static let generateButtonHeightAnchor = 48.0
    static let generateButtonWidthAnchor = 212.0
    
    static let selectRunesViewTopAnchor = 20.0
    static let selectRuneCellWidthAnchor = 66.0
    static let selectRuneCellHeightAnchor = 78.0
}

//MARK: Add to color common class
private extension UIColor {
    static let randomButtonBackgroundColor = UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36)
}

public class SelectionRuneVC: UIViewController, UIGestureRecognizerDelegate {
    
    private var gradientLayer = CAGradientLayer()
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        view.color = .white
        view.isHidden = true
        return view
    }()
    
    let selectedRunesView: SelectedRuneCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 17

        let selectedRunesView = SelectedRuneCollectionView(frame: .zero, collectionViewLayout: layout)
        return selectedRunesView
    }()
    
    let randomButton: UIButton = {
        let randomButton = UIButton()
        randomButton.layer.backgroundColor = UIColor.randomButtonBackgroundColor.cgColor
        randomButton.layer.cornerRadius = .buttonCornerRadius
        randomButton.layer.borderWidth = CGFloat.randomButtonBorderWidthAnchor
        randomButton.contentHorizontalAlignment = .center
        randomButton.contentEdgeInsets = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        randomButton.layer.borderColor = UIColor.yellowPrimaryColor.cgColor
        randomButton.setTitle(title: .randomButtonTitle)
        return randomButton
    }()
    
    let selectRunesView: SelectRuneCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 4
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .vertical

        let selectRunesView = SelectRuneCollectionView(frame: .zero, collectionViewLayout: layout)
        selectRunesView.showsHorizontalScrollIndicator = false
        selectRunesView.showsVerticalScrollIndicator = true
        selectRunesView.indicatorStyle = UIScrollView.IndicatorStyle.white
        selectRunesView.contentInset = UIEdgeInsets(top: 16, left: 16,
                                                    bottom: 0, right: 16)
        
        return selectRunesView
    }()
    
    let generateButton: UIButton = {
        let generateButton = UIButton()
        generateButton.layer.backgroundColor = UIColor.yellowPrimaryColor.cgColor
        generateButton.layer.cornerRadius = .buttonCornerRadius
        generateButton.contentHorizontalAlignment = .center
        generateButton.contentEdgeInsets = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        generateButton.isHidden = true
        generateButton.setTitle(title: .generateButtonTitle, color: UIColor.primaryBlackColor)
        return generateButton
    }()
    
    let popupVC: GenerationPopUpViewController = {
        let viewController = GenerationPopUpViewController()
        viewController.modalPresentationStyle = .overCurrentContext
        return viewController
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        RunarLayout.initBackground(for: view, with: .mainFire)
        selectRunesView.delegate = self
        selectedRunesView.delegate = self

        guard DataManager.shared.generatorIsLoaded else { return setupActivityIndicator() }
        setupViews()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }

    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    }
    
    public override func viewDidLayoutSubviews() {
        setupGradientLayerOnSelectRunesView()
    }
    
    private func configureNavigationBar() {
        
        tabBarController?.tabBar.isHidden = false
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.configure()
        navigationItem.setNavigationTitle(.generateRunesTitle)

        let customBackButton = UIBarButtonItem(image: Assets.backIcon.image,
                                                style: .plain, target: self,
                                                action: #selector(self.backToInitial))
        customBackButton.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    @objc func backToInitial(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }

    private func setupActivityIndicator() {
        self.view.addSubviews(activityIndicatorView)
        activityIndicatorView.startAnimating()
        activityIndicatorView.isHidden = false
        activityIndicatorView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func setupViews() {
        self.view.addSubview(selectedRunesView)
        selectedRunesView.setDeselectHandler(self.deselectRune(_:))
        selectedRunesView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(CGFloat.selectedRunesViewTopAnchor)
            make.centerX.equalToSuperview()
            make.height.equalTo(CGFloat.selectedRunesViewHeightAnchor)
            make.left.greaterThanOrEqualTo(self.view.snp.left)
            make.right.greaterThanOrEqualTo(self.view.snp.right)
        }
        
        self.view.addSubview(randomButton)
        randomButton.addTarget(self, action: #selector(self.selectRandomRunesOnTap), for: .touchUpInside)
        randomButton.snp.makeConstraints { make in
            make.top.equalTo(selectedRunesView.snp.bottom).offset(CGFloat.randomButtonTopAnchor)
            make.centerX.equalToSuperview()
            make.width.equalTo(CGFloat.randomButtonWidthAnchor)
            make.height.equalTo(CGFloat.randomButtonHeightAnchor)
        }
        
        self.view.addSubview(selectRunesView)
        self.selectRunesView.setSelectHandler(self.selectRune(_:))
        tapedLongGesture(runesView: selectRunesView)
        selectRunesView.snp.makeConstraints { make in
            make.top.equalTo(randomButton.snp.bottom).offset(CGFloat.selectRunesViewTopAnchor)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.bottom.equalTo(self.view.snp.bottom)
        }

        self.view.addSubview(generateButton)
        generateButton.addTarget(self, action: #selector(self.generateOnTap), for: .touchUpInside)
        generateButton.snp.makeConstraints { make in
            make.top.equalTo(selectedRunesView.snp.bottom).offset(CGFloat.generateButtonTopAnchor)
            make.centerX.equalToSuperview()
            make.width.equalTo(CGFloat.generateButtonWidthAnchor)
            make.height.equalTo(CGFloat.generateButtonHeightAnchor)
        }
    }
    
    private func setupGradientLayerOnSelectRunesView() {
        
        gradientLayer.frame = selectRunesView.bounds
        gradientLayer.colors = [
            UIColor.black.withAlphaComponent(0).cgColor,
            UIColor.white.cgColor
        ]
        gradientLayer.delegate = self
        
        let topInset = selectRunesView.contentInset.top
        let secondLocation = NSNumber(value: topInset / selectRunesView.frame.height)
        let firstLocation = NSNumber(value: 0.0)
        
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.locations = [firstLocation, secondLocation]
        selectRunesView.layer.mask = gradientLayer
    }
    
    private func tapedLongGesture(runesView: SelectRuneCollectionView) {
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(longTap))
        longGesture.minimumPressDuration = 0.5
        longGesture.delaysTouchesBegan = true
        longGesture.delegate = self
        runesView.addGestureRecognizer(longGesture)
    }
    
    private func selectRune(_ rune: SelectRuneCell) {
        selectOnTapBut(rune: rune)
    }
    
    @objc func longTap(_ sender: UIGestureRecognizer) {
        
        if sender.state == .began {
            let point = sender.location(in: self.selectRunesView)
            let indexPath = self.selectRunesView.indexPathForItem(at: point)
            
            if let index = indexPath {
                
                let rune = self.selectRunesView.cellForItem(at: index) as! SelectRuneCell
                
                popupVC.setupView(view: rune)
                popupVC.setupModel(rune.model)
                
                if !rune.isSelected && selectRunesView.selectedRunesCount < 3 {
                    popupVC.submitButton.isHidden = false
                } else {
                    popupVC.submitButton.isHidden = true
                }
                popupVC.escapeButton.isHidden = false
                
                self.addChild(popupVC)
                self.view.addSubview(popupVC.view)
                popupVC.view.frame = self.view.bounds
                
                popupVC.setupAction(.runeSelectTitle, #selector(self.selectOnTap))
                
                popupVC.didMove(toParent: self)
            } else {
                print("Could not find index path")
            }
        }
    }
    
    @objc func selectOnTap() {
        let rune = popupVC.runeView as! SelectRuneCell
        selectOnTapBut(rune: rune)
    }
    
    func selectOnTapBut(rune: SelectRuneCell) {

            selectRunesView.selectRune(rune: rune)
            
            for cell in (self.selectedRunesView.visibleCells as? [SelectedRuneCell])!.sorted(by: {c1, c2 in return c1.indexPath.row < c2.indexPath.row} ) {
                if !cell.isSelected {
                    guard let title = rune.model?.title,
                          let image = rune.model?.imageInfo.uiImage,
                          let id = rune.model?.id else { return }

                    cell.selectRune(SelectedRuneModel(title: title,
                                                      image: image,
                                                      index: rune.indexPath,
                                                      id: id))
                    break
                }
            }
            
            generateButton.isHidden = !selectedRunesView.hasSelectedRunes()
            randomButton.isHidden = selectedRunesView.hasSelectedRunes()
    }
    
    private func deselectRune(_ index: IndexPath){
        self.selectRunesView.deselectRune(at: index)
        
        generateButton.isHidden = !selectedRunesView.hasSelectedRunes()
        randomButton.isHidden = selectedRunesView.hasSelectedRunes()
    }

    func update() {
        setupViews()
        activityIndicatorView.isHidden = true
        activityIndicatorView.stopAnimating()
        selectRunesView.setupRunes()
        selectRunesView.reloadData()
    }
    
    @objc func selectRandomRunesOnTap() {
        self.selectedRunesView.deselectAll()

        let maxRunes = MemoryStorage.GenerationRunes.count
        var indexes = [Int](0..<maxRunes)

        for _ in 0..<3 {
            let index = indexes.randomElement()!
            
            let rune = selectRunesView.getRune(at: index)
            
            self.selectRunesView.selectRune(rune: rune)
            
            for cell in (self.selectedRunesView.visibleCells as! [SelectedRuneCell]).sorted(by: {c1, c2 in return c1.indexPath.row < c2.indexPath.row} ) {
                if !cell.isSelected {
                    guard let title = rune.model?.title,
                          let image = rune.model?.imageInfo.uiImage,
                          let id = rune.model?.id else { return }

                    cell.selectRune(SelectedRuneModel(title: title,
                                                      image: image,
                                                      index: rune.indexPath,
                                                      id: id))
                    break
                }
            }
            
            indexes.removeAll { (item: Int) -> Bool in
                return item == index
            }
        }
        
        generateButton.isHidden = !selectedRunesView.hasSelectedRunes()
        randomButton.isHidden = selectedRunesView.hasSelectedRunes()
    }
    
    @objc func generateOnTap() {
        let runesIds = (self.selectedRunesView.visibleCells as! [SelectedRuneCell])
            .filter({ (rune) -> Bool in
                return rune.selectedRune != nil
            })
            .sorted(by: { (rune1, rune2) -> Bool in
                return Int(rune1.selectedRune!.id)! < Int(rune2.selectedRune!.id)!
            })
            .map { (rune) -> String in
                return rune.selectedRune!.id
            }

        ApiGeneratorModel.showProcessingVCandGenerateImagesModel(vc: self, runesIds: runesIds)
    }
}

private extension UINavigationBar {
    func configure() -> Void {
        self.tintColor = .libraryTitleColor
        self.titleTextAttributes = [.font: UIFont.systemMedium(size: 17),
                                    .foregroundColor: UIColor.white]
    }
}

extension SelectionRuneVC: UICollectionViewDelegate {

    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        var indexes = self.selectRunesView.indexPathsForVisibleItems

        indexes.sort()
        guard let index = indexes.first,
              let cell = self.selectRunesView.cellForItem(at: index) else { return }

        let cellHeight = cell.frame.height
        
        var currentPoint = self.selectRunesView.contentOffset.y
        let positionOnRune = currentPoint - cell.frame.origin.y
        
        if positionOnRune > cellHeight / 2 {
            currentPoint += cellHeight - positionOnRune
        } else {
            currentPoint -= positionOnRune
        }
        
        let nextPoint = CGPoint(x: 0, y: currentPoint)
        selectRunesView.setContentOffset(nextPoint, animated: true)
    }
}

extension SelectionRuneVC: UICollectionViewDelegateFlowLayout {

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if let _ = collectionView as? SelectRuneCollectionView {
            let selectRunesViewSize = selectRunesView.frame.size
            let runeIdealSize = CGSize(width: CGFloat.selectRuneCellWidthAnchor, height: CGFloat.selectRuneCellHeightAnchor)
            let ratio = runeIdealSize.height / runeIdealSize.width

            let rowCount = round((selectRunesViewSize.height) / (runeIdealSize.height))

            let runeNormalHeight = (selectRunesViewSize.height) / rowCount
            let runeNormalWidth = runeNormalHeight / ratio

            return CGSize(width: runeNormalWidth, height: runeNormalHeight)
        }
        
        if let _ = collectionView as? SelectedRuneCollectionView,
           let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            let itemSize = CGSize(width: CGFloat.selectedRuneCellWidthAnchor, height: CGFloat.selectedRuneCellHeightAnchor)
            flowLayout.itemSize = itemSize
            return itemSize
        }
        
        return .zero
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
       
        if let selectedRuneVC = collectionView as? SelectedRuneCollectionView,
           let flowLayout = selectedRuneVC.collectionViewLayout as? UICollectionViewFlowLayout,
           let dataSourceCount = collectionView.dataSource?.collectionView(collectionView, numberOfItemsInSection: section),
           dataSourceCount > 0 {

            let cellCount = CGFloat(dataSourceCount)
            let itemSpacing = flowLayout.minimumInteritemSpacing
            let cellWidth = flowLayout.itemSize.width + itemSpacing
            let cellHeight = flowLayout.itemSize.height
            var insets = flowLayout.sectionInset
            let totalCellWidth = (cellWidth * cellCount) - itemSpacing
            let contentWidth = collectionView.frame.size.width - collectionView.contentInset.left - collectionView.contentInset.right

            guard totalCellWidth < contentWidth else {
                return insets
            }

            let padding = (contentWidth - totalCellWidth) / 2.0
            let paddingVertical = (collectionView.frame.height - cellHeight) / 2.0
            insets.left = padding
            insets.right = padding
            insets.top = paddingVertical
            insets.bottom = paddingVertical
            return insets

        }
        
        return .zero
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.gradientLayer.frame = selectRunesView.bounds
    }
}

extension SelectionRuneVC: CALayerDelegate {
    public func action(for layer: CALayer, forKey event: String) -> CAAction? {
        return NSNull()
    }
}
