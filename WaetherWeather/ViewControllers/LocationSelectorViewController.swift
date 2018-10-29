//
//  LocationSelectorViewController.swift
//  WaetherWeather
//
//  Created by Kaleb Allen on 10/26/18.
//  Copyright © 2018 Kaleb Allen. All rights reserved.
//

import UIKit

class LocationSelectorViewController: UIViewController, UISearchBarDelegate {
    @IBOutlet weak var LocationSearch: UISearchBar!
    
    let apiManager = APIManager()
    var geocodingData: GeoCoding?
    var weatherData: WeatherData?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LocationSearch.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func handlerError() {
        geocodingData = nil
        weatherData = nil
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchAddress = searchBar.text? .replacingOccurrences(of: " ", with: "+") else {
            return
        }
        retrieveGeocodingData(searchAddress: searchAddress)
    }

    
    func retrieveGeocodingData(searchAddress: String) {
        apiManager.geocode(address: searchAddress) { (geocodingData, error) in
            if let recievedError = error {
                print(recievedError.localizedDescription)
                self.handlerError()
                return
            }
            if let recivedData = geocodingData {
                self.geocodingData = recivedData
                self.retrivedWeatherData(latitude: recivedData.latitude, longitude: recivedData.longitude)
            } else {
                self.handlerError()
                return
            }
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    func retrivedWeatherData(latitude: Double, longitude: Double) {
        apiManager.getWeather(latitude: latitude, longitude: longitude) {
            (weatherData, error) in
            if let recivedError = error {
                print(recivedError.localizedDescription)
                self.handlerError()
                return
            }
            if let recivedData = weatherData {
                self.weatherData = recivedData
                self.performSegue(withIdentifier: "unwindToWeatherDisplay", sender: self)
            } else {
                self.handlerError()
                return
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? WeatherDisplay, let retrievedGeocodingData = geocodingData, let retrievedWeatherData = weatherData {
            destinationVC.displayGeocodingData = retrievedGeocodingData
            destinationVC.displayWeatherData = retrievedWeatherData
        }
    }
}
