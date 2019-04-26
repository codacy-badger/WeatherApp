//
//  Forecast.swift
//  WeatherApp
//
//  Created by emile on 11/04/2019.
//  Copyright © 2019 emile. All rights reserved.
//

import Foundation

struct Forecast: Codable {
	
	let city: City
	let list: [DayForecast]
}
