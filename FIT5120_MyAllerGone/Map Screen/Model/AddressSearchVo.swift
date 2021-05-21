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

class AddressSearchItemVo: Codable {
    var geometry: AddressSearchItemGeometryVo?
    
    var description: String?
    var place_id: String?
}

struct AddressSearchVo: Codable {
    var status: String?
    var predictions: [AddressSearchItemVo]?
}
