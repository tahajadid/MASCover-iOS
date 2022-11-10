//
//  DetailViewController.swift
//  MasCover-iOS
//
//  Created by taha_jadid on 23/10/2022.
//

import UIKit
import FirebaseCore
import FirebaseStorage

class DetailViewController: UIViewController {

    @IBOutlet weak var wallpaperImage: UIImageView!
    @IBOutlet weak var bottomRight: UIView!
    @IBOutlet weak var bottomLeft: UIView!
    @IBOutlet weak var download: UIView!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var dislikeImage: UIImageView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var savedImageView: UIView!
    
    private var isLiked = false
    private var isDisliked = false

    var pathWallpaper : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: true)

        initCorners()
        initView()
        
        setImage(pathWallpaper)
        
    }

    func initView(){
        
        savedImageView.isHidden = true

        
        let gestureDownload = UITapGestureRecognizer(target: self, action:  #selector (self.downloadAction (_:)))
        self.download.addGestureRecognizer(gestureDownload)
        
        let gestureBack = UITapGestureRecognizer(target: self, action:  #selector (self.backAction (_:)))
        self.backView.addGestureRecognizer(gestureBack)
        
        // Add listener to setting
        let gestureSetting = UITapGestureRecognizer(target: self, action:  #selector (self.settingAction (_:)))
        self.bottomRight.addGestureRecognizer(gestureSetting)
        
        
        /*
        let gestureSetWallpaper = UITapGestureRecognizer(target: self, action:  #selector (self.wallpaperdAction (_:)))
        self.download.addGestureRecognizer(gestureSetWallpaper)
        */

        let gestureSetLike = UITapGestureRecognizer(target: self, action:  #selector (self.likeAction (_:)))
        self.bottomLeft.addGestureRecognizer(gestureSetLike)
        
        let gestureSetDislike = UITapGestureRecognizer(target: self, action:  #selector (self.dislikeAction (_:)))
        self.bottomRight.addGestureRecognizer(gestureSetDislike)
         
         

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
        UIImageWriteToSavedPhotosAlbum(self.wallpaperImage.image!,
                                       self,
                                       #selector(self.savedImage),
                                       nil)

    }
    
    @objc func savedImage(_ im:UIImage, error:Error?, context:UnsafeMutableRawPointer?) {
        if let err = error {
            print(err)
            return
        }
        print("success")
        showSnackBar()
    }
    
    func showSnackBar(){
        
        self.savedImageView.clipsToBounds = true
        self.savedImageView.layer.cornerRadius = 8


        savedImageView.isHidden = false
        
        let oldCenterFirst = savedImageView.center
        let newCenterFirst = CGPoint(x: oldCenterFirst.x, y: oldCenterFirst.y - 30)

        UIView.animate(withDuration: 0.8, delay: 0, options: .curveLinear, animations: {
            self.savedImageView.center = newCenterFirst
        }) { (success: Bool) in
          print("Done top image")
          }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
            self.savedImageView.isHidden = true
        }
    }
    
    @objc func backAction(_ sender:UITapGestureRecognizer){

        navigationController?.popViewController(animated: true)

    }
    
    
    @objc func settingAction(_ sender:UITapGestureRecognizer){
        // do other task
        let settingViewController = SettingViewController()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if let navigationController = self.navigationController {
              navigationController.pushViewController(settingViewController, animated: false)
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
        likeImage.image = UIImage(named: "like_fill")
    }
    
    @objc func dislikeAction(_ sender:UITapGestureRecognizer){
        // do other task
        dislikeImage.image = UIImage(named: "dislike_fill")
    }
     
    func setImage(_ pathWallpapaer: String){
        
        let store = Storage.storage()
        let storeRef = store.reference()
        
        // Reference to an image file in Cloud Storage
        let reference: StorageReference = storeRef.child(pathWallpapaer)

        
        reference.getData(maxSize: (1 * 1024 * 1024)) { (data, error) in
            if let err = error {
                   print(err)
              } else {
                if let image  = data {
                    let myImage: UIImage! = UIImage(data: image)
                    self.wallpaperImage.image = myImage
                }
             }
        }
        
    }
}
