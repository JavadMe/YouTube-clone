//
//  VideoCell.swift
//  YouTube clone
//
//  Created by Javad Mammadbeyli on 211//2017.
//  Copyright © 2017 Javad Mammadbeyli. All rights reserved.
//

import Foundation
import UIKit

class VideoCell: UICollectionViewCell {
    
    let profileImageSize = CGFloat(40.0)
    let largePadding = CGFloat(16.0)
    let smallPadding = CGFloat(8.0)
    let seperatorHeight = CGFloat(1.0)
    
    
    lazy var thumbnailImageView: UIImageView = {
        var imageView = UIImageView(image: #imageLiteral(resourceName: "taylor"));
        imageView.translatesAutoresizingMaskIntoConstraints = false
        //imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    lazy var seperatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0, alpha: 0.1)
        return view
    }()
    
    lazy var profileImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor.red
        imageView.image = UIImage(named: "profileImage")
        imageView.layer.cornerRadius = profileImageSize/2
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "15+ Epic Design Fails That You Will Find Hard To Believe Actually Happened"
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 2
        return label
    }()
    
    lazy var durationLabel: EdgeInsetLabel = {
        let label = EdgeInsetLabel()
        label.leftTextInset = 4
        label.topTextInset = 2
        label.bottomTextInset = 2
        label.rightTextInset = 4
        label.text = "15:56"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor(white: 0.1, alpha: 0.9)
        label.textColor = UIColor.white
        label.layer.masksToBounds = true
        label.font = UIFont.systemFont(ofSize: 10)
        label.layer.cornerRadius = 2
        return label
    }()
    
    lazy var subLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Funny Life · 1.8M views · 2 months ago"
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 2
        label.textColor = UIColor.gray
        
        return label
    }()
    
    fileprivate func setupViews() {
        addSubview(thumbnailImageView)
        addSubview(profileImageView)
        addSubview(titleLabel)
        addSubview(subLabel)
        addSubview(seperatorView)
        
        NSLayoutConstraint.activate([
            thumbnailImageView.topAnchor.constraint(equalTo: topAnchor, constant: largePadding),
            thumbnailImageView.bottomAnchor.constraint(equalTo: profileImageView.topAnchor, constant: -8),
            thumbnailImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: largePadding),
            thumbnailImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -largePadding)
            ])
        
        NSLayoutConstraint.activate([
            titleLabel.trailingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 8),
            titleLabel.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 8)
            ])
        
        NSLayoutConstraint.activate([
            subLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            subLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor)
            ])
        
        NSLayoutConstraint.activate([
            profileImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            profileImageView.leadingAnchor.constraint(equalTo: thumbnailImageView.leadingAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: profileImageSize),
            profileImageView.heightAnchor.constraint(equalToConstant: profileImageSize)
            ])
        
        NSLayoutConstraint.activate([
            seperatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            seperatorView.widthAnchor.constraint(equalTo: widthAnchor),
            seperatorView.heightAnchor.constraint(equalToConstant: 1.0)
            ])
        
        thumbnailImageView.addSubview(durationLabel)
        NSLayoutConstraint.activate([
            durationLabel.bottomAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: -8),
            durationLabel.trailingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: -6),
            ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



