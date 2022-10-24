//
//  CustomWallpaperCell.swift
//  MasCover-iOS
//
//  Created by taha_jadid on 23/10/2022.
//

import UIKit
import FirebaseCore
import FirebaseStorage

class CustomWallpaperCell: UICollectionViewCell {

    @IBOutlet weak var wallpaperImage: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.wallpaperImage.layer.cornerRadius = 10

        spinner.layer.cornerRadius = 8
        spinner.startAnimating()

        wallpaperImage.startAnimating()
        
    }
    
    func setImage(_ pathWallpapaer: String){
        
        let store = Storage.storage()
        let storeRef = store.reference()
        
        // Reference to an image file in Cloud Storage
        let reference: StorageReference = storeRef.child(pathWallpapaer)

        
        reference.getData(maxSize: (1 * 1024 * 1024)) { (data, error) in
            self.spinner.stopAnimating()
            self.spinner.isHidden = true
            if let err = error {
                   print(err)
              } else {
                if let image  = data {
                     let myImage: UIImage! = UIImage(data: image)
                    self.wallpaperImage.image = myImage
                     // Use Image
                }
             }
        }
        
    }
    
    func startAnimating() {
        var gradientColorOne : CGColor = UIColor(white: 0.85, alpha: 1.0).cgColor
        var gradientColorTwo : CGColor = UIColor(white: 0.95, alpha: 1.0).cgColor
        let gradientLayer = CAGradientLayer()
        /* Allocate the frame of the gradient layer as the view's bounds, since the layer will sit on top of the view. */
          
          gradientLayer.frame = self.bounds
        /* To make the gradient appear moving from left to right, we are providing it the appropriate start and end points.
        Refer to the diagram above to understand why we chose the following points.
        */
          gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
          gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
          gradientLayer.colors = [gradientColorOne, gradientColorTwo,   gradientColorOne]
          gradientLayer.locations = [0.0, 0.5, 1.0]
        /* Adding the gradient layer on to the view */
          self.layer.addSublayer(gradientLayer)
    }

}
