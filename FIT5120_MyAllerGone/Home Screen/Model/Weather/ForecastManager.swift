//
//  ForecastManager.swift
//  FIT5120_MyAllerGone
//
//  Created by Qfh on 29/3/21.
//

import Foundation
import CoreLocation

//MARK: - Protocol Weather Manager Delegate

protocol ForecastManagerDelegate {
    func updateForecast (_ weatherManager: ForecastManager, weather: ForecastModel)
}

//MARK: - API Weather Link

struct ForecastManager {
    
    var delegate: ForecastManagerDelegate?
    
    let forecastAPIURL = "http://api.openweathermap.org/data/2.5/onecall?exclude=current,minutely,hourly&appid=a3b1a4e8077be901d7ef2885a97a6e78&units=metric"
    
    func fecthForecastLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(forecastAPIURL)&lat=\(latitude)&lon=\(longitude)"
        //print(urlString)
        fetchForecastData(with: urlString)
    }
    
    //MARK: - Web Request
    
    func fetchForecastData(with urlString: String ) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if error != nil {
                    print("forecast web request error")
                    //self.delegate?.failError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if  let finalDataForecast =  self.parseJson(safeData) {
                        self.delegate?.updateForecast(self, weather: finalDataForecast)
                    }
                }
            }
            task.resume()
            
        }
    }

    //MARK: - Parse JSON file and save forecast data.
    
    func parseJson(_ forecastData: Data) -> ForecastModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(ForecastData.self, from: forecastData)
            // data for the first day
            let minTempFirst = decodedData.daily[1].temp.min
            let maxTempFirst = decodedData.daily[1].temp.max
            let descriptionFirst = decodedData.daily[1].weather[0].description
            let idFirst = decodedData.daily[1].weather[0].id
            // data for the second day
            let minTempSecond = decodedData.daily[2].temp.min
            let maxTempSecond = decodedData.daily[2].temp.max
            let descriptionSecond = decodedData.daily[2].weather[0].description
            let idSecond = decodedData.daily[2].weather[0].id
            // data for the third day
            let minTempThird = decodedData.daily[3].temp.min
            let maxTempThird = decodedData.daily[3].temp.max
            let descriptionThird = decodedData.daily[3].weather[0].description
            let idThird = decodedData.daily[3].weather[0].id
            
            let forecast =
                ForecastModel(id: idFirst, description: descriptionFirst, min: minTempFirst, max: maxTempFirst,id2: idSecond, description2: descriptionSecond, min2: minTempSecond, max2: maxTempSecond, id3: idThird, description3: descriptionThird, min3: minTempThird, max3: maxTempThird)
            
            return forecast
            
        } catch {
            print(error)
            //delegate?.failError(error: error)
            return nil
        }
    }
}
