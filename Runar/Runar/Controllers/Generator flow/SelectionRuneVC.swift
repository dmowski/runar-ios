//
//  SelectionRuneVC.swift
//  Runar
//
//  Created by Maksim Harbatsevich on 10/1/21.
//

import UIKit
import SnapKit

private extension String {

    static let selectedRunesTitle = L10n.Generator.SelectedRunes.title
    static let randomButtonTitle = L10n.Generator.RandomButton.title
    static let generateButtonTitle = L10n.Generator.GenerateButton.title
    static let generateRunesTitle = L10n.Generator.GenerateRunes.title
    static let runeSelectTitle = L10n.Generator.select
}

public class SelectionRuneVC: UIViewController, UIGestureRecognizerDelegate {
    
    let header: UILabel = {
        let title = UILabel()
        title.textColor = UIColor(red: 0.973, green: 0.973, blue: 0.973, alpha: 1)
        title.textAlignment = .center
        title.numberOfLines = 0
        title.lineBreakMode = .byWordWrapping
        title.text = .selectedRunesTitle
        title.font = FontFamily.Roboto.light.font(size: 18)
        title.backgroundColor = .clear
        return title
    }()
    
    let selectedRunesView: SelectedRuneCollectionView = {
        let layout = UICollectionViewFlowLayout()
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

    let activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        view.color = .white
        view.isHidden = true
        return view
    }()
    
    let selectRunesView: SelectRuneCollectionView = {
        let layout2 = UICollectionViewFlowLayout()
        layout2.itemSize = CGSize(width: 66, height: 78)
        layout2.minimumInteritemSpacing = 4
        layout2.minimumLineSpacing = 0
        layout2.scrollDirection = .vertical
        
        let selectRunesView = SelectRuneCollectionView(frame: .zero, collectionViewLayout: layout2)
        selectRunesView.showsHorizontalScrollIndicator = false
        selectRunesView.showsVerticalScrollIndicator = false
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
        
        RunarLayout.initBackground(for: view, with: .mainFire)
        setupViews()
        configureNavigationBar()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }

    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.tabBarController?.tabBar.isHidden = false
    }

    private func configureNavigationBar() {
        title = .generateRunesTitle
        self.navigationController?.navigationBar.configure()
        
        self.navigationItem.hidesBackButton = true
        let customBackButton = UIBarButtonItem(image: Assets.backIcon.image,
                                               style: .plain, target: self,
                                               action: #selector(self.backToInitial))
        customBackButton.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        navigationItem.leftBarButtonItem = customBackButton
    }

    @objc func backToInitial(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
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
            make.width.equalTo(200)
        }
        
        self.view.addSubview(randomButton)
        randomButton.addTarget(self, action: #selector(self.selectRandomRunesOnTap), for: .touchUpInside)
        randomButton.snp.makeConstraints { make in
            make.top.equalTo(selectedRunesView.snp.bottom).offset(35)
            make.centerX.equalToSuperview()
            make.width.equalTo(184)
            make.height.equalTo(50)
        }

        self.view.addSubviews(activityIndicatorView)
        if MemoryStorage.GenerationRunes.isEmpty {
            activityIndicatorView.startAnimating()
            activityIndicatorView.isHidden = false
        }
        activityIndicatorView.snp.makeConstraints { make in
            make.top.equalTo(selectedRunesView.snp.bottom).offset(130)
            make.centerX.equalToSuperview()
        }
        
        self.view.addSubview(selectRunesView)
        self.selectRunesView.setSelectHandler(self.selectRune(_:))
        tapedLongGesture(runesView: selectRunesView)
        selectRunesView.snp.makeConstraints { make in
            make.top.equalTo(selectedRunesView.snp.bottom).offset(130)
            make.left.equalTo(self.view.snp.left).offset(41)
            make.right.equalTo(self.view.snp.right).offset(-41)
            make.bottom.equalToSuperview()
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
    
    private func tapedLongGesture(runesView: SelectRuneCollectionView) {
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(longTap))
        longGesture.minimumPressDuration = 1
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
        
        for cell in (self.selectedRunesView.visibleCells as! [SelectedRuneCell]).sorted(by: {c1, c2 in return c1.indexPath.row < c2.indexPath.row} ) {
            if !cell.isSelected {
                cell.selectRune(SelectedRuneModel(title: rune.model!.title, image: rune.model!.image.image, index: rune.indexPath, id: rune.model!.id))
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
        activityIndicatorView.isHidden = true
        activityIndicatorView.stopAnimating()
        selectRunesView.setupRunes()
        selectRunesView.reloadData()
    }
    
    @objc func selectRandomRunesOnTap() {
        self.selectedRunesView.deselectAll()
        
        var indexes = [Int](0..<MemoryStorage.GenerationRunes.count)
        
        for _ in 0..<3 {
            let index = indexes.randomElement()!
            
            let rune = selectRunesView.getRune(at: index)
            
            self.selectRunesView.selectRune(rune: rune)
            
            for cell in (self.selectedRunesView.visibleCells as! [SelectedRuneCell]).sorted(by: {c1, c2 in return c1.indexPath.row < c2.indexPath.row} ) {
                if !cell.isSelected {
                    cell.selectRune(SelectedRuneModel(title: rune.model!.title, image: rune.model!.image.image, index: rune.indexPath, id: rune.model!.id))
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
        self.prefersLargeTitles = false
        self.tintColor = .libraryTitleColor
        self.backgroundColor = .navBarBackground
        self.barTintColor = .navBarBackground
        self.titleTextAttributes = [NSAttributedString.Key.font: FontFamily.SFProDisplay.medium.font(size: 17),
                                    NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}
