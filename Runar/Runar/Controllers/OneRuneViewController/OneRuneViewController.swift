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
    var topLine : TopLineView?
    var bottomLine : BottomLineView?
    
    init(runeType: RuneType, runeTime: String) {
        super.init(nibName: nil, bundle: nil)
        self.runeType = runeType
        self.runeTime = runeTime
        topLine = TopLineView(runeType: runeType , runeTime: runeTime)
        bottomLine = BottomLineView(runesSet: runesSet)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setUpTopLineConstr()
        setUpBottomConstr()
        setUpScrollViewDescription()
        setUpDescriptionLabel()
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
        guard let topLine = topLine else {return}
        view.addSubview(topLine)
        NSLayoutConstraint.activate([
            topLine.topAnchor.constraint(equalTo: view.topAnchor),
            topLine.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topLine.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topLine.heightAnchor.constraint(equalToConstant: 153.heightDependent())
        ])
    }
    
    private func setUpBottomConstr() {
        guard let bottomLine = bottomLine else {return}
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomLine)
        NSLayoutConstraint.activate([
            bottomLine.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomLine.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomLine.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomLine.heightAnchor.constraint(equalToConstant: 95.heightDependent())
        ])
    }
    
    //-------------------------------------------------
    // MARK: - ScrollViewDescription
    //-------------------------------------------------
    
    private var scrollViewDescription = UIScrollView()
    private let contentLabel = UILabel()
    
    private func setUpScrollViewDescription() {
        guard let topLine = topLine else {return}
        guard let bottomLine = bottomLine else {return}
        
        scrollViewDescription.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollViewDescription)
        
        NSLayoutConstraint.activate([
            scrollViewDescription.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollViewDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            scrollViewDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            scrollViewDescription.topAnchor.constraint(equalTo: topLine.bottomAnchor),
            scrollViewDescription.bottomAnchor.constraint(equalTo: bottomLine.topAnchor),
        ])
    }
    
    //-------------------------------------------------
    // MARK: - DescriptionLabel
    //-------------------------------------------------
    
    private func setUpDescriptionLabel() {
        let descriptionLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            label.sizeToFit()
            return label
        }()
        
        guard let description = runeType?.description else {return}
       
        let timeParagraphStyle = NSMutableParagraphStyle()
        timeParagraphStyle.lineHeightMultiple = 1.23
        
        let atributes: [NSAttributedString.Key: Any] = [
            .font: FontFamily.SFProDisplay.light.font(size: 19),
            .foregroundColor: UIColor(red: 0.855, green: 0.855, blue: 0.855, alpha: 1),
            .paragraphStyle: timeParagraphStyle,
            .kern: -0.38,
        ]
        descriptionLabel.attributedText = NSMutableAttributedString(string: description, attributes: atributes)
    
        scrollViewDescription.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: scrollViewDescription.topAnchor),
            descriptionLabel.widthAnchor.constraint(equalTo: scrollViewDescription.widthAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: scrollViewDescription.bottomAnchor)
        ])
    }
}
