//
//  infoCollectionViewCell.swift
//  FIT5120_MyAllerGone
//
//  Created by Qfh on 20/4/21.
//

import UIKit

class infoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var infoImage: UIImageView!
    @IBOutlet weak var infoTitleLabel: UILabel!
    @IBAction func learnMoreButton(_ sender: Any) {
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //self.backgroundColor = UIColor(red: 242, green: 242, blue: 242, alpha: 0.9)
        // Initialization code
        //plantBackground.layer.cornerRadius = 8.0
//        plantBackground.layer.shadowOpacity = 0.2
//        plantBackground.layer.shadowRadius = 4
//        plantBackground.layer.shadowOffset = CGSize(width: 0, height: 0)
//        plantBackground.layer.masksToBounds = false
        infoImage.layer.cornerRadius = 10.0
        infoImage.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        infoImage.layer.masksToBounds = true
    }
}
