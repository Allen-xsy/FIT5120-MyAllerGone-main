//
//  PollenModel.swift
//  FIT5120_MyAllerGone
//
//  Created by Qfh on 1/4/21.
//

import Foundation

//MARK: - Variables for send to UI
struct PollenModel {
    
    let pollenTreeValue: Int
    let pollenTreeCategory: String
    let pollenTreeColor: String
    let pollenWeedValue: Int
    let pollenWeedCategory: String
    let pollenWeedColor: String

    //MARK: - Parse Int into String

    var treeValueString: String {
        return String(format: "%.0f", pollenTreeValue)
    }
    
    var weedValueString: String {
        return String(format: "%.0f", pollenWeedValue)
    }
}
