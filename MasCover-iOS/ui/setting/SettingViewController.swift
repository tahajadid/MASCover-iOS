//
//  SettingViewController.swift
//  MasCover-iOS
//
//  Created by taha_jadid on 29/10/2022.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var rightBottom: UIView!
    @IBOutlet weak var leftBottom: UIView!
    @IBOutlet weak var centerBottom: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var telegramView: UIView!
    @IBOutlet weak var switchFr: UISwitch!
    @IBOutlet weak var switchAr: UISwitch!

    @IBOutlet weak var linkCopiedView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: true)

        initViews()
    }

    func initViews(){
        
        linkCopiedView.isHidden = true

        drawCircles()
        drawTopAndBottom()
        
        switchFr.addTarget(self, action: #selector(stateChangedFr), for: .valueChanged)
        switchAr.addTarget(self, action: #selector(stateChangedAr), for: .valueChanged)

        // Add listener to setting
        let gestureHome = UITapGestureRecognizer(target: self, action:  #selector (self.homeAction (_:)))
        self.centerBottom.addGestureRecognizer(gestureHome)
        
        // Add listener to favorite
        let gestureFavorite = UITapGestureRecognizer(target: self, action:  #selector (self.favoriteAction (_:)))
        self.leftBottom.addGestureRecognizer(gestureFavorite)
        
        // Add listener to favorite
        let gestureTelegram = UITapGestureRecognizer(target: self, action:  #selector (self.telegramAction (_:)))
        self.telegramView.addGestureRecognizer(gestureTelegram)
        
    }
    
    @objc func telegramAction(_ sender:UITapGestureRecognizer){
        UIPasteboard.general.string = "https://t.me/+73-Wy4Q1l7E2ZTg8"
        showSnackBar()
    }
    
    @objc func favoriteAction(_ sender:UITapGestureRecognizer){
        // do other task
        let favoriteViewController = FavoriteViewController()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if let navigationController = self.navigationController {
              navigationController.pushViewController(favoriteViewController, animated: false)
            }
        }
    }
    
    @objc func homeAction(_ sender:UITapGestureRecognizer){
        // do other task
        let homeViewController = HomeViewController()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if let navigationController = self.navigationController {
              navigationController.pushViewController(homeViewController, animated: false)
            }
        }
    }
    
    
    @objc func stateChangedFr(switchState: UISwitch) {
       if switchFr.isOn {
           switchAr.setOn(false, animated: true)
       } else {
           // Chnage State of Ar Switch
           switchAr.setOn(true, animated: true)
       }
    }
    
    @objc func stateChangedAr(switchState: UISwitch) {
       if switchAr.isOn {
           switchFr.setOn(false, animated: true)
       } else {
           // Chnage State of Ar Switch
           switchFr.setOn(true, animated: true)
       }
    }
    
    func showSnackBar(){
        
        self.linkCopiedView.clipsToBounds = true
        self.linkCopiedView.layer.cornerRadius = 8


        linkCopiedView.isHidden = false
        
        let oldCenterFirst = linkCopiedView.center
        let newCenterFirst = CGPoint(x: oldCenterFirst.x, y: oldCenterFirst.y - 30)

        UIView.animate(withDuration: 0.8, delay: 0, options: .curveLinear, animations: {
            self.linkCopiedView.center = newCenterFirst
        }) { (success: Bool) in
          print("Done top image")
          }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
            self.linkCopiedView.isHidden = true
        }
    }

    func drawCircles(){
        self.centerBottom.layer.borderWidth = 3
        self.centerBottom.layer.borderColor = UIColor.white.cgColor
        self.centerBottom.layer.cornerRadius = self.centerBottom.frame.width / 2
        
        self.rightBottom.layer.borderWidth = 3
        self.rightBottom.layer.borderColor = UIColor.white.cgColor
        self.rightBottom.layer.cornerRadius = self.rightBottom.frame.width / 2
        
        self.leftBottom.layer.borderWidth = 3
        self.leftBottom.layer.borderColor = UIColor.white.cgColor
        self.leftBottom.layer.cornerRadius = self.leftBottom.frame.width / 2

    }
    
    func drawTopAndBottom(){
        self.topView.clipsToBounds = true
        self.topView.layer.cornerRadius = 20
        self.topView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        
        self.bottomView.clipsToBounds = true
        self.bottomView.layer.cornerRadius = 20
        self.bottomView.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        
    }
    
}
