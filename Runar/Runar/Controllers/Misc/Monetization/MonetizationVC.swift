//
//  MonetizationVC.swift
//  Runar
//
//  Created by George Stupakov on 21/07/2022.
//

import UIKit

class MonetizationVC: UIViewController {
    
    private let contentView = MonetizationView()
    private let viewModel = MonetizationModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func loadView() {
        view = contentView
        contentView.delegate = self
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }

    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
}


extension MonetizationVC: MonetizationViewDelegateProtocol {

    // TODO: -
    func didTapPremiumView() {
        print("didTapPremiumView")
    }
    
    func didTapPopularView() {
        print("didTapPopularView")
    }
    
    func didTapEternalView() {
        print("didTapEternalView")
    }
    
    func didTapTermsOfUseButton() {
        if let urlTermsOfUse = URL(string: "https://runar.app/privacy#!/tab/487213487-2") {
            UIApplication.shared.open(urlTermsOfUse)
        }
    }
    
    func didTapPrivacyPolicyButton() {
        if let urlPrivacyPolicy = URL(string: "https://runar.app/privacy") {
            UIApplication.shared.open(urlPrivacyPolicy)
        }
    }
    
    func didTapRestoreButton() {
        print("didTapRestoreButton")
    }
    
    func didTapPayButton() {
        print("didTapGoPremiumButton")
    }

    func didTapSkipkButton() {
        self.dismiss(animated: true, completion: nil)
    }
}
