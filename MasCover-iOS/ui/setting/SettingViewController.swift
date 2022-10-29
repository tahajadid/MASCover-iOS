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
    
    @IBOutlet weak var switchFr: UISwitch!
    @IBOutlet weak var switchAr: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: true)

        initViews()
    }

    func initViews(){
        drawCircles()
        drawTopAndBottom()
        
        switchFr.addTarget(self, action: #selector(stateChangedFr), for: .valueChanged)
        switchAr.addTarget(self, action: #selector(stateChangedAr), for: .valueChanged)

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
