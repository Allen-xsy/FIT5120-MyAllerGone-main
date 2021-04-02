//
//  HomeViewController.swift
//  FIT5120_MyAllerGone
//
//  Created by Qfh on 20/3/21.
//

import UIKit
import MapKit
import KDCircularProgress

class HomeViewController: UIViewController {

    @IBOutlet weak var CityLabel: UILabel!
    @IBOutlet weak var HomeCollectionView: UICollectionView!

    var temp: String = "--"
    var weatherImageName: String?
    var currentDate: String?
    var currentWeekday: String?
    var weatherDesc: String?
    var MinTemp: String?
    var MaxTemp: String?
    
    var forecastImage1: String?
    var forecastDate1: String?
    var forecastDesc1: String?
    var forecastMin1: String?
    var forecastMax1: String?
    
    var forecastImage2: String?
    var forecastDate2: String?
    var forecastDesc2: String?
    var forecastMin2: String?
    var forecastMax2: String?
    
    var forecastImage3: String?
    var forecastDate3: String?
    var forecastDesc3: String?
    var forecastMin3: String?
    var forecastMax3: String?
    
    var aqiString: String?
    var aqiDesc: String?
    var aqiRecommendation: String?
    
    var treePollenIndex: String?
    var treePollenDesc: String?
    var weedPollenIndex: String?
    var weedPollenDesc: String?
    
    var locationManager: CLLocationManager = CLLocationManager()
    var weatherManager = WeatherManager()
    var forecastManager = ForecastManager()
    var aqiManager = AQIManager()
    var pollenManager = PollenManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = floor(screenSize.width * 0.94)
        let layout = HomeCollectionView!.collectionViewLayout as! UICollectionViewFlowLayout
        //let cellSize = layout.collectionViewContentSize
        layout.itemSize = CGSize(width: cellWidth, height: 140)
        
        // locationManager delegate
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        weatherManager.delegate = self
        forecastManager.delegate = self
        aqiManager.delegate = self
        pollenManager.delegate = self

        // Do any additional setup after loading the view.
        navigationController?.tabBarItem.selectedImage = UIImage(named: "cloudy_click")
        
