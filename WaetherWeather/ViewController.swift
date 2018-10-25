//
//  ViewController.swift
//  WaetherWeather
//
//  Created by Kaleb Allen on 10/24/18.
//  Copyright © 2018 Kaleb Allen. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let apiKeys = APIKeys()
        
        let darkSkyURL = "https://api.darksky.net/forecast/"
        
        let darkSkyKey = apiKeys.darkSkyKey
        
        let latitude = "37.004842"
        
        let longitude = "-85.925876"
        
        let url = darkSkyURL + darkSkyKey + "/" + latitude + "+" + longitude
        
        let request = Alamofire.request(url)
        request.responseJSON {  response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    let googleBaseURL = "https://maps.googleapis.com/maps/api/geocode/json?address="
        let googleRequestURL = googleBaseURL + "Glasgow,+Kentucky" + "&key=" + apiKeys.googleKey
        
        let googleRequest = Alamofire.request(googleBaseURL)
        
        googleRequest.responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    
    
    
    }
}

