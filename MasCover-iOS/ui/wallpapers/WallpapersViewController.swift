//
//  WallpapersViewController.swift
//  MasCover-iOS
//
//  Created by taha_jadid on 22/10/2022.
//

import UIKit

class WallpapersViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var categorieTable: UITableView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var animatedView: UIView!
    @IBOutlet weak var centerBottom: UIView!
    @IBOutlet weak var leftBottom: UIView!
    @IBOutlet weak var rightBottom: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: true)

        drawCircles()
        drawTopAndBottom()
        
        // Do any additional setup after loading the view.
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
