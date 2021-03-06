//
//  PlantsCollectionViewCell.swift
//  FIT5120_MyAllerGone
//
//  Created by Qfh on 11/4/21.
//

import UIKit

class PlantsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var plantBackground: UIView!
    @IBOutlet weak var cell1Name: UILabel!
    @IBOutlet weak var cell1Value: UILabel!
    @IBOutlet weak var cell1Desc: UILabel!
    @IBOutlet weak var cellIcon: UIImageView!
    @IBOutlet weak var cellDescColor: UIView!
    @IBOutlet weak var cellValueColor: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        plantBackground.layer.cornerRadius = 8.0
//        plantBackground.layer.shadowOpacity = 0.2
//        plantBackground.layer.shadowRadius = 4
//        plantBackground.layer.shadowOffset = CGSize(width: 0, height: 0)
//        plantBackground.layer.masksToBounds = false
    }
}
