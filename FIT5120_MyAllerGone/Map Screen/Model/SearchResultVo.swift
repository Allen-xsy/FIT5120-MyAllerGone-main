//
//  SearchResultVo.swift
//  HospitalLocation
//
//  Created by 夏舒衍 on 2021/3/30.
//

import Foundation

struct PlaceLocationVo: Codable {
    var lat: Double?
    var lng: Double?
}

struct PlaceGeometryVo: Codable {
    var location: PlaceLocationVo?
}

struct PlaceSearchPhotoVo: Codable {
    var height: Int?
    var width: Int?
    var photo_reference: String?
}

struct PlaceSearchItemVo: Codable {
    var name: String?
    var vicinity: String?
    var rating: Double?
    var user_ratings_total: Int?
    var geometry: PlaceGeometryVo?
    var photos: [PlaceSearchPhotoVo]?
}

struct PlaceSearchVo: Codable {
    var status: String?
    var results: [PlaceSearchItemVo]?
}


struct PlaceDetailVo: Codable {
    var status: String?
    var result: PlaceSearchItemVo?
}
