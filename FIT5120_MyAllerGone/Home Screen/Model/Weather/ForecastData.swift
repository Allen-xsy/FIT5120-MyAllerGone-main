//
//  ForecastWeatherData.swift
//  FIT5120_MyAllerGone
//
//  Created by Qfh on 28/3/21.
//

import Foundation

//MARK: - Struct's of the JSON file.

struct ForecastData: Codable {
    let daily: [Daily]
}

struct Daily: Codable {
    let temp: Temp
    let weather: [ForcastWeather]
}

struct Temp: Codable {
    let min: Float
    let max: Float
}

struct ForcastWeather: Codable {
    let id: Int
    let description: String
}
