//
//  WeatherDisplay.swift
//  WaetherWeather
//
//  Created by Kaleb Allen on 10/24/18.
//  Copyright © 2018 Kaleb Allen. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class WeatherDisplay: UIViewController {
    @IBOutlet weak var LocationLable: UILabel!
    @IBOutlet weak var iConLable: UILabel!
    @IBOutlet weak var TempLable: UILabel!
    @IBOutlet weak var HighTempLable: UILabel!
    @IBOutlet weak var LowTempLable: UILabel!
    
    var displayWeatherData: WeatherData! {
        didSet {
            iConLable.text = displayWeatherData.condition.icon
            TempLable.text = "\(displayWeatherData.temp)º"
            HighTempLable.text = "\(displayWeatherData.HighTemp)º"
            LowTempLable.text = "\(displayWeatherData.LowTemp)ø"
        }
    }
    
    var displayGeocodingData: GeoCoding! {
    didSet {
        LocationLable.text = displayGeocodingData.formattedAddress
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDefaultUI()
    }
    
    func setUpDefaultUI() {
        LocationLable.text = "Seacrch a location"
        iConLable.text = "🐲"
        TempLable.text = "º"
        HighTempLable.text = "Hº"
        LowTempLable.text = "Lº"
        
    }
    
    @IBAction func unwindToWeatherDisplay(segue: UIStoryboardSegue){ }
}


