//
//  weatherVC.swift
//  rainyShinyCloudy
//
//  Created by Kirti Ahlawat on 11/02/18.
//  Copyright © 2018 xyz. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class WeatherVC: UIViewController , UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate{

    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var currentTempLbl: UILabel!
    @IBOutlet weak var currentLocationLbl: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWheatherTypeLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var locationManager = CLLocationManager()
    var currentLocation : CLLocation?
    
    var currentweather = CurrentWeather()
    var forecast : Forecast!
    var forecasts = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
//        locationManager.stopMonitoringSignificantLocationChanges()
        locationAuthStatus()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
    }
    
    func locationAuthStatus(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            
        }else{
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func downloadForecastData(completed: @escaping DownloadComplete){
        let forecastURL = URL(string: FORECAST_WEATHER_URL)!
        Alamofire.request(forecastURL).responseJSON { (response) in
            let result = response.result
            print("Result: \(result)")
            if let dict = result.value as? Dictionary<String,Any>{
                if let list = dict["list"] as? [Dictionary<String,Any>]{
                    for obj in list{
                        self.forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(self.forecast)
                    }
                    completed()
                }
            }
        }
    }

    //MARK:- TABLE VIEW DELEGATE AND DATA SOURCE METHODS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? WeatherCell{
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            return cell
        }
        return WeatherCell()
    }
    
    func updateMainUI(){
        currentLocationLbl.text = self.currentweather.cityName
        currentTempLbl.text = "\(self.currentweather.currentTemp)"
        currentWheatherTypeLbl.text = self.currentweather.weatherType
        dateLbl.text = self.currentweather.date
        currentWeatherImage.image = UIImage(named: self.currentweather.weatherType)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            print("Authorized when in use")
            currentLocation = manager.location
            print("\(currentLocation?.coordinate.latitude),\(currentLocation?.coordinate.longitude)")
            if let latitude = currentLocation?.coordinate.latitude{
                Location.sharedInstance.latitude = latitude
            }else{
                Location.sharedInstance.latitude = 0.0
            }
            
            if let longitude = currentLocation?.coordinate.longitude{
                Location.sharedInstance.longitude = longitude
            }else{
                Location.sharedInstance.longitude = 0.0
            }
            
            print("Current Weather API URL :\(CURRENT_WEATHER_URL)")
            currentweather.downloadWeatherDetails {
                print("Download1 Completed")
                self.updateMainUI()
                self.downloadForecastData {
                    self.tableView.reloadData()
                    print("Download2 Completed")
                }
            }
        default:
            print("Not authorized")
        }
    }
}

