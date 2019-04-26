//
//  DayForecast.swift
//  WeatherApp
//
//  Created by emile on 11/04/2019.
//  Copyright © 2019 emile. All rights reserved.
//

import Foundation

struct DayForecast: Codable {
	
	let dt_txt: String
	let main: Temperature
	let weather: [Weather]
	let wind: Wind
}
