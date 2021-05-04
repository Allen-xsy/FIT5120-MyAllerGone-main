//
//  FoodDetailTableViewCell.swift
//  FIT5120_MyAllerGone
//
//  Created by 夏舒衍 on 2021/5/2.
//

import UIKit

class FoodDetailTableViewCell: UITableViewCell {

    
    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    
    public var recipe: FoodRecipe? = nil {
        didSet {
            nameLabel.text = recipe?.label
            if let reference = recipe?.image {
                logoImageView.networkImage(urlString: reference, placeholderImage: nil) {[weak self] (success, image) in
                    if success {
                        if reference == self?.recipe?.image {
                            self?.logoImageView.image = image
                        }
                    }
                }
            } else {
                logoImageView.image = nil
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        whiteView.layer.cornerRadius = 5.0
        logoImageView.layer.cornerRadius = 5.0
        logoImageView.layer.masksToBounds = true
        
        whiteView.layer.shadowOpacity = 0.3
        whiteView.layer.shadowRadius = 5
        whiteView.layer.shadowOffset = CGSize(width: 3, height: 3)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
