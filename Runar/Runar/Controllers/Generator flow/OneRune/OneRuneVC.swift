//
//  OneRuneVC.swift
//  Runar
//
//  Created by Юлия Лопатина on 14.03.21.
//

import UIKit

class OneRuneVC: UIViewController {
    
    // MARK: Constant
    let heightBottomLine = 95
    
    var closeVC = {() -> () in return }
    var runesSet = [RuneType]()
    private var runeType : RuneType?
    private var runeLayout : RuneLayout?
    private var index: Int?
    private var topWithDescription: TopWithDescriptionView?
    private var bottomLine : BottomLineView?
    var leaveLightAndMakeDark : ((Int)->())?
    var removeAllDark: (()->())?
    var changeContentOffset: ((CGRect)->())?
    var buttonFrames: [CGRect]?
    var luck: String
    
    init(runeType: RuneType, runeLayout: RuneLayout, runesSet: [RuneType], index: Int, luck: String) {
        self.luck = luck
        super.init(nibName: nil, bundle: nil)
        self.runeType = runeType
        self.runeLayout = runeLayout
        self.runesSet = runesSet
        self.index = index
        pageScroll.delegate = self
        bottomLine = BottomLineView(runesSet: runesSet, runeType: runeType)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6).cgColor
        setUpBottomConstr()
        configurePageScroll()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        let buttonFrame = buttonFrames?[index ?? 0]
        changeContentOffset!(buttonFrame!)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        openCurrentPage()
    }
    
    private func setUpBottomConstr() {
        guard let bottomLine = bottomLine else {return}
        bottomLine.movePage = { current in
            self.pageScroll.setContentOffset(CGPoint(x: CGFloat(current) * self.view.frame.size.width, y: 0), animated: true)
        }
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomLine)

        bottomLine.snp.makeConstraints { make in
            make.trailing.leading.bottom.equalToSuperview()
            make.height.equalTo(heightBottomLine)
        }
    }
    
    private var pageScroll = UIScrollView()
    
    private func configurePageScroll() {
        pageScroll.translatesAutoresizingMaskIntoConstraints = false
        guard let bottomLine = bottomLine else {return}
        view.addSubview(pageScroll)

        pageScroll.snp.makeConstraints { make in
            make.top.trailing.leading.equalToSuperview()
            make.bottom.equalTo(bottomLine.snp.top)
        }
        
        var previousAnchor = pageScroll.snp.leading
        for index in 0..<runesSet.count {
            guard let runeLayout = runeLayout else {return}
            let page = TopWithDescriptionView(runeType: runesSet[index], runeTime: runesSet[index].configureRuneTime(runeLayout: runeLayout, index: index), luck: luck ?? "")
            page.close = { [self] in
                self.willMove(toParent: nil)
                self.view.removeFromSuperview()
                self.removeFromParent()
                closeVC()
                removeAllDark!()
            }
            pageScroll.addSubview(page)
            
            page.snp.makeConstraints { make in
                make.leading.equalTo(previousAnchor)
                make.width.equalTo(self.view.frame.size.width)
                make.top.equalToSuperview()
                make.bottom.equalTo(bottomLine.snp.top)
            }
            previousAnchor = page.snp.trailing
            
        }
    }
    
    private func openCurrentPage() {
        self.pageScroll.setContentOffset(CGPoint(x: view.frame.size.width * CGFloat(self.index!), y: 0.0), animated: true)
    }
}

extension OneRuneVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let changeContentOffset = changeContentOffset else {return}
        bottomLine?.pageControl.currentPage = Int(floorf(Float(pageScroll.contentOffset.x) / Float(view.frame.size.width)))
        let index = (bottomLine?.pageControl.currentPage)!
        self.removeAllDark!()
        self.leaveLightAndMakeDark!(index)
        guard let frame = buttonFrames?[index] else { return }
        changeContentOffset(frame)
    }
}

