//
//  AQIData.swift
//  FIT5120_MyAllerGone
//
//  Created by Qfh on 30/3/21.
//

import Foundation

//MARK: - Struct's of the JSON file.

struct AQIData: Codable {
    let data: AQIndexData
}

struct AQIndexData: Codable {
    let indexes: Indexes
    let health_recommendations: Health_recommendations
}

struct Indexes: Codable {
    let baqi: Baqi
}

struct Health_recommendations: Codable {
    let general_population: String
}

struct Baqi: Codable {
    let aqi_display: String
    let category: String
}
