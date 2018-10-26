//
//  WeatherData.swift
//  WaetherWeather
//
//  Created by Kaleb Allen on 10/26/18.
//  Copyright © 2018 Kaleb Allen. All rights reserved.
//

import Foundation
import SwiftyJSON
class WeatherData {
    //MARK:-) Types
    enum Condition: String {
        case clearDay = "clear-day"
        case clearNight = "clear-night"
        case rain = "rain"
        case snow = "snow"
        case sleet = "sleet"
        case wind = "wind"
        case fog = "fog"
        case cloudy = "cloudy"
        case partlyCloudyDay = "partly-cloudy-day"
        case partlyCloudyNight = "partly-cloudy-night"
        
        var icon: String {
            switch self {
            case .clearDay:
                return "☀️"
            case .clearNight:
                return "🌑"
            case .rain:
                return "🌧"
            case .snow:
                return "❄️"
            case .sleet:
                return "🌧❄️"
            case .wind:
                return "🌬"
            case .fog:
                return "🌫"
            case .cloudy:
                return "⛅️"
            case .partlyCloudyDay:
                return "🌤"
            case .partlyCloudyNight:
                return "🌑☁️"
            }
        }
    }
    
    
    enum WeatherDataKeys: String {
        case currnetly = "currently"
        case temperature = "temperature"
        case icon = "icon"
        case daily = "daily"
        case data = "data"
        case temperatureHigh = "temperatureHigh"
        case temperatureLow = "temperatureLow"
    }
    
    
    //MARK:-) Properties
    let temp: Double
    let HighTemp: Double
    let LowTemp: Double
    let Condition: Condition
    
    //MARK:-) Meathods
    init(temp: Double, HighTemp: Double, LowTemp: Double, Condition: Condition) {
        self .temp = temp
        self .HighTemp = HighTemp
        self .LowTemp = LowTemp
    }
    
    convenience init?(json: JSON) {
        guard let temperature = json[WeatherDataKeys.currnetly.rawValue][WeatherDataKeys.temperature.rawValue].double else {
            return nil
        }
        guard let highTemperature = json[WeatherDataKeys.daily.rawValue][WeatherDataKeys.data.rawValue][0][WeatherDataKeys.temperatureHigh.rawValue].double else {
            return nil
        }
        guard let lowTemperature = json[WeatherDataKeys.daily.rawValue][WeatherDataKeys.data.rawValue][0][WeatherDataKeys.temperatureLow.rawValue].double else {
            return nil
        }
        guard let conditionString = json[WeatherDataKeys.currnetly.rawValue][WeatherDataKeys.icon.rawValue].string else {
            return nil
        }
        guard let condition = condition(rawValue: conditionString) else {
            return nil
        }
        //Since we were able to pull all the data we needed from JSON, we are going to make a new instance of the WeatherData class, so call 
        self.init(temperature: temperature, highTemperature: highTemperature, lowTemperature: lowTemperature, Condition: condition)
        
    }
    
}
