//
//  OneRuneViewController.swift
//  Runar
//
//  Created by Юлия Лопатина on 14.03.21.
//

import UIKit


class OneRuneViewController: UIViewController {
    
    var runesVC = {() -> () in
        return
    }
    private var runeType : RuneType?
    public var runesSet = [RuneType]()
    private var runeLayout : RuneLayout?
    private var topWithDescription: TopWithDescriptionView?
    private var bottomLine : BottomLineView?
    
    init(runeType: RuneType, runeLayout: RuneLayout, runesSet: [RuneType]) {
        super.init(nibName: nil, bundle: nil)
        self.runeType = runeType
        self.runeLayout = runeLayout
        self.runesSet = runesSet
        pageScroll.delegate = self
        bottomLine = BottomLineView(runesSet: runesSet, runeType: runeType)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setUpBottomConstr()
        configurePageScroll()
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
    
    private func setUpBottomConstr() {
        guard let bottomLine = bottomLine else {return}
        bottomLine.movePage = { current in
            self.pageScroll.setContentOffset(CGPoint(x: CGFloat(current) * self.view.frame.size.width, y: 0), animated: true)
        }
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomLine)
        NSLayoutConstraint.activate([
            bottomLine.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomLine.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomLine.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomLine.heightAnchor.constraint(equalToConstant: 95.heightDependent())
        ])
    }
    
    private var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    private var pageScroll = UIScrollView()

    private func configurePageScroll() {
        pageScroll.translatesAutoresizingMaskIntoConstraints = false
        guard let bottomLine = bottomLine else {return}
        view.addSubview(pageScroll)
        NSLayoutConstraint.activate([
            pageScroll.topAnchor.constraint(equalTo: view.topAnchor),
            pageScroll.leadingAnchor.constraint(equalTo:view.leadingAnchor),
            pageScroll.bottomAnchor.constraint(equalTo: bottomLine.topAnchor),
            pageScroll.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        var previousAnchor = pageScroll.leadingAnchor
        for index in 0..<runesSet.count {
            guard let runeLayout = runeLayout else {return}
            let page = TopWithDescriptionView(runeType: runesSet[index], runeTime: runesSet[index].configureRuneTime(runeLayout: runeLayout, index: index))
            page.close = { [self] in
            self.willMove(toParent: nil)
            self.view.removeFromSuperview()
            self.removeFromParent()
                runesVC()
            }
            pageScroll.addSubview(page)
            NSLayoutConstraint.activate([
                page.leadingAnchor.constraint(equalTo: previousAnchor),
                page.widthAnchor.constraint(equalToConstant: self.view.frame.size.width),
                page.topAnchor.constraint(equalTo: view.topAnchor),
                page.bottomAnchor.constraint(equalTo: bottomLine.topAnchor)
            ])
            previousAnchor = page.trailingAnchor
            
        }
        previousAnchor.constraint(equalTo: pageScroll.trailingAnchor).isActive = true
        }
    }

extension OneRuneViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        bottomLine?.pageControl.currentPage = Int(floorf(Float(pageScroll.contentOffset.x) / Float(scrollView.frame.size.width)))
    }
}

