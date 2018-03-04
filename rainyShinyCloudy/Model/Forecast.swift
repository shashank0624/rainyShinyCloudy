//
//  Forecast.swift
//  rainyShinyCloudy
//
//  Created by Kirti Ahlawat on 24/02/18.
//  Copyright © 2018 xyz. All rights reserved.
//

import UIKit
import Alamofire

class Forecast{
    private var _date: String!
    private var _weatherType: String!
    private var _highTemp: String!
    private var _lowTemp: String!
    
    
    var date: String{
        if _date == nil{
            _date = ""
        }
        return _date
    }
    
    var wheatherType: String{
        if _weatherType == nil{
            _weatherType = ""
        }
        return _weatherType
    }
    
    var highTemp: String{
        if _highTemp == nil{
            _highTemp = ""
        }
        return _highTemp
    }
    
    var lowTemp : String{
        if _lowTemp == nil{
            _lowTemp = ""
        }
        return _lowTemp
    }
    
    init(weatherDict: Dictionary<String,Any>){
        if let main = weatherDict["main"] as? Dictionary<String, Any>{
            if let temp_Max = main["temp_max"] as? Double{
                let kelvinToFarenheitPreDivision = (temp_Max * (9/5) - 459.67)
                let kelvinToFarenheit = Double(round(10 * kelvinToFarenheitPreDivision/10))
                self._highTemp = "\(kelvinToFarenheit)"
            }
            
            if let temp_min = main["temp_min"] as? Double{
                let kelvinToFarenheitPreDivision = (temp_min * (9/5) - 459.67)
                let kelvinToFarenheit = Double(round(10 * kelvinToFarenheitPreDivision/10))
                self._lowTemp = "\(kelvinToFarenheit)"
            }
        }
        
        if let weather = weatherDict["weather"] as? [Dictionary<String,Any>]{
            if let main = weather[0]["main"] as? String{
                self._weatherType = main
            }
        }
        
        if let date = weatherDict["dt"] as? Double{
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            self._date = unixConvertedDate.dayOfTheWeek()
        }
    }
}

extension Date{
    func dayOfTheWeek() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d,yyyy HH:mm"
        return dateFormatter.string(from: self)
    }
}
