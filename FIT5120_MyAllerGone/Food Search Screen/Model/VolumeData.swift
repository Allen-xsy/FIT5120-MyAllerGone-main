//
//  VolumeData.swift
//  FIT5120_MyAllerGone
//
//  Created by 夏舒衍 on 17/4/21.
//

import Foundation

class VolumeData: NSObject, Decodable {
 var hits: [FoodRecipe]?

 private enum CodingKeys: String, CodingKey {
    case hits
 }
}
