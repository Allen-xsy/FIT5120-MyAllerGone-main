//
//  PollenCollectionViewCell.swift
//  FIT5120_MyAllerGone
//
//  Created by Qfh on 30/3/21.
//

import UIKit

class PollenCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var treeBackgroundView: UIView!
    @IBOutlet weak var weedBackgroundView: UIView!
    @IBOutlet weak var treePollenIndexLabel: UILabel!
    @IBOutlet weak var WeedPollenIndexLabel: UILabel!
    @IBOutlet weak var treeDescLabel: UILabel!
    @IBOutlet weak var weedDescLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        treeBackgroundView.layer.cornerRadius = 3.0
        treeBackgroundView.layer.shadowOpacity = 0.2
        treeBackgroundView.layer.shadowRadius = 4
        treeBackgroundView.layer.shadowOffset = CGSize(width: 0, height: 0)
        treeBackgroundView.layer.masksToBounds = false
        
        weedBackgroundView.layer.cornerRadius = 3.0
        weedBackgroundView.layer.shadowOpacity = 0.2
        weedBackgroundView.layer.shadowRadius = 4
        weedBackgroundView.layer.shadowOffset = CGSize(width: 0, height: 0)
        weedBackgroundView.layer.masksToBounds = false
    }
}
