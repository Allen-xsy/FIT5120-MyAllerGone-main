//
//  FoodRecipe.swift
//  FIT5120_MyAllerGone
//
//  Created by 夏舒衍 on 17/4/21.
//

import Foundation

class FoodRecipe: NSObject, Decodable {
    var recipe:String?
    var label:String?
    var image:String?
    var ingredientLines:[String]?
    
    private enum RootKeys: String, CodingKey {
        case recipe
    }
    
    private struct Recipes:Decodable{
        var label:String?
        var image:String?
        var ingredientLines:[String]?
    }
    
    required init(from decoder: Decoder) throws {
        let recipeContainer = try decoder.container(keyedBy: RootKeys.self)
        
        let recipes = try? recipeContainer.decode(Recipes.self, forKey: .recipe)
        label = recipes?.label
        image = recipes?.image
        ingredientLines = recipes?.ingredientLines
    }
}
