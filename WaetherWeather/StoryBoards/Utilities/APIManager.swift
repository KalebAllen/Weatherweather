//
//  APIManager.swift
//  WaetherWeather
//
//  Created by Kaleb Allen on 10/29/18.
//  Copyright © 2018 Kaleb Allen. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class APIManager {
    private let darkSkyURL = "https://api.darksky.net/forecast/"
    private let googleBaseURL = "https://maps.googleapis.com/maps/api/geocode/json?address="
    private let apiKeys = APIKeys()
    enum APIErrors: Error {
        case noData
        case noResponse
        case invalidData
    }
    func getWeather(latitude: Double, longitude: Double, onCompletion: @escaping (WeatherData?, Error?) -> Void) {
        let url = darkSkyURL + apiKeys.darkSkyKey + "/" + "\(latitude)" + "," + "\(longitude)"
        let request = Alamofire.request(url)
        request.responseJSON { response in
            switch response.result {
            case .success(let value):
            let json = JSON(value)
            print(json)
            if let weatherData = WeatherData(json: json)
            {
                onCompletion(weatherData, nil)
            } else {
                onCompletion(nil, APIErrors.invalidData)
                }
            case .failure(let error):
                onCompletion(nil, error)
            }
        }
    }
    func geocode(address: String, onCompletion: @escaping (GeoCoding?, Error?) -> Void) {
        let url = googleBaseURL + address + "&key=" + apiKeys.googleKey
        
        let request = Alamofire.request(url)
        
        request.responseJSON { response in switch response.result {
        case .success(let value):
            let json = JSON(value)
            print(json)
            if let geocodingData = GeoCoding(json: json) {
                onCompletion(geocodingData, nil)
            } else {
                onCompletion(nil, APIErrors.invalidData)
            }
        case.failure(let error):
            onCompletion(nil, error)
            }
        }
    }
}
