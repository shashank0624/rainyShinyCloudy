//
//  weatherVC.swift
//  rainyShinyCloudy
//
//  Created by Kirti Ahlawat on 11/02/18.
//  Copyright © 2018 xyz. All rights reserved.
//

import UIKit

class WeatherVC: UIViewController , UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var currentTempLbl: UILabel!
    @IBOutlet weak var currentLocationLbl: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWheatherTypeLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var currentweather = CurrentWeather()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Current Weather API URL :\(CURRENT_WEATHER_URL)")
        currentweather.downloadWeatherDetails {
            print("Download Completed")
            self.currentLocationLbl.text = self.currentweather.cityName
            self.currentTempLbl.text = "\(self.currentweather.currentTemp)"
            self.currentWheatherTypeLbl.text = self.currentweather.weatherType
            self.dateLbl.text = self.currentweather.date
        }
    }


    //MARK:- TABLE VIEW DELEGATE AND DATA SOURCE METHODS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
}

