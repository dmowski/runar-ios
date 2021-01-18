//
//  CollectionViewController.swift
//  Runar
//
//  Created by Юлия Лопатина on 17.12.20.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {

    private let floatingImage = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for family in UIFont.familyNames.sorted() {
            let names = UIFont.fontNames(forFamilyName: family)
            print("Family: \(family) Font names: \(names)")
        }
        let mainImage: UIImage? = UIImage(named: "main")
        let mainImageView: UIImageView = UIImageView(image: mainImage)
        mainImageView.contentMode = .scaleAspectFill
        collectionView.backgroundView = mainImageView
        navigationController?.navigationBar.isHidden = true
        collectionView.delaysContentTouches = false
        
        createFloatingButton()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        
        collectionView.register(MainCell.self, forCellWithReuseIdentifier: MainCell.reuseIdentifier)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false 
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 8
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCell.reuseIdentifier, for: indexPath) as! MainCell
        cell.nameFor(indexPath: indexPath)
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let name = DataBase().namesDataSourse[indexPath.item]
        if UserDefaults.standard.bool(forKey: name) == true {
            
        } else {
        let alInfVC = AlignmentInfoViewController(name: name)
        alInfVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(alInfVC, animated: true)
        }
    }
    
    var pointingToBottom: Bool = true {
        didSet {
            guard oldValue != pointingToBottom else { return }
            if pointingToBottom {
                floatingImage.image = UIImage(named: "floatingDown")
            } else {
                floatingImage.image = UIImage(named: "floatingUp")
            }
        }
    }
    
    private func createFloatingButton() {
        floatingImage.image = UIImage(named: "floatingDown")
        floatingImage.translatesAutoresizingMaskIntoConstraints = false
        collectionView.addSubview(floatingImage)
        
        NSLayoutConstraint.activate([
            floatingImage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -4),
            floatingImage.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
            floatingImage.widthAnchor.constraint(equalToConstant: 77),
            floatingImage.heightAnchor.constraint(equalToConstant: 24),
        ])
        
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentSize != .zero  && (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)/2) {
            pointingToBottom = false
        } else {
            pointingToBottom = true
        }
    }
    
    
    
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = view.bounds.width
            let padding: CGFloat = 16
            let minimumItemSpasing: CGFloat = 16
            let availableWidth = width - (padding * 2) - minimumItemSpasing
            let itemWidth = availableWidth / 2
        let aspectRatio: CGFloat = 183 / 199
        return CGSize(width: itemWidth, height: itemWidth / aspectRatio)
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 25, left: 16, bottom: 16, right: 16)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}
