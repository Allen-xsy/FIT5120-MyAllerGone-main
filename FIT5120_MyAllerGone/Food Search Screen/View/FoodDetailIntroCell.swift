//
//  FoodDetailIntroCell.swift
//  FIT5120_MyAllerGone
//
//  Created by 夏舒衍 on 2021/5/2.
//

import UIKit

class FoodDetailIntroCell: UITableViewCell {
    @IBOutlet weak var whiteView: UIView!
    
    @IBOutlet weak var detailButton: UIButton!
    @IBOutlet weak var introLabel: UILabel!
    
    public var didClickedDetailButtonHandler:(() -> Void)? = nil
    
    public var recipe: FoodRecipe? = nil {
        didSet {
            var text = ""

            for element in recipe?.ingredientLines ?? []{
                text += "\u{2022} " + element + "\n"

            }
            introLabel.text = text
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        whiteView.layer.cornerRadius = 5.0
        whiteView.layer.shadowOpacity = 0.3
        whiteView.layer.shadowRadius = 5
        whiteView.layer.shadowOffset = CGSize(width: 3, height: 3)
        
        detailButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        detailButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        detailButton.layer.shadowOpacity = 1.0
        detailButton.layer.shadowRadius = 0.0
        detailButton.layer.masksToBounds = false
        detailButton.layer.cornerRadius = 4.0
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func detailAction(_ sender: UIButton) {
        didClickedDetailButtonHandler?()
    }
    
}
