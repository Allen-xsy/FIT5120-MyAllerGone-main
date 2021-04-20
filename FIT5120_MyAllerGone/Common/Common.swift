//
//  Common.swift
//  HospitalLocation
//
//  Created by 夏舒衍 on 2021/3/30.
//

import Foundation
import UIKit

// Google Api Key
let kGoogleApiKey = "AIzaSyA58AGEbiSrppXfA9kmSvu0907KhEddBeY"

// Default Longitude
let kDefaultLongitude = 145.136215

// Default Latitude
let kDefaultLatitude = -37.910522


// Create Search Place String URL
// - Parameters:
//   - longitude: longitude
//   - latitude: latitude
//   - radius: radius, default 3000
// - Returns: String URL
func searchPlaceUrl(for longitude: Double, latitude: Double, radius: Int = 3000) -> String {
    return "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(latitude),\(longitude)&radius=\(radius)&type=hospital&keyword=emergency&key=\(kGoogleApiKey)"
}

/// Google Maps Geocoding
/// - Parameter address: address
/// - Returns: URL
func googleMapsGeocoding(for address: String) -> String {
    return "https://maps.googleapis.com/maps/api/geocode/json?address=\(address)&key=\(kGoogleApiKey)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? "'"
}




// Create image String URL
// - Parameter reference: reference
// - Returns: String URL
func imageUrl(for reference: String) -> String {
    return "https://maps.googleapis.com/maps/api/place/photo?maxwidth=1000&photoreference=\(reference)&key=\(kGoogleApiKey)"
}
