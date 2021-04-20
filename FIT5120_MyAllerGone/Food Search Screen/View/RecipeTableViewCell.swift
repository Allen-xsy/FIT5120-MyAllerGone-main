//
//  RecipeTableViewCell.swift
//  FIT5120_MyAllerGone
//
//  Created by 夏舒衍 on 19/4/21.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        recipeImage.image = nil
        recipeName.text = nil
    }
    
    public func configCell(searchResult: FoodRecipe) {
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
