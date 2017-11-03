//
//  ViewController.swift
//  YouTube clone
//
//  Created by Javad Mammadbeyli on 111//2017.
//  Copyright © 2017 Javad Mammadbeyli. All rights reserved.
//

import UIKit

class HomeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    //var window: UIWindow = UIWindow()
    
    let statusBarView = UIView()
    let cellIdentififer = "cellId"
    
    lazy var videoView: VideoView = VideoView()
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if(velocity.y > 0){
            UIView.animate(withDuration: 2.5, animations: {
                self.navigationController?.setNavigationBarHidden(true, animated: true)
                //self.navigationController?.setToolbarHidden(true, animated: true)
                
                self.view.addSubview(self.statusBarView)
                
                NSLayoutConstraint.activate([
                    self.statusBarView.topAnchor.constraint(equalTo: self.view.topAnchor),
                    self.statusBarView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                    self.statusBarView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                    self.statusBarView.heightAnchor.constraint(equalToConstant: 20)
                    ])
            })
        } else if(velocity.y < -0.5 ) {
            UIView.animate(withDuration: 2.5, animations: {
                self.statusBarView.removeFromSuperview()
                self.navigationController?.setNavigationBarHidden(false, animated: true)
                //self.navigationController?.setToolbarHidden(false, animated: true)
            })
        }
    }
    
    fileprivate func setupBottomTabBar() {
        let tabBar = YouTubeTabBar()
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tabBar)
        
        NSLayoutConstraint.activate([
            tabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabBar.heightAnchor.constraint(equalToConstant: 45)
            ])
        
        
    }
    
    fileprivate func setupNavBar() {
        
        
        let accountImageView = UIImageView(image: UIImage(named: "account-icon")!.alpha(0.6))
        accountImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let searchImageView = UIImageView(image: UIImage(named: "search-icon")!.alpha(0.6))
        searchImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let youTubeLogo = UIImageView(image: #imageLiteral(resourceName: "youtube-logo"))
        youTubeLogo.translatesAutoresizingMaskIntoConstraints = false
        
        let camcorderLogo = UIImageView(image: UIImage(named: "camcorder-icon")!.alpha(0.6))
        camcorderLogo.translatesAutoresizingMaskIntoConstraints = false
        
        guard let navigationBarView = navigationController?.navigationBar else { return }
        //let accountBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "account-icon").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: nil)
        //let searchBarButtonItem = UIBarButtonItem(image:#imageLiteral(resourceName: "search-icon").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: nil)
        //let recordBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "camcorder-icon").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: nil)
        //navigationItem.rightBarButtonItems = [accountBarButtonItem, searchBarButtonItem]
        
        navigationBarView.isTranslucent = false
        navigationBarView.addSubview(accountImageView)
        navigationBarView.addSubview(searchImageView)
        navigationBarView.addSubview(youTubeLogo)
        navigationBarView.addSubview(camcorderLogo)
        
        let navBarIconSize = CGFloat(24)
        
        NSLayoutConstraint.activate([
            accountImageView.trailingAnchor.constraint(equalTo: navigationBarView.trailingAnchor, constant: -16),
            accountImageView.bottomAnchor.constraint(equalTo: navigationBarView.bottomAnchor, constant: -10),
            accountImageView.widthAnchor.constraint(equalToConstant: navBarIconSize),
            accountImageView.heightAnchor.constraint(equalToConstant: navBarIconSize)
            ])
        
        NSLayoutConstraint.activate([
            searchImageView.trailingAnchor.constraint(equalTo: accountImageView.leadingAnchor, constant: -24),
            searchImageView.bottomAnchor.constraint(equalTo: navigationBarView.bottomAnchor, constant: -10),
            searchImageView.widthAnchor.constraint(equalToConstant: navBarIconSize),
            searchImageView.heightAnchor.constraint(equalToConstant: navBarIconSize)
            ])
        
        NSLayoutConstraint.activate([
            camcorderLogo.trailingAnchor.constraint(equalTo: searchImageView.leadingAnchor, constant: -24),
            camcorderLogo.bottomAnchor.constraint(equalTo: navigationBarView.bottomAnchor, constant: -10),
            camcorderLogo.widthAnchor.constraint(equalToConstant: navBarIconSize),
            camcorderLogo.heightAnchor.constraint(equalToConstant: navBarIconSize)
            ])
        
        NSLayoutConstraint.activate([
            youTubeLogo.leadingAnchor.constraint(equalTo: navigationBarView.leadingAnchor, constant: 16),
            youTubeLogo.bottomAnchor.constraint(equalTo: navigationBarView.bottomAnchor, constant: -10),
            youTubeLogo.widthAnchor.constraint(equalToConstant: 100),
            youTubeLogo.heightAnchor.constraint(equalTo: navigationBarView.heightAnchor, multiplier: 0.5)
            ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: cellIdentififer)
        collectionView?.backgroundColor = .white
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 45, right: 0)
        
        statusBarView.backgroundColor = UIColor.white
        statusBarView.translatesAutoresizingMaskIntoConstraints = false
        
        setupNavBar()
        setupBottomTabBar()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentififer, for: indexPath) as! VideoCell
        if(indexPath.item % 2  == 0) {
            cell.titleLabel.text = "Taylor Swift - Blank Space"
            cell.subLabel.text = "TaylorSwiftVEVO · 2.2B views · 3 years ago"
            cell.durationLabel.text = "4:33"
            cell.thumbnailImageView.image = #imageLiteral(resourceName: "taylor")
        }else {
            cell.titleLabel.text = "INNA - Mai Frumoasa | Rock the Roof @Paris | Cover"
            cell.subLabel.text = "INNA · 2.8M views · 5 years ago"
            cell.durationLabel.text = "3:21"
            cell.thumbnailImageView.image = #imageLiteral(resourceName: "inna")
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 32)*9/16
        return CGSize(width: view.frame.width , height: height + 68)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let window = UIApplication.shared.keyWindow {
            videoView.frame = CGRect(x: 0, y: 40, width: window.frame.width, height: window.frame.height/2)
            videoView.videoImageView.image = indexPath.item % 2 == 0 ? #imageLiteral(resourceName: "taylor") : #imageLiteral(resourceName: "inna")
            videoView.alpha = 1
            videoView.minimized = false
            window.addSubview(videoView)
            
            UIView.animate(withDuration: 0.2, animations: {
                self.videoView.frame = CGRect(x: 0, y: 0, width: window.frame.width, height: window.frame.height)
            })
        }
    }

}
