//
//  PollenModel.swift
//  FIT5120_MyAllerGone
//
//  Created by Qfh on 1/4/21.
//

import Foundation

//MARK: - Variables for send to UI
struct PollenModel {
    
    let pollenTreeValue: Int?
    let pollenTreeCategory: String?
    let pollenTreeColor: String?
    let pollenWeedValue: Int?
    let pollenWeedCategory: String?
    let pollenWeedColor: String?
}

struct PollenPlantsModel {
    
    let plantsData: [PoData]?
    let graminaleValue: Int?
    let graminaleCategory: String?
    let hazelValue: Int?
    let hazelCategory: String?
    let oakValue: Int?
    let oakCategory: String?
    let pineValue: Int?
    let pineCategory: String?
    let birchValue: Int?
    let birchCategory: String?
    let ashValue: Int?
    let ashCategory: String?
}