        //To set the default user location for Appetize
        if let isAppetize = UserDefaults.standard.object(forKey: "isAppetize") as? Bool {
            if isAppetize == true {
                weatherManager.fecthWeatherLocation(latitude: 145.132430 , longitude: -37.911706)
                weatherManager.fecthWeatherLocation(latitude: 145.132430, longitude: -37.911706)
                forecastManager.fecthForecastLocation(latitude: 145.132430, longitude: -37.911706)
                aqiManager.fecthAQILocation(latitude: 145.132430, longitude: -37.911706)
                pollenManager.fecthPollenLocation(latitude: 145.132430, longitude: -37.911706)
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkLocation()        
    }
    
    func checkLocation(){
        if CLLocationManager.locationServicesEnabled() {
            let locationManager = CLLocationManager()
            locationManagerDidChangeAuthorization(locationManager)
            
        }else {
            print("CLLocationManager failed !!!")
        }
        
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {

            switch manager.authorizationStatus {
                case .authorizedAlways , .authorizedWhenInUse:
                    locationManager.startUpdatingLocation()
                    break
                case .notDetermined:
                    locationManager.requestWhenInUseAuthorization()
                case .denied :
                    displayMessage(title: "Reopen Authentication", message: "Settings -> Privacy -> Location Services -> Open")
                    break
                case .restricted:
                    displayMessage(title: "Filed", message: "Map Service Restricted")
                    break
                default:
                    break
            }
            
            switch manager.accuracyAuthorization {
                case .fullAccuracy:
                    break
                case .reducedAccuracy:
                    break
                default:
                    break
            }
    }

    //MARK: - Get current date and week
    
    func getCurrentDateString() -> String {
            let now = Date()
            let dformatter = DateFormatter()
            dformatter.dateFormat = "MM/dd"
            return dformatter.string(from: now)
        }
    func getCurrentDate() -> Date {
          let now = Date()
          let dateformatter = DateFormatter()
          dateformatter.dateFormat = "yyyy-MM-dd"
          let dateStr = dateformatter.string(from: now)
          return dateformatter.date(from: dateStr)!
      }
    func getWeedayFromeDate(date: Date, forecastIndex: Int) -> String {
        let calendar = Calendar.current
        let dateComponets = calendar.dateComponents([Calendar.Component.year,Calendar.Component.month,Calendar.Component.weekday,Calendar.Component.day], from: date)
        // get what day is today
        var weekDay = dateComponets.weekday! + forecastIndex
        if weekDay > 7 {
            weekDay = weekDay - 7
        }
        switch weekDay {
        case 1:
            return "Sun"
        case 2:
            return  "Mon"
        case 3:
            return "Tue"
        case 4:
            return "Wed"
        case 5:
            return "Thu"
        case 6:
            return "Fri"
        case 7:
            return "Sat"
        default:
            return ""
        }
    }
    
    func updateWeekAndDate() {
        let date = self.getCurrentDate()
        self.currentDate = self.getCurrentDateString()
        self.currentWeekday = self.getWeedayFromeDate(date: date, forecastIndex: 0)
    }
    
    func updateForecastWeek() {
        let date = self.getCurrentDate()
        self.forecastDate1 = self.getWeedayFromeDate(date: date, forecastIndex: 1)
        self.forecastDate2 = self.getWeedayFromeDate(date: date, forecastIndex: 2)
        self.forecastDate3 = self.getWeedayFromeDate(date: date, forecastIndex: 3)
    }
    
    //MARK: - Customize AQI progress animation
    
    func updateAQIProgress(cell: AQICollectionViewCell, AQI: Double) {
        let view = cell.AQIView
        let progress = KDCircularProgress(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        progress.startAngle = -90
        progress.angle = AQI * 0.72
        progress.progressThickness = 0.2
        progress.trackThickness = 0.6
        progress.clockwise = true
        progress.gradientRotateSpeed = 2
        progress.roundedCorners = true
        progress.glowMode = .noGlow
        progress.progressThickness = 0.42
        progress.trackColor = UIColor(cgColor: #colorLiteral(red: 0.09918874376, green: 0.1465378853, blue: 0.5132053927, alpha: 0.7738655822))
        progress.set(colors: UIColor.cyan ,UIColor.white, UIColor.magenta, UIColor.white, UIColor.orange)
        //(colors: UIColor(cgColor: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)) ,UIColor.white, UIColor(cgColor: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)), UIColor.white, UIColor(cgColor: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)))
        progress.center = CGPoint(x: view!.center.x - 10, y: view!.center.y - 12 )
        view?.addSubview(progress)
    }
    
    // Display message to user
    func displayMessage(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message,preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss",style: UIAlertAction.Style.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK: - Receive the current weather data and send it to the UI

extension HomeViewController: WeatherManagerDelegate {
    
    func updateWeather(_ weatherManager: WeatherManager, weather: WeatherModel){
        
        DispatchQueue.main.async {
            
            self.temp = "\(weather.temperatureString)" 
            //print(self.temp ?? "no temp")
            self.CityLabel.text = weather.cityName
            self.weatherImageName = weather.conditionName
            self.weatherDesc = weather.description
            self.MinTemp = weather.minTempString
            self.MaxTemp = weather.maxTempString
            self.updateWeekAndDate()
            self.HomeCollectionView.reloadData()
        }
    }
    
    func failError(error: Error) {
//        DispatchQueue.main.async {
//            self.alert(title: "Error", message: "Check")
//        }
        
    }
}

//MARK: - Receive the forecast data and send it to the UI

extension HomeViewController: ForecastManagerDelegate {
    
    func updateForecast(_ weatherManager: ForecastManager, weather: ForecastModel){
        
        DispatchQueue.main.async {
            
            self.forecastImage1 = weather.conditionName
            self.forecastDesc1 = weather.description
            self.forecastMin1 = weather.minTempString
            self.forecastMax1 = weather.maxTempString
            
            self.forecastImage2 = weather.conditionName2
            self.forecastDesc2 = weather.description2
            self.forecastMin2 = weather.minTempString2
            self.forecastMax2 = weather.maxTempString2
            
            self.forecastImage3 = weather.conditionName3
            self.forecastDesc3 = weather.description3
            self.forecastMin3 = weather.minTempString3
            self.forecastMax3 = weather.maxTempString3
            
            self.updateForecastWeek()
            
            self.HomeCollectionView.reloadData()
        }
    }
}

//MARK: - Receive the AQI data and send it to the UI

extension HomeViewController: AQIManagerDelegate {

    func updateAQIndex(_ aqiManager: AQIManager, aqi: AQIModel){
        
        DispatchQueue.main.async {
            
            self.aqiString = aqi.AQIndex
            self.aqiDesc = aqi.AQICategory
            self.aqiRecommendation = aqi.AQIRecommendation

            self.HomeCollectionView.reloadData()
        }
    }
}

//MARK: - Receive the Pollen data and send it to the UI

extension HomeViewController: pollenManagerDelegate {

    func updatePollenIndex(_ pollenManager: PollenManager, pollen: PollenModel){
        
        DispatchQueue.main.async {
            
            if let index = pollen.pollenTreeValue {
                self.treePollenIndex = String(index)
            } else {
                self.treePollenIndex = "0"
            }
            self.treePollenDesc = pollen.pollenTreeCategory ?? "NA"

            if let index = pollen.pollenWeedValue {
                self.weedPollenIndex = String(index)
            } else {
                self.weedPollenIndex = "0"
            }
            self.weedPollenDesc = pollen.pollenWeedCategory ?? "NA"
            
            self.HomeCollectionView.reloadData()
        }
    }
}

// MARK: - Collection view data source

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCollectionViewCell", for: indexPath) as! WeatherCollectionViewCell
            
            cell.layer.cornerRadius = 5.0
            cell.layer.shadowOpacity = 0.3
            cell.layer.shadowRadius = 5
            cell.layer.masksToBounds = false

            cell.tempLabel.text = self.temp
            cell.dateLabel.text = self.currentDate
            cell.weedayLabel.text = self.currentWeekday
            cell.weatherDescLabel.text = self.weatherDesc?.capitalized
            cell.MinMaxTempLabel.text = String("\(self.MinTemp ?? "?")~\(self.MaxTemp ?? "?")°C")
            //print(temp!)
            //#imageLiteral(resourceName: "weatherImageName")
            cell.weatherImage.image =  UIImage(named: "\(weatherImageName ?? "noImage")")
            return cell
        }
        
        if indexPath.row == 3 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AQICollectionViewCell", for: indexPath) as! AQICollectionViewCell
            
            cell.layer.cornerRadius = 5.0
            cell.layer.shadowOpacity = 0.3
            cell.layer.shadowRadius = 5
            cell.layer.masksToBounds = false
            
            cell.AQIndexLabel.text = self.aqiString
            cell.AQIDescLabel.text = self.aqiDesc
            cell.AQIRecommendationLabel.text = self.aqiRecommendation
            let AQIInt = Double(self.aqiString ?? "0")
            self.updateAQIProgress(cell: cell, AQI: AQIInt!)
            
            return cell
        }
        
        if indexPath.row == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PollenCollectionViewCell", for: indexPath) as! PollenCollectionViewCell
            
            cell.layer.cornerRadius = 5.0
            cell.layer.shadowOpacity = 0.3
            cell.layer.shadowRadius = 5
            cell.layer.masksToBounds = false
            
            cell.treePollenIndexLabel.text = self.treePollenIndex
            cell.treeDescLabel.text = self.treePollenDesc
            cell.WeedPollenIndexLabel.text = self.weedPollenIndex
            cell.weedDescLabel.text = self.weedPollenDesc
            
            return cell
        }
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ForecastCollectionViewCell", for: indexPath) as! ForecastCollectionViewCell
        
        cell.layer.cornerRadius = 5.0
        cell.layer.shadowOpacity = 0.3
        cell.layer.shadowRadius = 5
        cell.layer.masksToBounds = false

        cell.firstDayLabel.text = self.forecastDate1
        cell.firstImage.image = UIImage(named: "\(forecastImage1 ?? "noImage")")
        cell.firstTempLabel.text = String("\(self.forecastMin1 ?? "?")°~\(self.forecastMax1 ?? "?")°")
        cell.firstDescLabel.text = self.forecastDesc1?.capitalized
        
        cell.SecondDayLabel.text = self.forecastDate2
        cell.secondImage.image = UIImage(named: "\(forecastImage2 ?? "noImage")")
        cell.secondTempLabel.text = String("\(self.forecastMin2 ?? "?")°~\(self.forecastMax2 ?? "?")°")
        cell.decondDescLabel.text = self.forecastDesc2?.capitalized
        
        cell.thirdDayLabel.text = self.forecastDate3
        cell.thirdImage.image = UIImage(named: "\(forecastImage3 ?? "noImage")")
        cell.thirdTempLabel.text = String("\(self.forecastMin3 ?? "?")°~\(self.forecastMax3 ?? "?")°")
        cell.thirdDescLabel.text = self.forecastDesc3?.capitalized
        
        return cell
    }
    
    
    
}

extension HomeViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationManagerDidChangeAuthorization(manager)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            print("current location lat \(lat)")
            print("current location lng \(lon)")
            weatherManager.fecthWeatherLocation( latitude: lat, longitude: lon)
            forecastManager.fecthForecastLocation(latitude: lat, longitude: lon)
            aqiManager.fecthAQILocation(latitude: lat, longitude: lon)
            pollenManager.fecthPollenLocation(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print("location error:", error)
        
    }
    
}
