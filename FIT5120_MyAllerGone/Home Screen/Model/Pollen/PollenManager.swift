//
//  PollenManager.swift
//  FIT5120_MyAllerGone
//
//  Created by Qfh on 1/4/21.
//

import Foundation
import CoreLocation

//MARK: - Protocol Weather Manager Delegate

protocol pollenManagerDelegate {
    func updatePollenIndex (_ pollenManager: PollenManager, pollen: PollenModel)
}
protocol pollenPlantsManagerDelegate {
    func updatePollenPlants (_ pollenManager: PollenManager, pollen: PollenPlantsModel)
}

//MARK: - API for AQI

struct PollenManager {
    
    var delegate: pollenManagerDelegate?
    var plantsDelegate: pollenPlantsManagerDelegate?
    //  907cced4507a4b3cbad3be0043786cd2
    // https://api.breezometer.com/pollen/v2/forecast/daily?lat=48.857456&lon=2.354611&days=3&key=YOUR_API_KEY&features=types_information,plants_information
    let APIURL = "https://api.breezometer.com/pollen/v2/forecast/daily?days=3&key=c5a7728f2a7342d5b4ccaf2cfe438a2f&features=types_information"
    
    func fecthPollenLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(APIURL)&lat=\(latitude)&lon=\(longitude)"
        fetchPollenData(with: urlString)
    }
    func fetchPlantPollenLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(APIURL),plants_information&lat=\(latitude)&lon=\(longitude)"
        fetchPlantsPollenData(with: urlString)
    }
    
    //MARK: - Web Request
    
    func fetchPollenData(with urlString: String ) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if error != nil {
                    print("web error")
                    return
                }
                
                if let safeData = data {
                    if let finalPollenData = self.parseJson(safeData) {
                        self.delegate?.updatePollenIndex(self, pollen: finalPollenData)
                    }
                }
            }
            task.resume()
        }
    }
    
    func fetchPlantsPollenData(with urlString: String ) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if error != nil {
                    print("plant web error")
                    return
                }
                
                if let safeData = data {
                    if let finalPollenData = self.parsePlantsJson(safeData) {
                        self.plantsDelegate?.updatePollenPlants(self, pollen: finalPollenData)
                        print("update Pollen Plants")
                    }
                }
            }
            task.resume()
        }
    }

    //MARK: - Parse JSON file and save data.
    
    func parseJson(_ pollenData: Data) -> PollenModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(PollenData.self, from: pollenData)
            let treeValue = decodedData.data?[0].types.tree?.index.value
            let treeCategory = decodedData.data?[0].types.tree?.index.category
            let treeColor = decodedData.data?[0].types.tree?.index.color
            let weedValue = decodedData.data?[1].types.weed?.index.value
            let weedCategory = decodedData.data?[1].types.weed?.index.category
            let weedColor = decodedData.data?[1].types.weed?.index.color
            let pollen = PollenModel(pollenTreeValue: treeValue, pollenTreeCategory: treeCategory, pollenTreeColor: treeColor, pollenWeedValue: weedValue, pollenWeedCategory: weedCategory, pollenWeedColor: weedColor)
            
            return pollen
        } catch {
            print(error)
            return nil
        }
    }
    
    func parsePlantsJson(_ pollenData: Data) -> PollenPlantsModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(PollenData.self, from: pollenData)
            let graminaleValue = decodedData.data?[0].plants?.graminales?.index.value
            let graminaleCategory = decodedData.data?[0].plants?.graminales?.index.category
            let hazelValue = decodedData.data?[0].plants?.hazel?.index.value
            let hazelCategory = decodedData.data?[0].plants?.hazel?.index.category
            let oakValue = decodedData.data?[0].plants?.oak?.index.value
            let oakCategory = decodedData.data?[0].plants?.oak?.index.category
            let pineValue = decodedData.data?[0].plants?.pine?.index.value
            let pineCategory = decodedData.data?[0].plants?.pine?.index.category
            let birchValue = decodedData.data?[0].plants?.birch?.index.value
            let birchCategory = decodedData.data?[0].plants?.birch?.index.category
            let ashValue = decodedData.data?[0].plants?.ash?.index.value
            let ashCategory = decodedData.data?[0].plants?.ash?.index.category
            let plantsData = decodedData.data
            
            let plantPollen = PollenPlantsModel(plantsData: plantsData, graminaleValue: graminaleValue, graminaleCategory: graminaleCategory, hazelValue: hazelValue, hazelCategory: hazelCategory, oakValue: oakValue, oakCategory: oakCategory, pineValue: pineValue, pineCategory: pineCategory, birchValue: birchValue, birchCategory: birchCategory, ashValue: ashValue, ashCategory: ashCategory)
            
            return plantPollen
        } catch {
            print(error)
            return nil
        }
    }
}
