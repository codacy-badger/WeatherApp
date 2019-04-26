//
//  Temperature.swift
//  WeatherApp
//
//  Created by emile on 11/04/2019.
//  Copyright © 2019 emile. All rights reserved.
//

import Foundation

struct Temperature: Codable {
	
	let temp: Float
	let temp_min: Float
	let temp_max: Float
	
	let humidity: Int
	
	let pressure: Float
	let sea_level: Float
	let grnd_level: Float
}
