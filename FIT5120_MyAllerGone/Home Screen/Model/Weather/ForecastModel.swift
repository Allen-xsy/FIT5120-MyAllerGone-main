//
//  ForcastModel.swift
//  FIT5120_MyAllerGone
//
//  Created by Qfh on 29/3/21.
//

import Foundation

//MARK: - Variables for send to UI
struct ForecastModel {
    
    let id: Int
    let description: String
    let min: Float
    let max: Float
    let id2: Int
    let description2: String
    let min2: Float
    let max2: Float
    let id3: Int
    let description3: String
    let min3: Float
    let max3: Float

    //MARK: - Parse Int into String
    
    var minTempString: String {
        return String(format: "%.0f", min)
    }
    var maxTempString: String {
        return String(format: "%.0f", max)
    }
    var minTempString2: String {
        return String(format: "%.0f", min)
    }
    var maxTempString2: String {
        return String(format: "%.0f", max)
    }
    var minTempString3: String {
        return String(format: "%.0f", min)
    }
    var maxTempString3: String {
        return String(format: "%.0f", max)
    }

    //MARK: - Set icon weather
    
    var conditionName: String{
        switch id {
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
    var conditionName2: String{
        switch id2 {
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
    var conditionName3: String{
        switch id3 {
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
