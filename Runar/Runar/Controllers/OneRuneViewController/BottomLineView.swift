//
//  BottomLineView.swift
//  Runar
//
//  Created by Юлия Лопатина on 14.03.21.
//

import UIKit

final class BottomLineView: UIView {
    
    private var runesSet = [RuneType]()
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        setVectorsConstr()
        setUpPageControl()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(runesSet: [RuneType]) {
        self.init(frame: .zero)
        self.runesSet = runesSet
    }
    
    private var blackLayer: CAGradientLayer = {
        let layer0 = CAGradientLayer()
        layer0.colors = [
          UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor,
          UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        ]
        layer0.locations = [0, 0.43]
        layer0.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer0.endPoint = CGPoint(x: 0.75, y: 0.5)
        layer0.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0))
        return layer0
    }()
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        blackLayer.bounds = self.bounds.insetBy(dx: -0.5*self.bounds.size.width, dy: -0.5*self.bounds.size.height)
//        blackLayer.position = self.center
//        self.layer.addSublayer(blackLayer)
//        self.layer.cornerRadius = 20
//
//    }
    //MARK: - Vectors
    
    private let leftVectror: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "popUpVectorLeft")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let rightVectror: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "popUpVectorRight")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private func setVectorsConstr() {
        self.addSubview(leftVectror)
        self.addSubview(rightVectror)
        NSLayoutConstraint.activate([
            leftVectror.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24.heightDependent()),
            leftVectror.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30.heightDependent()),
            leftVectror.heightAnchor.constraint(equalToConstant: 12.heightDependent()),
            leftVectror.widthAnchor.constraint(equalToConstant: 22.heightDependent()),
            
            rightVectror.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            rightVectror.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30.heightDependent()),
            rightVectror.heightAnchor.constraint(equalToConstant: 12.heightDependent()),
            rightVectror.widthAnchor.constraint(equalToConstant: 22.heightDependent())
        ])
    }
    
    private func setUpPageControl()  {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 5
        pageControl.currentPage = 2
        pageControl.currentPageIndicatorTintColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1)
        pageControl.pageIndicatorTintColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 0.3)
       pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(pageControl)
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15.heightDependent()),
            pageControl.heightAnchor.constraint(equalToConstant: 45.heightDependent()),
            pageControl.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    
}
}
