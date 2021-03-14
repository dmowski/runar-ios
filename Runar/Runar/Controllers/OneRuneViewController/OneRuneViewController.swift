//
//  OneRuneViewController.swift
//  Runar
//
//  Created by Юлия Лопатина on 14.03.21.
//

import UIKit

class OneRuneViewController: UIViewController {
    
    private var runeType : RuneType?
    public var runesSet = [RuneType]()
    private var runeTime = String()
    
    init(runeType: RuneType, runeTime: String) {
        super.init(nibName: nil, bundle: nil)
        self.runeType = runeType
        self.runeTime = runeTime
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setUpTopLineConstr()
        setUpBottomConstr()
    }
    
    private func setView() {
        view.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6).cgColor
        let stroke = UIView()
        stroke.bounds = view.bounds.insetBy(dx: -1, dy: -1)
        stroke.center = view.center
        view.addSubview(stroke)
        view.bounds = view.bounds.insetBy(dx: -1, dy: -1)
        stroke.layer.borderWidth = 1
        stroke.layer.borderColor = UIColor(red: 0.329, green: 0.329, blue: 0.345, alpha: 0.65).cgColor
        stroke.layer.cornerRadius = 20

    }
    
    private func setUpTopLineConstr() {
        let topLine = TopLineView(runeType: runeType ?? RuneType.sowilu, runeTime: runeTime)
        view.addSubview(topLine)
        NSLayoutConstraint.activate([
            topLine.topAnchor.constraint(equalTo: view.topAnchor),
            topLine.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topLine.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topLine.heightAnchor.constraint(equalToConstant: 153.heightDependent())
        ])
    }
    
    private func setUpBottomConstr() {
        let bottom = BottomLineView(runesSet: self.runesSet)
        bottom.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottom)
        NSLayoutConstraint.activate([
            bottom.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottom.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottom.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottom.heightAnchor.constraint(equalToConstant: 95.heightDependent())
        ])
    }


}
