//
//  TabBarViewCell.swift
//  YouTube clone
//
//  Created by Javad Mammadbeyli on 211//2017.
//  Copyright © 2017 Javad Mammadbeyli. All rights reserved.
//

import Foundation
import UIKit

class TabBarItemViewCell: UICollectionViewCell {
    
    var image: UIImage = UIImage() {
        didSet {
            icon.image = image.withRenderingMode(.alwaysTemplate)
            icon.tintColor = color
        }
    }
    
    var color: UIColor = UIColor.darkGray
    
    override var isSelected: Bool {
        didSet{
            color = isSelected ? .red : .darkGray
            label.textColor = color
            let templateImage = icon.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
            icon.image = templateImage
            icon.tintColor = color
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            let color: UIColor = isHighlighted ? .red : .darkGray
            label.textColor = color
            let templateImage = icon.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
            icon.image = templateImage
            icon.tintColor = color
        }
    }
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Home"
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.darkGray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var icon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let templateImage = #imageLiteral(resourceName: "home-icon").withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        imageView.image = templateImage
        imageView.tintColor = .gray
        
        return imageView
    }()
    
    fileprivate func setupViews() {
        addSubview(icon)
        addSubview(label)
        
        NSLayoutConstraint.activate([
            icon.centerXAnchor.constraint(equalTo: centerXAnchor),
            icon.topAnchor.constraint(equalTo: topAnchor)
            ])
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        isUserInteractionEnabled = true
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
