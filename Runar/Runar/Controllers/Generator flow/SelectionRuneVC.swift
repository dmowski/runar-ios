//
//  SelectionRuneVC.swift
//  Runar
//
//  Created by Maksim Harbatsevich on 10/1/21.
//

import UIKit
import SnapKit
import KTCenterFlowLayout

private extension String {

    static let selectedRunesTitle = L10n.Generator.SelectedRunes.title
    static let randomButtonTitle = L10n.Generator.RandomButton.title
    static let generateButtonTitle = L10n.Generator.GenerateButton.title
    static let generateRunesTitle = L10n.Generator.GenerateRunes.title
    static let runeSelectTitle = L10n.Generator.select
}

public class SelectionRuneVC: UIViewController, UIGestureRecognizerDelegate {
    
    private var gradientLayer = CAGradientLayer()
    
    let header: UILabel = {
        let title = UILabel()
        title.textColor = UIColor(red: 0.973, green: 0.973, blue: 0.973, alpha: 1)
        title.textAlignment = .center
        title.numberOfLines = 0
        title.lineBreakMode = .byWordWrapping
        title.text = .selectedRunesTitle
        title.font = .systemLight(size: 18)
        title.backgroundColor = .clear
        return title
    }()

    let activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        view.color = .white
        view.isHidden = true
        return view
    }()
    
    let selectedRunesView: SelectedRuneCollectionView = {
        let layout = KTCenterFlowLayout()
        layout.itemSize = CGSize(width: 63, height: 110)
        layout.minimumInteritemSpacing = 0

        return SelectedRuneCollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    let randomButton: UIButton = {
        let randomButton = UIButton()
        randomButton.layer.backgroundColor = UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36).cgColor
        randomButton.layer.cornerRadius = 10
        randomButton.layer.borderWidth = 1
        randomButton.contentHorizontalAlignment = .center
        randomButton.contentEdgeInsets = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        randomButton.layer.borderColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1).cgColor
        randomButton.setTitle(title: .randomButtonTitle)
        return randomButton
    }()
    
    let selectRunesView: SelectRuneCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .vertical

        let selectRunesView = SelectRuneCollectionView(frame: .zero, collectionViewLayout: layout)
        selectRunesView.showsHorizontalScrollIndicator = false
        selectRunesView.showsVerticalScrollIndicator = false
        selectRunesView.contentInset = UIEdgeInsets(top: 50, left: 35,
                                                    bottom: 0, right: 35)
        
        return selectRunesView
    }()
    
    let generateButton: UIButton = {
        let generateButton = UIButton()
        generateButton.layer.backgroundColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1).cgColor
        generateButton.layer.cornerRadius = 10
        generateButton.contentHorizontalAlignment = .center
        generateButton.contentEdgeInsets = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        generateButton.isHidden = true
        generateButton.setTitle(title: .generateButtonTitle, color: UIColor(red: 0.165, green: 0.165, blue: 0.165, alpha: 1))
        return generateButton
    }()
    
    let popupVC: GenerationPopUpViewController = {        
        let viewController = GenerationPopUpViewController()
        viewController.isHiddenTabBar = true
        viewController.modalPresentationStyle = .overCurrentContext
        return viewController
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        RunarLayout.initBackground(for: view, with: .generatorFire)
        selectRunesView.delegate = self

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
        title = .generateRunesTitle
        navigationController?.navigationBar.isHidden = false
        navigationController?.tabBarController?.tabBar.isHidden = false
        navigationController?.setStatusBar(backgroundColor: .navBarBackground)
        self.navigationController?.navigationBar.configure()
        navigationItem.largeTitleDisplayMode = .never
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
        self.view.addSubview(header)
        header.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(48)
            make.leading.equalToSuperview().offset(60)
            make.trailing.equalToSuperview().offset(-60)
        }
        
        self.view.addSubview(selectedRunesView)
        selectedRunesView.setDeselectHandler(self.deselectRune(_:))
        selectedRunesView.snp.makeConstraints { make in
            make.top.equalTo(header.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(110)
            make.left.greaterThanOrEqualTo(self.view.snp.left).offset(35)
            make.right.greaterThanOrEqualTo(self.view.snp.right).offset(-35)
        }
        
        self.view.addSubview(randomButton)
        randomButton.addTarget(self, action: #selector(self.selectRandomRunesOnTap), for: .touchUpInside)
        randomButton.snp.makeConstraints { make in
            make.top.equalTo(selectedRunesView.snp.bottom).offset(35)
            make.centerX.equalToSuperview()
            make.width.equalTo(184)
            make.height.equalTo(50)
        }
        
        self.view.addSubview(selectRunesView)
        self.selectRunesView.setSelectHandler(self.selectRune(_:))
        tapedLongGesture(runesView: selectRunesView)
        selectRunesView.snp.makeConstraints { make in
            make.top.equalTo(randomButton.snp.bottom).offset(30)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }

        self.view.addSubview(generateButton)
        generateButton.addTarget(self, action: #selector(self.generateOnTap), for: .touchUpInside)
        generateButton.snp.makeConstraints { make in
            make.top.equalTo(selectedRunesView.snp.bottom).offset(35)
            make.centerX.equalToSuperview()
            make.width.equalTo(184)
            make.height.equalTo(50)
        }
    }
    
    private func setupGradientLayerOnSelectRunesView() {
        
        gradientLayer.frame = selectRunesView.bounds
        gradientLayer.colors = [
            UIColor.black.withAlphaComponent(0).cgColor,
            UIColor.white.cgColor,
            UIColor.white.cgColor,
            UIColor.black.withAlphaComponent(0).cgColor
        ]
        gradientLayer.delegate = self
        
        let topInset = selectRunesView.contentInset.top
        let secondLocation = NSNumber(value: topInset / selectRunesView.frame.height)
        let thirdLocation = NSNumber(value: 1 - topInset / selectRunesView.frame.height)
        
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.locations = [0.0, secondLocation, thirdLocation, 1.0]
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

        var maxRunes = MemoryStorage.GenerationRunes.count
        
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
        self.isTranslucent = false
        self.tintColor = .libraryTitleColor
        self.backgroundColor = .navBarBackground
        self.barTintColor = .navBarBackground
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

        let selectRunesViewSize = selectRunesView.frame.size
        let runeIdealSize = CGSize(width: 66, height: 78)
        let ratio = runeIdealSize.height / runeIdealSize.width

        let rowCount = round((selectRunesViewSize.height) / (runeIdealSize.height))

        let runeNormalHeight = (selectRunesViewSize.height) / rowCount
        let runeNormalWidth = runeNormalHeight / ratio

        return CGSize(width: runeNormalWidth, height: runeNormalHeight)
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
