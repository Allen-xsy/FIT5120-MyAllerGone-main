//
//  HospitalListController.swift
//  HospitalLocation
//
//  Created by 夏舒衍 on 2021/3/30.
//

import UIKit
import CoreLocation
import MapKit

class HospitalListController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var headerView: UIView!
    @IBOutlet weak var locationLabel: UILabel!
    
    var longtitude:Double?
    var latitude:Double?
    
    var dataSource: [PlaceSearchItemVo] = []
    
    ///  coder
    lazy var geocoder: CLGeocoder = {
        let object = CLGeocoder()
        return object
    }()
    
    var userLocation: CLLocation? {
        didSet {
            guard let value = userLocation else {
                locationLabel.text = "21 Chancellor Walk, Clayton, Melbourne, Victoria, 3168"
                return
            }
            geocoder.reverseGeocodeLocation(value) {[weak self] (places, error) in
                guard let strong_self = self else {
                    self?.locationLabel.text = "-"
                    return
                }
                
                guard let place = places?.first else {
                    strong_self.locationLabel.text = "-"
                    return
                }
                
                strong_self.locationLabel.text = "\(place.name ?? "") \(place.thoroughfare ?? "") \(place.subLocality ?? "") \(place.locality ?? "") \(place.administrativeArea ?? "")"
            }
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    // Pull Refresh
    fileprivate lazy var headerRefresh: UIRefreshControl = {
        let object = UIRefreshControl()
        object.attributedTitle = NSAttributedString(string: "Refreshing...")
        object.addTarget(self, action: #selector(headerRefreshAction), for: UIControl.Event.valueChanged)
        return object
    }()
    
    
    // Location Manager
    fileprivate lazy var manager: CLLocationManager = {
        let object = CLLocationManager()
        object.delegate = self
        object.desiredAccuracy = kCLLocationAccuracyBest;
        object.distanceFilter = kCLDistanceFilterNone;
        object.allowsBackgroundLocationUpdates = false;
        object.pausesLocationUpdatesAutomatically = false;
        return object
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        tableView.addSubview(headerRefresh)
        tableView.register(UINib(nibName: "HospitalTableViewCell", bundle: nil), forCellReuseIdentifier: "HospitalTableViewCell")
        tableView.tableFooterView = UIView()
        view.setNeedsLayout()
        
        // Add &params={"lat":纬度,"lon":经度} in Appetize link to costom user location
        let paramsLat = UserDefaults.standard.object(forKey: "lat") as? Double
        let paramsLon = UserDefaults.standard.object(forKey: "lon") as? Double
        if let isAppetize = UserDefaults.standard.object(forKey: "isAppetize") as? Bool, isAppetize == true {
            let lat = paramsLat ?? -37.911706
            let lon = paramsLon ?? 145.132430
            longtitude = lon
            latitude = lat
        }

        let emergencyAlert = UIAlertController(title: "", message: "Please call 000 in case of emergency", preferredStyle: .alert)
        emergencyAlert.addAction(UIAlertAction(title: "Understood", style: .default, handler: { (_) in
            self.checkLocationAuth()
        }))
        self.present(emergencyAlert, animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.tabBarItem.selectedImage = UIImage(named: "location_click")
    }

    // Refresh Action
    @objc private func headerRefreshAction() {
        self.requestNearHospital()
    }
    
    // Check location Auth
    private func checkLocationAuth() {
        if !CLLocationManager.locationServicesEnabled() {
            return
        }
        
        let status: CLAuthorizationStatus = CLLocationManager.authorizationStatus()
        
        switch status {
        case .notDetermined:
            self.manager.requestWhenInUseAuthorization()
            break
        case .restricted, .denied:
            let alertController = UIAlertController(title: "", message: "This app don't has authorization to use your location~", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "I Know", style: .default, handler: {[weak self] (_) in
                DispatchQueue.main.async {
                    self?.userLocation = CLLocation(latitude: kDefaultLatitude, longitude: kDefaultLongitude)
                    self?.headerRefresh.beginRefreshing()
                    self?.requestNearHospital()
                }
            }))
            present(alertController, animated: true, completion: nil)
            break
        case .authorizedAlways, .authorizedWhenInUse:
            self.manager.startUpdatingLocation()
            break
        @unknown default:
            break
        }
    }
    
    // Load near Hospital
    func requestNearHospital() {
        
        dataSource.removeAll()
        tableView.reloadData()
        
        var lon = kDefaultLongitude
        var lat = kDefaultLatitude
        if let value = self.userLocation {
            lon = value.coordinate.longitude
            lat = value.coordinate.latitude
        }
        if lon == 0{
            lon = longtitude ?? 145.132430
        }
        if lat == 0{
            lat = latitude ?? -37.911706
        }
        view.isUserInteractionEnabled = false;
        NetworkManager.loadData(urlString: searchPlaceUrl(for: lon, latitude: lat), type: PlaceSearchVo.self) {[weak self] (success, searchResult) in
            self?.headerRefresh.endRefreshing()
            self?.view.isUserInteractionEnabled = true
            guard let strong_self = self else {
                return
            }
            
            guard var value = searchResult?.results else {
                return
            }
            
            // Sort By distance
            value.sort { (item1, item2) -> Bool in
                if let lat1 = item1.geometry?.location?.lat, let lon1 = item1.geometry?.location?.lng, let lat2 = item2.geometry?.location?.lat, let lon2 = item2.geometry?.location?.lng {
                    let location1 = CLLocation(latitude: lat1, longitude: lon1)
                    let location2 = CLLocation(latitude: lat2, longitude: lon2)
                    let current = CLLocation(latitude: lat, longitude: lon)
                    return location1.distance(from: current) < location2.distance(from: current)
                }
                return true
                
            }
            
            strong_self.dataSource = value
            strong_self.tableView.tableHeaderView = strong_self.dataSource.count > 0 ? strong_self.headerView : nil
            strong_self.tableView.reloadData()
        }
        
    }
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HospitalTableViewCell", for: indexPath) as! HospitalTableViewCell
        
        var lon = kDefaultLongitude
        var lat = kDefaultLatitude
        if let value = self.userLocation {
            lon = value.coordinate.longitude
            lat = value.coordinate.latitude
        }
        
        let location = CLLocation(latitude: lat, longitude: lon)
        
        cell.configCell(searchResult: dataSource[indexPath.row], location: location)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let lati = (dataSource[indexPath.row].geometry?.location?.lat)!
        let long = (dataSource[indexPath.row].geometry?.location?.lng)!
        let name = dataSource[indexPath.row].name!
        jumpToAppleMapNavigation(lat:lati,lng: long,hospitalName: name)
        //performSegue(withIdentifier: "showMapController", sender: dataSource[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMapController" {
            guard let mapController = segue.destination as? MapViewController, let hospital = sender as? PlaceSearchItemVo else {
                return
            }
            mapController.hospital = hospital
        }
    }

}

extension HospitalListController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let value = locations.first {
            if let current = self.userLocation {
                let distance = value.distance(from: current)
                /// 100 m
                if distance < 100 {
                    return
                }
            }
            self.userLocation = value
            DispatchQueue.main.async {
                self.headerRefresh.beginRefreshing()
                self.requestNearHospital()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        let alertController = UIAlertController(title: "", message: "Update location failure", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "I Know", style: .default, handler: {[weak self] (_) in
            DispatchQueue.main.async {
                self?.headerRefresh.beginRefreshing()
                self?.requestNearHospital()
            }
        }))
        present(alertController, animated: true, completion: nil)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuth()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuth()
    }
}

extension HospitalListController: MKMapViewDelegate{
    func jumpToAppleMapNavigation(lat:Double,lng:Double,hospitalName:String){
        //refer to https://youtu.be/INfCmCxLC0o
        let coordinates = CLLocationCoordinate2DMake(lat,lng)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: 1000, longitudinalMeters: 1000)
        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
        let placemark = MKPlacemark(coordinate: coordinates)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = hospitalName
        mapItem.openInMaps(launchOptions: options)
        
    }
}
