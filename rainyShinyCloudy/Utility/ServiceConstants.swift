//
//  ServiceConstants.swift
//  rainyShinyCloudy
//
//  Created by Kirti Ahlawat on 18/02/18.
//  Copyright © 2018 xyz. All rights reserved.
//

import Foundation


let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let LATTITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let API_KEY = "507bca28e97479e3e269a2250a6fdcf9"

typealias DownloadComplete = () -> ()

let CURRENT_WEATHER_URL = "\(BASE_URL)\(LATTITUDE)39\(LONGITUDE)128\(APP_ID)\(API_KEY)"
