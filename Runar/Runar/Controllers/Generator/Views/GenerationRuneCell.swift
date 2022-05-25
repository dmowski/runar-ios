//
//  RunePatternCell.swift
//  Runar
//
//  Created by Maksim Harbatsevich on 9/21/21.
//

import UIKit

public class GenerationRuneCell : UIControl {
    var runeModel: GenerationRuneModel?
    var canGenerate: Bool = true
    
    init(withheight height: CGFloat, withWidth width: CGFloat){
        super.init(frame: CGRect(x: 0, y: 0, width: width, height: height))
        configureView(withheight: height, withWidth: width)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupModel(_ model: GenerationRuneModel){
        self.runeModel = model
    }
    
    public func readOnly() {
        self.canGenerate = false
    }
    
    private func configureView(withheight height: CGFloat, withWidth width: CGFloat) -> Void {
        let layer = CALayer()
                
        layer.bounds = self.bounds
        layer.position = self.center
        
        self.clipsToBounds = true
        self.layer.addSublayer(layer)
        
        self.layer.cornerRadius = 16
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red: 0.824, green: 0.769, blue: 0.678, alpha: 0.6).cgColor
        self.layer.backgroundColor = UIColor(red: 0.063, green: 0.063, blue: 0.063, alpha: 0.35).cgColor
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
}

public extension GenerationRuneCell {
    static func createMain(withTitle title: String, withDescription description: String, withType type: GenerationRuneType = .pattern) -> GenerationRuneCell {
        
        let cell = GenerationRuneCell(withheight: 260, withWidth: 260)
        
        cell.setupModel(GenerationRuneModel.create(title: title, description: description, type: type))
        
        let label = createLabel(title: title, size: 36, lineHeight: 0.7, height: 42)
        
        let imageView = createImage(runeImage: type.image)
                                  
        cell.addSubviews(label, imageView)
     
        label.centerXAnchor.constraint(equalTo: cell.centerXAnchor).isActive = true
        label.topAnchor.constraint(equalTo: cell.topAnchor, constant: 16).isActive = true
        
        imageView.centerXAnchor.constraint(equalTo: cell.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: label.bottomAnchor).isActive = true
        
        return cell
    }
    
    static func createSub(withTitle title: String, withDescription description: String, withType type: GenerationRuneType) -> GenerationRuneCell {
        let cell = GenerationRuneCell(withheight: 102, withWidth: 122)
        
        cell.setupModel(GenerationRuneModel.create(title: title, description: description, type: type))
        cell.readOnly()
        
        let label = createLabel(title: title, size: 16, lineHeight: 0.99, height: 20)
                    
        let imageView = createImage(runeImage: type.image)
                                  
        cell.addSubviews(label, imageView)
     
        label.centerXAnchor.constraint(equalTo: cell.centerXAnchor).isActive = true
        label.topAnchor.constraint(equalTo: cell.topAnchor, constant: 8).isActive = true
        
        imageView.centerXAnchor.constraint(equalTo: cell.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: label.bottomAnchor).isActive = true
        
        return cell
    }
    
    private static func createLabel(title: String, size: CGFloat, lineHeight: CGFloat, height: CGFloat) -> UILabel {
        return UILabel.createAmatic(title: title, size: size, lineHeight: lineHeight, height: height)
    }
    
    private static func createImage(runeImage: GenerationRuneImage) -> UIImageView {
        let imageView = UIImageView(image: runeImage.image)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        
        imageView.heightAnchor.constraint(equalToConstant: runeImage.height!).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: runeImage.width!).isActive = true
        
        return imageView
    }
}

extension UILabel {
    static func createAmatic(title: String, size: CGFloat, lineHeight: CGFloat, height: CGFloat) -> UILabel{
        let label = UILabel()
               
        label.font = FontFamily.AmaticSC.bold.font(size: size)
        label.textColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1)
        label.textAlignment = .center
        label.contentMode = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let prgph = NSMutableParagraphStyle()
        
        prgph.lineHeightMultiple = lineHeight
        
        label.attributedText = NSMutableAttributedString(string: title, attributes: [NSAttributedString.Key.paragraphStyle: prgph])
        
        label.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        return label
    }
}
