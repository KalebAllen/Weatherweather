//
//  GeoCoding.swift
//  WaetherWeather
//
//  Created by Kaleb Allen on 10/26/18.
//  Copyright © 2018 Kaleb Allen. All rights reserved.
//

import Foundation
import SwiftyJSON

class GeoCoding {
    enum GeocodingDataKeys: String {
        case results = "results"
        case formattedAddress = "formatted_address"
        case geometry = "geometry"
        case location = "location"
        case latitude = "lat"
        case longitude = "lng"
    }
    var formattedAddress: String
    var latitude: Double
    var longitude: Double
    
    init(formattedAddress: String, latitude: Double, longitude: Double) {
        self.formattedAddress = formattedAddress
        self.latitude = latitude
        self.longitude = longitude
    }
    convenience init?(json: JSON) {
        guard let results = json[GeocodingDataKeys.results.rawValue].array else {
            return nil
        }
        guard let formattedAddress = results[0][GeocodingDataKeys.formattedAddress.rawValue].string else {
            return nil
        }
        guard let latitude = results[0][GeocodingDataKeys.geometry.rawValue][GeocodingDataKeys.location.rawValue][GeocodingDataKeys.latitude.rawValue].double else {
            return nil
        }
        guard let longitude = results[0][GeocodingDataKeys.geometry.rawValue][GeocodingDataKeys.location.rawValue][GeocodingDataKeys.longitude.rawValue].double else {
            return nil
        }
        self.init(formattedAddress: formattedAddress, latitude: latitude, longitude: longitude)
    }
}
