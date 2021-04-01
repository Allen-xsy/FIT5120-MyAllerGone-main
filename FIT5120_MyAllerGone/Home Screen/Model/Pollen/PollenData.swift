//
//  WeatherData.swift
//  FIT5120_MyAllerGone
//
//  Created by Qfh on 27/3/21.
//

import Foundation

//MARK: - Struct's of the JSON file.

struct PollenData: Codable {
    let data: [PoData]?
}

struct PoData: Codable {
    let types: Type
}

struct Type: Codable {
    let tree: Tree?
    let weed: Weed?
}

struct Tree: Codable {
    let index: TreeIndex
}

struct Weed: Codable {
    let index: WeedIndex
}

struct TreeIndex: Codable {
    let value: Int?
    let color: String?
    let category: String?
}

struct WeedIndex: Codable {
    let value: Int?
    let color: String?
    let category: String?
}

