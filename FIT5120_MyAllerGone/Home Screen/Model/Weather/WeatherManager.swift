//
//  WeatherModel.swift
//  FIT5120_MyAllerGone
//
//  Created by Qfh on 27/3/21.
//

import Foundation
import CoreLocation

//MARK: - Protocol Weather Manager Delegate

protocol WeatherManagerDelegate {
    func updateWeather (_ weatherManager: WeatherManager, weather: WeatherModel)
    func failError(error: Error)
}

//MARK: - API Weather Link

struct WeatherManager {
    
    var delegate: WeatherManagerDelegate?
    
    let weatherAPIURL = "https://api.openweathermap.org/data/2.5/weather?appid=a3b1a4e8077be901d7ef2885a97a6e78&units=metric"
    
    func fecthWeatherLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherAPIURL)&lat=\(latitude)&lon=\(longitude)"
        fetchWeatherData(with: urlString)
    }
    
    //MARK: - Web Request
    
    func fetchWeatherData(with urlString: String ) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if error != nil {
                    self.delegate?.failError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if  let finalDataWeather =  self.parseJson(safeData) {
                        self.delegate?.updateWeather(self, weather: finalDataWeather)
                    }
                }
            }
            task.resume()
            
        }
    }

    //MARK: - Parse JSON file and save data.
    
    func parseJson(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        
        do {
//            let decodedData = try decoder.decode(VolumeData.self, from: weatherData)
//            let temp = decodedData.data.temperature.value
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let maxTemp = decodedData.main.temp_max
            let minTemp = decodedData.main.temp_min
            let humidity = decodedData.main.humidity
            let countryName = decodedData.sys.country
            let cityName = decodedData.name
            let description = decodedData.weather[0].description
            let weather =
                WeatherModel(countryName: countryName, cityName: cityName, description: description, conditionId: id, humidity: humidity, temperature: temp, minTemp: minTemp, maxTemp: maxTemp)
            
            return weather
            
        } catch {
            delegate?.failError(error: error)
            
            return nil
        }
    }
}
