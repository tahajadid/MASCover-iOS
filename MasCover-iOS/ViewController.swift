//
//  ViewController.swift
//  MasCover-iOS
//
//  Created by taha_jadid on 12/10/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mascoverUI: UIImageView!
    
    @IBOutlet weak var phoneUi: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        //self.mascoverUI.fadeIn()
        //self.phoneUi.fadeIn()

        let oldCenterFirst = mascoverUI.center
        let newCenterFirst = CGPoint(x: oldCenterFirst.x, y: oldCenterFirst.y + 40)

        UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
            self.mascoverUI.center = newCenterFirst
        }) { (success: Bool) in
          print("Done moving image")
          }
        
        
        let oldCenterSecond = phoneUi.center
        let newCenterSecond = CGPoint(x: oldCenterSecond.x, y: oldCenterSecond.y - 180)

        UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
            self.phoneUi.center = newCenterSecond
        }) { (success: Bool) in
          print("Done moving image")
          }
        
    }


}

