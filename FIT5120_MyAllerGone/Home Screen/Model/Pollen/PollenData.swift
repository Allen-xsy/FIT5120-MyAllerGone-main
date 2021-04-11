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
    let plants: Plant?
}

struct Type: Codable {
    let tree: Tree?
    let weed: Weed?
}

struct Plant: Codable {
    let graminales: Graminale?
    let hazel: Hazel?
    let oak: Oak?
    let pine: Pine?
    let birch: Birch?
    let ash: Ash?
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

struct Graminale: Codable {
    let index: GraminaleIndex
}

struct GraminaleIndex: Codable {
    let value: Int?
    let category: String?
}

struct Hazel: Codable {
    let index: HazelIndex
}

struct HazelIndex: Codable {
    let value: Int?
    let category: String?
}

struct Oak: Codable {
    let index: OakIndex
}

struct OakIndex: Codable {
    let value: Int?
    let category: String?
}

struct Pine: Codable {
    let index: PineIndex
}

struct PineIndex: Codable {
    let value: Int?
    let category: String?
}

struct Birch: Codable {
    let index: BirchIndex
}

struct BirchIndex: Codable {
    let value: Int?
    let category: String?
}

struct Ash: Codable {
    let index: AshIndex
}

struct AshIndex: Codable {
    let value: Int?
    let category: String?
}

