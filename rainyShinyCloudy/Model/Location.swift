//
//  Location.swift
//  rainyShinyCloudy
//
//  Created by Kirti Ahlawat on 25/02/18.
//  Copyright © 2018 xyz. All rights reserved.
//

import Foundation

class Location{
    static var sharedInstance = Location()
    
    private init(){}
    
    var latitude : Double!
    var longitude : Double!
}
