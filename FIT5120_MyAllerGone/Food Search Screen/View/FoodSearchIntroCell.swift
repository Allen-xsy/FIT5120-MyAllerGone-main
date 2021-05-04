//
//  FoodSearchIntroCell.swift
//  FIT5120_MyAllerGone
//
//  Created by 夏舒衍 on 2021/5/1.
//

import UIKit

class FoodSearchIntroCell: UICollectionViewCell {

    
    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var introLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        whiteView.layer.cornerRadius = 5.0
        whiteView.layer.shadowOpacity = 0.3
        whiteView.layer.shadowRadius = 5
        whiteView.layer.shadowOffset = CGSize(width: 3, height: 3)
    }

    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        
        let height = introLabel.sizeThatFits(CGSize(width: UIScreen.main.bounds.width - 48, height: CGFloat.greatestFiniteMagnitude)).height + 32
        
        layoutAttributes.frame.size.height = height
        return layoutAttributes
    }
}
