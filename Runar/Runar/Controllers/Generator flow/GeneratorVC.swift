//
//  GeneratorVC.swift
//  Runar
//
//  Created by George Stupakov on 02/08/2022.
//

import UIKit

class GeneratorVC: UIViewController {
    
    private let contentView = GeneratorView()
    private let viewModel = GeneratorModel()

    let popupVC: GenerationPopUpViewController = {
        let viewController = GenerationPopUpViewController()
        viewController.modalPresentationStyle = .overCurrentContext
        return viewController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        view = contentView
        contentView.delegate = self
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }

    private func configureNavigationBar() {

        if !DeviceType.iPhoneSE && !DeviceType.isIPhone678 {
            title = .generator
            navigationController?.navigationBar.configure(prefersLargeTitles: true, titleFontSize: 34)
        } else {
            navigationController?.navigationBar.configure(prefersLargeTitles: false, titleFontSize: 20)
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UILabel.create(withText: .generator, fontSize: 20))
        }
        navigationController?.setStatusBar(backgroundColor: .navBarBackground)
    }
}

extension GeneratorVC: GeneratorViewDelegateProtocol {
    
    func didTapWithoutPopUp() {
        self.navigationController?.pushViewController(SelectionRuneVC(), animated: true)
    }
    
    func didTapShowFormulaPopupTap() {

        popupVC.setupPopUp(image: Assets.runeFormula.image,
                                   header: L10n.Generator.RuneFormula.title,
                                   description: L10n.Generator.RuneFormula.description)
        popupVC.submitButton.isHidden = true
        self.addChild(popupVC)
        self.view.addSubview(popupVC.view)
        popupVC.view.frame = self.view.bounds
        popupVC.didMove(toParent: self)
    }
    
    func didTapShowStavesPopupTap() {

        popupVC.setupPopUp(image: Assets.runeStaves.image,
                                   header: L10n.Generator.RuneStaves.title,
                                   description: L10n.Generator.RuneStaves.description)
        popupVC.submitButton.isHidden = true
        self.addChild(popupVC)
        self.view.addSubview(popupVC.view)
        popupVC.view.frame = self.view.bounds
        popupVC.didMove(toParent: self)
    }
}
