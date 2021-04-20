//
//  AddressSearchVo.swift
//  FIT5120_MyAllerGone
//
//  Created by 夏舒衍  on 2021/4/20.
//

import Foundation

struct AddressSearchItemGeometryVo: Codable {
    var location: PlaceLocationVo?
}

struct AddressSearchItemVo: Codable {
    var formatted_address: String?
    var geometry: AddressSearchItemGeometryVo?
}

struct AddressSearchVo: Codable {
    var status: String?
    var results: [AddressSearchItemVo]?
}
