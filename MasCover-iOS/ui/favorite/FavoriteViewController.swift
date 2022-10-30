//
//  FavoriteViewController.swift
//  MasCover-iOS
//
//  Created by taha_jadid on 29/10/2022.
//

import UIKit
import Lottie

class FavoriteViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var rightBottom: UIView!
    @IBOutlet weak var leftBottom: UIView!
    @IBOutlet weak var animatedView: UIView!
    @IBOutlet weak var centerBottom: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    private var myAnimationView: AnimationView?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: true)

        initViews()
    }

    func initViews(){
        drawCircles()
        drawTopAndBottom()
        
        myAnimationView = .init(name: "favourite")
        myAnimationView!.frame = animatedView.bounds
        myAnimationView!.contentMode = .scaleAspectFill
        myAnimationView!.loopMode = .loop
        animatedView.addSubview(myAnimationView!)
        myAnimationView!.play()
        
        
        // Add listener to setting
        let gestureHome = UITapGestureRecognizer(target: self, action:  #selector (self.homeAction (_:)))
        self.centerBottom.addGestureRecognizer(gestureHome)
        
        // Add listener to setting
        let gestureSetting = UITapGestureRecognizer(target: self, action:  #selector (self.settingAction (_:)))
        self.rightBottom.addGestureRecognizer(gestureSetting)
        
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
    
    @objc func settingAction(_ sender:UITapGestureRecognizer){
        // do other task
        let settingViewController = SettingViewController()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if let navigationController = self.navigationController {
              navigationController.pushViewController(settingViewController, animated: false)
            }
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
