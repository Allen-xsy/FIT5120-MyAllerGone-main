//
//  WeatherModel.swift
//  FIT5120_MyAllerGone
//
//  Created by Qfh on 27/3/21.
//

import Foundation

//MARK: - Variables for send to UI
struct WeatherModel {
    
    let countryName:String
    let cityName: String
    let description: String
    let conditionId: Int
    let humidity: Float
    let temperature: Float
    let minTemp: Float
    let maxTemp: Float

    //MARK: - Parse Int into String
    
    var temperatureString: String {
        return String(format: "%.0f", temperature)
    }
    var minTempString: String {
        return String(format: "%.0f", minTemp)
    }
    var maxTempString: String {
        return String(format: "%.0f", maxTemp)
    }
    var humidityString: String {
        return String(format: "%.0f", humidity)
    }
    
    //MARK: - Set icon weather
    
    
    var conditionName: String{
        switch conditionId {
        case  200...202:
            return "006-storm"
        case  203...232:
            return "007-thunder"
        case  300...321:
            return "004-rainy"
        case  500...504:
            return "003-rain"
        case  511, 612...622:
            return "008-snow"
        case  520...531:
            return "005-heavy rain"
        case  600...611:
            return "009-snow"
        case  701...781:
            return "051-fog"
        case  800:
            return "052-sun"
        case  801:
            return "few_clouds"
        case  802, 803:
            return "clouds"
        case  804:
            return "cloudy"
        default:
            return "thermometer"
        }
    }
}


