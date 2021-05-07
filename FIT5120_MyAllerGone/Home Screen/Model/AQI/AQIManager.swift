//
//  AQIManager.swift
//  FIT5120_MyAllerGone
//
//  Created by Qfh on 30/3/21.
//

import Foundation
import CoreLocation

//MARK: - Protocol Weather Manager Delegate

protocol AQIManagerDelegate {
    func updateAQIndex (_ aqiManager: AQIManager, aqi: AQIModel)
}

//MARK: - API for AQI

struct AQIManager {
    
    var delegate: AQIManagerDelegate?
    //  72addadaeb9b4fff9fa60d6320f97c43
    let AQIAPIURL = "https://api.breezometer.com/air-quality/v2/current-conditions?key=c5a7728f2a7342d5b4ccaf2cfe438a2f&features=breezometer_aqi,health_recommendations"
    
    func fecthAQILocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(AQIAPIURL)&lat=\(latitude)&lon=\(longitude)"
        fetchAQIData(with: urlString)
    }
    
    //MARK: - Web Request
    
    func fetchAQIData(with urlString: String ) {
        if let url = URL(string: urlString) {
            //print(url)
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if error != nil {
                    print("web error")
                    return
                }
                
                if let safeData = data {
                    if let finalDataAQI = self.parseJson(safeData) {
                        self.delegate?.updateAQIndex(self, aqi: finalDataAQI)
                    }
                }
            }
            task.resume()
        }
    }

    //MARK: - Parse JSON file and save data.
    
    func parseJson(_ aqiData: Data) -> AQIModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(AQIData.self, from: aqiData)
            let AQIndex = decodedData.data.indexes.baqi.aqi_display
            let AQICategory = decodedData.data.indexes.baqi.category
            let AQIRecommendation = decodedData.data.health_recommendations.general_population
            let aqi = AQIModel(AQIndex: AQIndex, AQICategory: AQICategory, AQIRecommendation: AQIRecommendation)
            return aqi
            
        } catch {
            print(error)
            return nil
        }
    }
}
