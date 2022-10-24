//
//  DetailViewController.swift
//  MasCover-iOS
//
//  Created by taha_jadid on 23/10/2022.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var wallpaperImage: UIImageView!
    @IBOutlet weak var bottomRight: UIView!
    @IBOutlet weak var bottomLeft: UIView!
    @IBOutlet weak var download: UIView!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var dislikeImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initCorners()
        initView()
        
    }

    func initView(){
        let gestureDownload = UITapGestureRecognizer(target: self, action:  #selector (self.downloadAction (_:)))
        self.download.addGestureRecognizer(gestureDownload)
        
        let gestureSetWallpaper = UITapGestureRecognizer(target: self, action:  #selector (self.wallpaperdAction (_:)))
        self.download.addGestureRecognizer(gestureSetWallpaper)
        
        let gestureSetLike = UITapGestureRecognizer(target: self, action:  #selector (self.likeAction (_:)))
        self.download.addGestureRecognizer(gestureSetLike)
        
        let gestureSetDislike = UITapGestureRecognizer(target: self, action:  #selector (self.dislikeAction (_:)))
        self.download.addGestureRecognizer(gestureSetDislike)

    }
    
    func initCorners(){
        self.bottomRight.clipsToBounds = true
        self.bottomRight.layer.cornerRadius = 20
        self.bottomRight.layer.maskedCorners = [.layerMaxXMinYCorner]
        
        self.bottomLeft.clipsToBounds = true
        self.bottomLeft.layer.cornerRadius = 20
        self.bottomLeft.layer.maskedCorners = [.layerMinXMinYCorner]
        
    
        self.download.layer.cornerRadius = self.download.frame.width / 2
    }

    @objc func downloadAction(_ sender:UITapGestureRecognizer){
        // do other task
        let homeViewController = HomeViewController()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if let navigationController = self.navigationController {
              navigationController.pushViewController(homeViewController, animated: true)
            }
        }
    }
    
    @objc func wallpaperdAction(_ sender:UITapGestureRecognizer){
        // do other task
        let homeViewController = HomeViewController()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if let navigationController = self.navigationController {
              navigationController.pushViewController(homeViewController, animated: true)
            }
        }
    }
    
    @objc func likeAction(_ sender:UITapGestureRecognizer){
        // do other task
        let homeViewController = HomeViewController()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if let navigationController = self.navigationController {
              navigationController.pushViewController(homeViewController, animated: true)
            }
        }
    }
    
    @objc func dislikeAction(_ sender:UITapGestureRecognizer){
        // do other task
        let homeViewController = HomeViewController()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if let navigationController = self.navigationController {
              navigationController.pushViewController(homeViewController, animated: true)
            }
        }
    }
     
}
