//
//  SelectionRuneController.swift
//  Runar
//
//  Created by Maksim Harbatsevich on 10/1/21.
//

import UIKit

private extension String {
    static let selectedRunesTitle = L10n.Generator.SelectedRunes.title
    static let randomButtonTitle = L10n.Generator.RandomButton.title
    static let generateButtonTitle = L10n.Generator.GenerateButton.title
    static let generateRunesTitle = L10n.Generator.GenerateRunes.title
}

public class SelectionRuneController: UIViewController{
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        RunarLayout.initBackground(for: view, with: .mainFire)
        
        setupViews()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        configureNavigationBar()
    }
    
    let header: UILabel = {
        let title = UILabel(frame: CGRect(x: 0, y: 0, width: 252, height: 44))
        
        title.textColor = UIColor(red: 0.973, green: 0.973, blue: 0.973, alpha: 1)
        title.textAlignment = .center
        title.numberOfLines = 0
        title.lineBreakMode = .byWordWrapping
        title.text = .selectedRunesTitle
        title.font = FontFamily.SFProDisplay.regular.font(size: 17)
        title.backgroundColor = .clear
        
        return title
    }()
    
    let selectedRunesView: SelectedRuneCollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: 67, height: 110)
        layout.minimumInteritemSpacing = 1
        
        return SelectedRuneCollectionView(frame: .zero, collectionViewLayout: layout)
    }()
        
    let randomButton: UIButton = {
        let randomButton = UIButton()
        
        randomButton.layer.backgroundColor = UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 0.36).cgColor
        randomButton.layer.cornerRadius = 10
        randomButton.layer.borderWidth = 1
        randomButton.layer.borderColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1).cgColor
        randomButton.setTitle(title: .randomButtonTitle)
        
        return randomButton
    }()
    
    let selectRunesView: SelectRuneCollectionView = {
        let layout2 = UICollectionViewFlowLayout()
        
        layout2.itemSize = CGSize(width: 66, height: 78)
        layout2.minimumInteritemSpacing = 2
        layout2.minimumLineSpacing = 2
        layout2.scrollDirection = .horizontal
        layout2.sectionInset = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)
        
        let selectRunesView = SelectRuneCollectionView(frame: .zero, collectionViewLayout: layout2)
        
        return selectRunesView
    }()
    
    let generateButton: UIButton = {
        let generateButton = UIButton()
        
        generateButton.layer.backgroundColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1).cgColor
        generateButton.layer.cornerRadius = 10
        generateButton.isHidden = true
        generateButton.setTitle(title: .generateButtonTitle, color: UIColor(red: 0.165, green: 0.165, blue: 0.165, alpha: 1))
        
        return generateButton
    }()
    
    let popupVC: GenerationPopUpViewController = {
        let viewController = GenerationPopUpViewController()
        viewController.modalPresentationStyle = .overCurrentContext
        return viewController
    }()
    
    private func setupViews() {
        self.view.addSubview(header)
        
        header.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            header.heightAnchor.constraint(equalToConstant: 50),
            header.widthAnchor.constraint(equalToConstant: 252),
            header.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
                                
        self.view.addSubview(selectedRunesView)

        selectedRunesView.setDeselectHandler(self.deselectRune(_:))
        
        selectedRunesView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            selectedRunesView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            selectedRunesView.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 10),
            selectedRunesView.heightAnchor.constraint(equalToConstant: 140),
            selectedRunesView.widthAnchor.constraint(equalToConstant: 69*3)
        ])
        
        self.view.addSubview(randomButton)
        
        randomButton.addTarget(self, action: #selector(self.selectRandomRunesOnTap), for: .touchUpInside)
        
        randomButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            randomButton.topAnchor.constraint(equalTo: selectedRunesView.bottomAnchor),
            randomButton.heightAnchor.constraint(equalToConstant: 48),
            randomButton.widthAnchor.constraint(equalToConstant: 181),
            randomButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        self.selectRunesView.setSelectHandler(self.selectRune(_:))
        
        self.view.addSubview(selectRunesView)

        selectRunesView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            selectRunesView.topAnchor.constraint(equalTo: randomButton.bottomAnchor, constant: 25),
            selectRunesView.heightAnchor.constraint(equalToConstant: 240),
            selectRunesView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -16),
            selectRunesView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8),
            selectRunesView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8)
        ])
        
        self.view.addSubview(generateButton)
        
        generateButton.addTarget(self, action: #selector(self.generateOnTap), for: .touchUpInside)

        generateButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            generateButton.topAnchor.constraint(equalTo: selectRunesView.bottomAnchor, constant: 10),
            generateButton.heightAnchor.constraint(equalToConstant: 50),
            generateButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            generateButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        ])
    }
    
    private func configureNavigationBar() {
        title = .generateRunesTitle
        self.navigationController?.navigationBar.configure()
    }
    
    private func selectRune(_ rune: SelectRuneCell){
        popupVC.setupView(view: rune)
        popupVC.setupModel(rune.model)
        popupVC.submitButton.isHidden = false
        
        self.addChild(popupVC)
        self.view.addSubview(popupVC.view)
        popupVC.view.frame = self.view.bounds
        
        popupVC.setupAction(.runeSelectTitle, #selector(self.selectOnTap))
        
        popupVC.didMove(toParent: self)
    }
    
    @IBAction func selectOnTap() {
        let rune = popupVC.runeView as! SelectRuneCell
        
        selectRunesView.selectRune(rune: rune)
        
        for cell in (self.selectedRunesView.visibleCells as! [SelectedRuneCell]).sorted(by: {c1, c2 in return c1.indexPath.row < c2.indexPath.row} ) {
            if !cell.isSelected {
                cell.selectRune(SelectedRuneModel(title: rune.model!.title, image: rune.model!.image.image, index: rune.indexPath, id: rune.model!.id))
                break
            }
        }
        
        generateButton.isHidden = !selectedRunesView.hasSelectedRunes()
    }
    
    private func deselectRune(_ index: IndexPath){
        self.selectRunesView.deselectRune(at: index)
        
        generateButton.isHidden = !selectedRunesView.hasSelectedRunes()
    }
    
    @IBAction func selectRandomRunesOnTap() {
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
        
        generateButton.isHidden = false
    }
    
    @IBAction func generateOnTap() {
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
        
        let selectWallpaperStyleVC = SelectWallpaperStyleViewController()
        
        selectWallpaperStyleVC.selectedRunesIds = runesIds
        
        self.navigationController?.pushViewController(selectWallpaperStyleVC, animated: false)
    }
}

private extension UINavigationBar {
    func configure() -> Void {
        self.isTranslucent = false
        self.prefersLargeTitles = false
        self.tintColor = .libraryTitleColor
        self.backgroundColor = .navBarBackground
        self.barTintColor = .navBarBackground
        self.titleTextAttributes = [NSAttributedString.Key.font: FontFamily.SFProDisplay.regular.font(size: 17),
                                         NSAttributedString.Key.foregroundColor: UIColor.white]
        
        self.backItem?.backButtonTitle = .back
    }
}
