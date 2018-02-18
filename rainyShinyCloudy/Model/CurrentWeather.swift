//
//  CurrentWeather.swift
//  rainyShinyCloudy
//
//  Created by Kirti Ahlawat on 18/02/18.
//  Copyright © 2018 xyz. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather{
    private var _cityName:String?
    private var _date:String?
    private var _weatherType: String?
    private var _currentTemp: Double?
    
    var cityName: String{
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName!
    }
    
    var date: String{
        if _date == nil{
            _date = ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        let currentdate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentdate)"
        return _date!
    }
    
    var weatherType : String{
        if _weatherType == nil{
            _weatherType = ""
        }
        return _weatherType!
    }
    
    var currentTemp: Double{
        if _currentTemp == nil{
            _currentTemp = 0.0
        }
        return _currentTemp!
    }
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete){
        let currentWeatherUrl = URL(string: CURRENT_WEATHER_URL)!
        Alamofire.request(currentWeatherUrl).responseJSON{ response in
            let result = response.result
            print("Status : \(result)")
            if let dict = response.value as? Dictionary<String,Any>{
                if let name = dict["name"] as? String{
                    self._cityName = name
                    print("\(self._cityName!)")
                }
                
                if let weather = dict["weather"] as? [Dictionary<String,Any>]{
                    if let main = weather[0]["main"] as? String{
                        self._weatherType = main
                        print("\(self._weatherType!)")
                    }
                }
                
                if let main = dict["main"] as? Dictionary<String,Any>{
                    if let currentTemperature = main["temp"] as? Double{
                        let kelvinToFarenheitPreDivision = (currentTemperature * (9/5) - 459.67)
                        let kelvinToFarenheit = Double(round(10 * kelvinToFarenheitPreDivision/10))
                        self._currentTemp = kelvinToFarenheit
                        print("\(self._currentTemp!)")
                    }
                }
            }
            completed()
        }
        
    }
}
