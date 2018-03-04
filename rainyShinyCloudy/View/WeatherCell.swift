//
//  WeatherCell.swift
//  rainyShinyCloudy
//
//  Created by Kirti Ahlawat on 24/02/18.
//  Copyright © 2018 xyz. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    
    @IBOutlet weak var weatherTypeImageView: UIImageView!
    @IBOutlet weak var dayTimeLbl: UILabel!
    @IBOutlet weak var weatherTypeLbl: UILabel!
    @IBOutlet weak var maxTempLbl: UILabel!
    @IBOutlet weak var minTempLbl: UILabel!
    
    func configureCell(forecast: Forecast){
        dayTimeLbl.text = forecast.date
        weatherTypeLbl.text = forecast.wheatherType
        maxTempLbl.text = forecast.highTemp
        minTempLbl.text = forecast.lowTemp
        weatherTypeImageView.image = UIImage(named: forecast.wheatherType)
    }

}
