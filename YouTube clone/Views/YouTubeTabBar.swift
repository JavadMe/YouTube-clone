//
//  YouTubeTabBar.swift
//  YouTube clone
//
//  Created by Javad Mammadbeyli on 211//2017.
//  Copyright © 2017 Javad Mammadbeyli. All rights reserved.
//

import Foundation
import UIKit

class YouTubeTabBar : UITabBar, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout   {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(TabBarItemViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.backgroundColor = .white
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    let cellId = "cid"
    let sectionNames = ["Home", "Trending", "Subscriptions", "Activity", "Library"]
    let sectionIcons = [#imageLiteral(resourceName: "home-icon"), #imageLiteral(resourceName: "trending-icon"), #imageLiteral(resourceName: "subscriptions-icon"), #imageLiteral(resourceName: "activity-icon"), #imageLiteral(resourceName: "library-icon")]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isTranslucent = false
        
        
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0)
            ])
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TabBarItemViewCell
        
        
        cell.label.text = sectionNames[indexPath.item]
        
        let templateImage = sectionIcons[indexPath.item].withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        cell.icon.image = templateImage
        cell.icon.tintColor = .darkGray
        
        if(indexPath.item == 0) {
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/5, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


