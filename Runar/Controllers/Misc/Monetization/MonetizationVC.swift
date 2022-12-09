//
//  MonetizationVC.swift
//  Runar
//
//  Created by George Stupakov on 21/07/2022.
//

import UIKit
import StoreKit

class MonetizationVC: UIViewController {

    private let contentView = MonetizationView()
    private let viewModel = MonetizationModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func loadView() {
        view = contentView
        contentView.delegate = self
        viewModel.delegate = self
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

extension MonetizationVC: MonetizationViewDelegateProtocol, MonetizationModelDelegate {

    func didTapPremiumView() {
        viewModel.subscription = [IAPSubscriptions.premiumSubscription.rawValue]
    }
    
    func didTapPopularView() {
        viewModel.subscription = [IAPSubscriptions.popularSubscription.rawValue]
    }
    
    func didTapEternalView() {
        viewModel.subscription = [IAPSubscriptions.eternalSubscription.rawValue]
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
        viewModel.restorePurchase()
    }
    
    func didTapPayButton() {
        viewModel.getSubscription()
    }

    func didTapSkipkButton() {
        self.dismiss(animated: true, completion: nil)
    }

    func dismissScreenAfterPurchase() {
        self.dismiss(animated: true, completion: nil)
    }
}
