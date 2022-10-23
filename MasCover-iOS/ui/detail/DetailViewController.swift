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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        
    }

    func initView(){
        
        self.bottomRight.clipsToBounds = true
        self.bottomRight.layer.cornerRadius = 20
        self.bottomRight.layer.maskedCorners = [.layerMaxXMaxYCorner]
        
        self.bottomLeft.clipsToBounds = true
        self.bottomLeft.layer.cornerRadius = 20
        self.bottomLeft.layer.maskedCorners = [.layerMinXMinYCorner]
        
    
        self.download.layer.cornerRadius = self.download.frame.width / 2
    }


}
