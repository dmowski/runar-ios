//
//  GeneratorViewController.swift
//  Runar
//
//  Created by Maksim Harbatsevich on 9/16/21.
//

import UIKit

extension String {

    static let runePatternTitle = L10n.Generator.RunePattern.title
    static let runePatternDesc = L10n.Generator.RunePattern.description
    static let runeFormulaTitle = L10n.Generator.RuneFormula.title
    static let runeFormulaDesc = L10n.Generator.RuneFormula.description
    static let runeStavesTitle = L10n.Generator.RuneStaves.title
    static let runeStavesDesc = L10n.Generator.RuneStaves.description
    static let runeCommingSoon = L10n.Generator.commingSoon
    static let runeSelectTitle = L10n.Generator.select
}

public class GeneratorViewController: UIViewController {

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        RunarLayout.initBackground(for: view, with: .mainFire)
        configureView()
    }
        
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = .generator
        navigationController?.navigationBar.configure(prefersLargeTitles: true, titleFontSize: 34)
        navigationController?.setStatusBar(backgroundColor: .navBarBackground)
    }

    private func configureView() {

        let mainCell = renderMainCell()
        let label = renderLabel()
        let subCells = renderSubCells()
        
        self.view.addSubviews(mainCell, label, subCells)

        mainCell.translatesAutoresizingMaskIntoConstraints = false
        mainCell.centerXAnchor.constraint(equalTo: self.view!.centerXAnchor).isActive = true
        mainCell.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 42).isActive = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 24).isActive = true
        label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        label.topAnchor.constraint(equalTo: mainCell.bottomAnchor, constant: 32).isActive = true
              
        subCells.translatesAutoresizingMaskIntoConstraints = false
        subCells.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        subCells.widthAnchor.constraint(equalToConstant: 260).isActive = true
        subCells.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 24).isActive = true
    }
    
    private func renderMainCell() -> UIView {
        let mainCell = GenerationRuneCell.createMain(withTitle: .runePatternTitle, withDescription: .runePatternDesc)
        
        mainCell.addTarget(self, action: #selector(tapWithoutPopUp), for: .touchUpInside)
        
        return mainCell
    }
    
    private func renderLabel() -> UIView {
        let label = UILabel()
               
        label.font = FontFamily.AmaticSC.bold.font(size: 24)
        label.textColor = UIColor(red: 0.973, green: 0.973, blue: 0.973, alpha: 1)
        label.textAlignment = .center
        label.contentMode = .center
        
        let prgph = NSMutableParagraphStyle()
        
        prgph.lineHeightMultiple = 0.79
        
        label.attributedText = NSMutableAttributedString(string: .runeCommingSoon, attributes: [NSAttributedString.Key.paragraphStyle: prgph])
                        
        return label
    }
    
    private func renderSubCells() -> UIView {
        let subCell1 = GenerationRuneCell.createSub(withTitle: .runeFormulaTitle, withDescription: .runeFormulaDesc, withType: .formula)
        let subCell2 = GenerationRuneCell.createSub(withTitle: .runeStavesTitle, withDescription: .runeStavesDesc, withType: .staves)
        
        let groupCell = UIView()
        
        groupCell.addSubviews(subCell1, subCell2)

        groupCell.heightAnchor.constraint(equalToConstant: 104).isActive = true
        
        subCell1.leftAnchor.constraint(equalTo: groupCell.leftAnchor).isActive = true
        subCell2.rightAnchor.constraint(equalTo: groupCell.rightAnchor).isActive = true
        
        subCell1.addTarget(self, action: #selector(self.showOnTap), for: .touchUpInside)
        subCell2.addTarget(self, action: #selector(self.showOnTap), for: .touchUpInside)
                
        return groupCell
    }
    
    let popupVC: GenerationPopUpViewController = {
        let viewController = GenerationPopUpViewController()
        viewController.modalPresentationStyle = .overCurrentContext
        return viewController
    }()
    
    @objc func tapWithoutPopUp() {
        self.navigationController?.pushViewController(SelectionRuneController(), animated: false)
    }
    
    @objc func showOnTap(sender: GenerationRuneCell) {
        
        popupVC.setupModel(sender.runeModel)
        popupVC.submitButton.isHidden = !sender.canGenerate

        self.addChild(popupVC)
        self.view.addSubview(popupVC.view)
        popupVC.view.frame = self.view.bounds
        
        if (sender.canGenerate) {
            popupVC.setupAction(.runeSelectTitle, #selector(self.selectOnTap))
        }

        popupVC.didMove(toParent: self)
    }

    @objc func selectOnTap() {
        self.navigationController?.pushViewController(SelectionRuneController(), animated: false)
    }
}
