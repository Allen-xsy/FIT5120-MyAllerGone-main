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

//MARK: - API for AQI

struct PollenManager {
    
    var delegate: pollenManagerDelegate?
    //  907cced4507a4b3cbad3be0043786cd2
    let APIURL = "https://api.breezometer.com/pollen/v2/forecast/daily?days=3&key=907cced4507a4b3cbad3be0043786cd2&features=types_information"
    
    func fecthPollenLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(APIURL)&lat=\(latitude)&lon=\(longitude)"
        fetchPollenData(with: urlString)
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
}
