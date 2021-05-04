//
//  FoodSearchImageCell.swift
//  FIT5120_MyAllerGone
//
//  Created by 夏舒衍 on 2021/5/1.
//

import UIKit

class FoodSearchImageCell: UICollectionViewCell {
    
    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var whiteView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        whiteView.layer.cornerRadius = 5.0
        logoImageView.layer.cornerRadius = 5.0
        logoImageView.layer.masksToBounds = true
        logoImageView.image = UIImage(named: "foodSearch")
        
        whiteView.layer.shadowOpacity = 0.3
        whiteView.layer.shadowRadius = 5
        whiteView.layer.shadowOffset = CGSize(width: 3, height: 3)
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        layoutAttributes.frame.size.height = (layoutAttributes.size.width - 32) * 9.0 / 16.0 + 16
        return layoutAttributes
    }
}
