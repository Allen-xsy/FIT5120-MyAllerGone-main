//
//  RecipeTableViewCell.swift
//  FIT5120_MyAllerGone
//
//  Created by 夏舒衍 on 19/4/21.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeName: UILabel!
    
    public var recipe: FoodRecipe? = nil
    
    public func configCell(recipe: FoodRecipe) {
        self.recipe = recipe
        recipeName.text = recipe.label
        
        if let reference = recipe.image {
            recipeImage.networkImage(urlString: reference, placeholderImage: nil) {[weak self] (success, image) in
                if success {
                    if reference == self?.recipe?.image {
                        self?.recipeImage.image = image
                    }
                }
            }
        } else {
            recipeImage.image = nil
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        recipeImage.image = nil
        recipeName.text = nil
        
        whiteView.layer.cornerRadius = 5.0
        recipeImage.layer.cornerRadius = 5.0
        recipeImage.layer.masksToBounds = true
        
        whiteView.layer.shadowOpacity = 0.3
        whiteView.layer.shadowRadius = 5
        whiteView.layer.shadowOffset = CGSize(width: 3, height: 3)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
