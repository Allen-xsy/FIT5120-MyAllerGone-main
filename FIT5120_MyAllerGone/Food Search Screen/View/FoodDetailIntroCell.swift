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
            var index = 1
            for element in recipe?.ingredientLines ?? []{
                text += "\(index). " + element + "\n"
                index += 1
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
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func detailAction(_ sender: UIButton) {
        didClickedDetailButtonHandler?()
    }
    
}
