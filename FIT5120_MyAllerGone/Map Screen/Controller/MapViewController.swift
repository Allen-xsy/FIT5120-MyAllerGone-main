//
//  MapViewController.swift
//  HospitalLocation
//
//  Created by 夏舒衍 on 2021/3/30.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    public var hospital: PlaceSearchItemVo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.showsUserLocation = true
        navigationItem.title = hospital?.name
        
        if let lat = hospital?.geometry?.location?.lat, let lon = hospital?.geometry?.location?.lng {
            mapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: lon), latitudinalMeters: 2000, longitudinalMeters: 2000), animated: true)
            
            let annotation = MKPointAnnotation()
            annotation.title = hospital?.name
            annotation.subtitle = hospital?.vicinity
            annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)

            mapView.showAnnotations([annotation], animated: true)
            
        } else {
            mapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: kDefaultLatitude, longitude: kDefaultLongitude), latitudinalMeters: 2000, longitudinalMeters: 2000), animated: true)
        }
    }

}
