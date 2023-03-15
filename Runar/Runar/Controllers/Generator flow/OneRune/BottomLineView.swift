//
//  BottomLineView.swift
//  Runar
//
//  Created by Юлия Лопатина on 14.03.21.
//

import UIKit

final class BottomLineView: UIView {
    
    // MARK: Constants
    let vectorSize: CGFloat = DeviceType.iPhoneSE ? 40 : 48
    let trailingLeadingVector = 24
    let pageControlHeight = 45
    
    private var runesSet = [RuneType]()
    private var runeType : RuneType?
    var pageControl = UIPageControl()
    var movePage: ((CGFloat)->())?
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        addBlackView()
        setVectorsConstr()
        setUpPageControl()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(runesSet: [RuneType], runeType: RuneType) {
        self.init(frame: .zero)
        self.runesSet = runesSet
        self.runeType = runeType
        pageControl.numberOfPages = runesSet.count
        pageControl.currentPage = runesSet.firstIndex(of: runeType)!
    }
    
    //MARK: -BlackView
    private var blackView: UIImageView = {
        let blackView = UIImageView()
        blackView.image = Assets.Background.bottomBlackGradient.image
        blackView.translatesAutoresizingMaskIntoConstraints = false
        return blackView
    }()
    
    private func addBlackView() {
        self.addSubview(blackView)

        blackView.snp.makeConstraints { make in
            make.top.trailing.leading.bottom.equalToSuperview()
        }
    }
    
    //MARK: - Vectors
    
    private let leftVectror: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "popUpVectorLeft")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let rightVectror: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "popUpVectorRight")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private func setVectorsConstr() {
        let tapGestureLeft = UITapGestureRecognizer()
        leftVectror.addGestureRecognizer(tapGestureLeft)
        tapGestureLeft.addTarget(self, action: #selector(lefrVectorTap))
        let tapGestureRight = UITapGestureRecognizer()
        rightVectror.addGestureRecognizer(tapGestureRight)
        tapGestureRight.addTarget(self, action: #selector(rightVectorTap))
        self.addSubview(leftVectror)
        self.addSubview(rightVectror)

        leftVectror.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(trailingLeadingVector)
            make.bottom.equalToSuperview()
            make.height.width.equalTo(vectorSize)
        }
        
        rightVectror.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(trailingLeadingVector)
            make.bottom.equalToSuperview()
            make.height.width.equalTo(vectorSize)
        }
    }
    
    @objc private func lefrVectorTap() {
        guard let movePage = movePage else {return}
        var current:CGFloat = CGFloat(pageControl.currentPage-1)
        if current < 0 {
            current = CGFloat(pageControl.numberOfPages - 1)
        }
        movePage(current)
    }
    
    @objc private func rightVectorTap() {
        guard let movePage = movePage else {return}
        var current:CGFloat = CGFloat(pageControl.currentPage+1)
        if current > CGFloat(pageControl.numberOfPages-1) {
            current = 0
        }
        movePage(current)
    }
    
    private func setUpPageControl()  {
        pageControl.currentPageIndicatorTintColor = .yellowPrimaryColor
        pageControl.pageIndicatorTintColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 0.3)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.addTarget(self, action: #selector(pageControlDidChange(_:)), for: .valueChanged)
        
        self.addSubview(pageControl)

        pageControl.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.height.equalTo(pageControlHeight)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc private func pageControlDidChange(_ sender: UIPageControl) {
        let current = sender.currentPage
        guard let movePage = movePage else {return}
        movePage(CGFloat(current))
    }
}
