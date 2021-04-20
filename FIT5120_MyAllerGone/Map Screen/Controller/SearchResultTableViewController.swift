//
//  SearchResultTableViewController.swift
//  FIT5120_MyAllerGone
//
//  Created by 夏舒衍  on 2021/4/20.
//

import UIKit
import MapKit

class SearchResultTableViewController: UITableViewController {
    
    var dataSource: [PlaceSearchItemVo] = []
    
    /// location
    public var location: AddressSearchItemVo?
    
    // Pull Refresh
    fileprivate lazy var headerRefresh: UIRefreshControl = {
        let object = UIRefreshControl()
        object.attributedTitle = NSAttributedString(string: "Refreshing...")
        object.addTarget(self, action: #selector(headerRefreshAction), for: UIControl.Event.valueChanged)
        return object
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "HospitalTableViewCell", bundle: nil), forCellReuseIdentifier: "HospitalTableViewCell")
        tableView.tableFooterView = UIView()
        tableView.addSubview(headerRefresh)
        
        self.headerRefresh.beginRefreshing()
        self.requestNearHospital()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // Refresh Action
    @objc private func headerRefreshAction() {
        self.requestNearHospital()
    }
    
    // Load near Hospital
    func requestNearHospital() {
        
        dataSource.removeAll()
        tableView.reloadData()
        
        if let lat = location?.geometry?.location?.lat, let lon = location?.geometry?.location?.lng {
            view.isUserInteractionEnabled = false;
            NetworkManager.loadData(urlString: searchPlaceUrl(for: lon, latitude: lat), type: PlaceSearchVo.self) {[weak self] (success, searchResult) in
                self?.headerRefresh.endRefreshing()
                self?.view.isUserInteractionEnabled = true
                guard let strong_self = self else {
                    return
                }
                
                guard let value = searchResult?.results, value.count > 0 else {
                    return
                }
                strong_self.dataSource = value
                strong_self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HospitalTableViewCell", for: indexPath) as! HospitalTableViewCell
        
        let value  = dataSource[indexPath.row]
        
        if let lat = value.geometry?.location?.lat, let lon = value.geometry?.location?.lat {
            cell.configCell(searchResult: dataSource[indexPath.row], location: CLLocation(latitude: lat, longitude: lon))
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let value  = dataSource[indexPath.row]
        
        if let lat = value.geometry?.location?.lat, let lon = value.geometry?.location?.lat {
            jumpToAppleMapNavigation(lat:lat,lng: lon, hospitalName: value.name ?? "")
        }
    }
    
}

extension SearchResultTableViewController: MKMapViewDelegate{
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
