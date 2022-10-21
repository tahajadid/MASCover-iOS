//
//  CategorieCell.swift
//  MasCover-iOS
//
//  Created by taha_jadid on 21/10/2022.
//

import UIKit

class CategorieCell: UITableViewCell {

    static let nibname = "CategorieCell"

    @IBOutlet weak var categoriImage: UIImageView!
    
    @IBOutlet weak var categorieTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /*
        get Nib of Cell
     */
    static func nib() -> UINib {
        return UINib(nibName: self.nibname, bundle: nil)
    }
}
