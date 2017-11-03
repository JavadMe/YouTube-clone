//
//  VideoView.swift
//  YouTube clone
//
//  Created by Javad Mammadbeyli on 211//2017.
//  Copyright © 2017 Javad Mammadbeyli. All rights reserved.
//

import Foundation
import UIKit

class VideoView: UIView {
    
    var _alpha: CGFloat = 1
    let minHeight: CGFloat = 170*9/16
    let minWidth: CGFloat = 170
    var startLocation: CGFloat = 0
    var minY: CGFloat = 0
    var minX: CGFloat = 0
    let _window: UIWindow = UIWindow()
    
    lazy var bottomView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(videoInfoView)
        
        NSLayoutConstraint.activate([
            videoInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            videoInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            videoInfoView.topAnchor.constraint(equalTo: view.topAnchor),
            videoInfoView.heightAnchor.constraint(equalToConstant: 100)
            ])
        return view
    }()
    
    var minimized = false {
        didSet{
            if(minimized){
                  bottomView.removeFromSuperview()
            }else {
                addSubview(bottomView)
                
                NSLayoutConstraint.activate([
                    bottomView.leadingAnchor.constraint(equalTo: leadingAnchor),
                    bottomView.trailingAnchor.constraint(equalTo: trailingAnchor),
                    bottomView.topAnchor.constraint(equalTo: videoImageView.bottomAnchor),
                    bottomView.bottomAnchor.constraint(equalTo: bottomAnchor)
                    ])
                
            }
            print("minimized \(minimized)")
        }
    }
    
    override var frame: CGRect {
        didSet {
            _alpha = frame.height/_window.frame.height
            self.backgroundColor =  UIColor(white: 1, alpha: _alpha)
            bottomView.alpha = _alpha
            videoImageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.width*9/16)
        }
    }
    
    lazy var videoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "inna")
        imageView.backgroundColor = .red
        imageView.isUserInteractionEnabled = true
        imageView.addSubview(self.progressIndicatorView)
        
        NSLayoutConstraint.activate([
            self.progressIndicatorView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            self.progressIndicatorView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            self.progressIndicatorView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            self.progressIndicatorView.heightAnchor.constraint(equalToConstant: 4)
            ])
        
        return imageView
    }()
    
    lazy var progressIndicatorView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()
    
    lazy var videoInfoView: UIView = {
        let view = UIView()
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        titleLabel.text = "INNA - Mai Frumoasa | Rock the Roof @Paris | Cover"
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.numberOfLines = 2
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9)
            ])
        
        let numberOfViewsLabel = UILabel()
        numberOfViewsLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(numberOfViewsLabel)
        numberOfViewsLabel.text = "45K views"
        numberOfViewsLabel.textColor = .gray
        numberOfViewsLabel.font = UIFont.systemFont(ofSize: 12)
        
        NSLayoutConstraint.activate([
            numberOfViewsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            numberOfViewsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            ])
        //view.frame = CGRect(x: 0, y: self.videoImageView.frame.height, width: self.frame.width, height: 100)
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.backgroundColor = .gray
        return view
    }()
    
    @objc func handlePan(recognizer: UIPanGestureRecognizer) {
        var startLocation: CGFloat = 0
            self.alpha = 1
        
        if (recognizer.state == .began) {
            startLocation = recognizer.location(in: _window).y
        }else {
            startLocation = 0
        }
        
        let panLocationY = recognizer.location(in: _window).y - startLocation
        let panRatioY = panLocationY/_window.frame.height*0.9
        let panLocationX = recognizer.location(in: _window).x
        let panRatioX = panLocationX/_window.frame.width
        let panTranslationX = recognizer.translation(in: window).x
        let panTranslationY = recognizer.translation(in: window).y
        
        if(recognizer.state == .ended) {
            UIView.animate(withDuration: 0.3, animations: {
                if(panLocationY != 0){
                    let isInMinimizeArea = self.frame.minY >= self.minY
                    self.minimized = isInMinimizeArea
                    self.frame = !isInMinimizeArea ? self._window.frame : CGRect(x: self.minX, y: self.minY, width: self.minWidth, height: self.minHeight)
                }
            })
            
        }else if(recognizer.state != .began){
            if(!minimized || panTranslationY < panTranslationX){
                self.frame = CGRect(x: min(_window.frame.width*panRatioY, minX), y: min(_window.frame.height*panRatioY, minY) , width: max(_window.frame.width*(1 - panRatioY), minWidth ), height: max(_window.frame.height*(1 - panRatioY) - 53, minHeight ))
            } else if(panRatioY != 0) {
                self.frame = CGRect(x: min(_window.frame.width*panRatioX, minX), y: self.minY , width: minWidth, height: minHeight)
                self.alpha = panRatioX*4
                
                if(frame.minX <= 10) {
                    removeFromSuperview()
                }
            }
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        guard let window = UIApplication.shared.keyWindow else { return }
        minY = window.frame.height - minHeight - 53
        minX = window.frame.width - minWidth - 8
        backgroundColor = .white
        addSubview(videoImageView)
        //addSubview(bottomView)
        
        videoImageView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan(recognizer:))))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

